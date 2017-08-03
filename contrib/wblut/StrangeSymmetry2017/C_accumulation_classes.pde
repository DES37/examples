// An accumulation bin counts the number of hits in a certain area. This area
// is determined by the range of the accumulation grid and its resolution.

// The accumulation allows fractional counts, for example a hit can result in a 0.25/0.75 distribution over two bins.
// This generalisation helps in reducing sharp pixel artefacts in very high density areas.

// The accumulation grid serves two purposes. It collects an array of bins and
// assigns each a certain physical area.
// The physical limits (e.g. -1.0f to 1.0f) are determined by the attractor system.
// The resolution (e.g. 100 by 100 bins) is defined here.

class AccumulationGrid {

  Bin[] values; // bins
  float[] fastCount; // simple bins without fractiobal hits

  Bin maxValues;
  Bin minValues;
  Bin invRangeValues;
  Bin invLogValues;

  GridParameters parameters;

  float idx, idy;// inverse dimensions of bin area

  AccumulationGrid(GridParameters GP) { 
    parameters = GP.get();
    idx=parameters.resX/(parameters.maxVisX-parameters.minVisX);// inverse width of a bin
    idy=parameters.resY/(parameters.maxVisY-parameters.minVisY);// inverse height of a bin
    values = new Bin[parameters.resX*parameters.resY];
    for (int i=0; i<parameters.resX*parameters.resY; i++) {
      values[i] = new Bin();
    }
    fastCount = new float[parameters.resX*parameters.resY];
    maxValues=new Bin();
    minValues=new Bin();
    invRangeValues=new Bin();
    invLogValues=new Bin();
  }

  void reset(boolean resized) {    
    idx=parameters.resX/(parameters.maxVisX-parameters.minVisX);
    idy=parameters.resY/(parameters.maxVisY-parameters.minVisY);
    if (resized) {
      values = new Bin[parameters.resX*parameters.resY];
      for (int i=0; i<parameters.resX*parameters.resY; i++) {
        values[i] = new Bin();
      }
      fastCount = new float[parameters.resX*parameters.resY];
    } else {
      for (int i=0; i<parameters.resX*parameters.resY; i++) {
        values[i].reset();
        fastCount[i]=0;
      }
    }
    maxValues=new Bin();
    minValues=new Bin();
    invRangeValues=new Bin();
    invLogValues=new Bin();
  }

  // The first important part of the accumulation grid is the add method.
  // It converts physical coordinates (for example (-0.5f,0.3f)) to a range of bins.
  // Depending on the rendermode the added value can be spread over adjacent bins.
  // renderMode 0, "fast" : full value in closest bin.
  // renderMode 1, "bilinear" : bilinear interpolation over 4 bins.
  // renderMode 2: "Gaussian" : Gaussian distribution over several bins. The width is determined by
  //   the local normalized logDensity and the focus parameter.


  int index(int i, int j) {
    return(i+parameters.resX*j);
  }

  void add(float x, float y, float c, float h, float s, float b, float sp, float a, int quality, float focus, GaussianConvolutionKernel gck) {

    if ((x>=parameters.minVisX)&&(x<parameters.maxVisX)&&(y>=parameters.minVisY)&&(y<parameters.maxVisY)) {
      float gridfx =(x-parameters.minVisX)*idx;
      float gridfy =(y-parameters.minVisY)*idy;
      int gridX =constrain((gridfx<0f)?1+(int)gridfx:(int)gridfx, 0, parameters.resX-1);
      int gridY = constrain((gridfy<0f)?1+(int)gridfy:(int)gridfy, 0, parameters.resY-1);

      // Density dependent calculation of the spread
      // For low density areas logCount is very small: large spread.
      // High density areas (count>10^rc) have no spread, only bilinear interpolation

      fastCount[index(gridX, gridY)]++;

      int range =0;
      if (quality==2) {
        if (fastCount[index(gridX, gridY)]<10) {// The first few hits in Gaussian mode are used to estimate the local density
          range=-1;
        } else {
          range=max(0, gck.maxRange-(int)(2f*gck.maxRange*FastFunctions.log2(fastCount[index(gridX, gridY)]+1f)*invLogValues.count));
        }
      }


      if ( quality==0) {
        values[index(gridX, gridY)].add(c, h, s, b, sp, a);
        updateStatBins(gridX, gridY);
      } else if (range==0) {
        float residuX=gridfx-gridX;
        float residuY=gridfy-gridY;
        values[index(gridX, gridY)].add(c, h, s, b, sp, a, (1f-residuX)*(1f-residuY));
        updateStatBins(gridX, gridY);
        if (gridX+1<parameters.resX) { 
          values[index(gridX+1, gridY)].add(c, h, s, b, sp, a, residuX*(1f-residuY));
          updateStatBins(gridX+1, gridY);
        }
        if (gridY+1<parameters.resY) { 
          values[index(gridX, gridY+1)].add(c, h, s, b, sp, a, (1f-residuX)*residuY);
          updateStatBins(gridX, gridY+1);
        }
        if ((gridX+1<parameters.resX)&&(gridY+1<parameters.resY)) { 
          values[index(gridX, gridY)].add(c, h, s, b, sp, a, residuX*residuY);
          updateStatBins(gridX+1, gridY+1);
        }
      } else if (range==-1) {
        //do nothing, except add to fastGrid
      } else {
        int lim=gck.limits[range];
        for (int i=-lim; i<lim+1; i++) {
          for (int j=-lim; j<lim+1; j++) {
            if ((X+i>=0)&&(X+i<parameters.resX)&&(Y+j>=0)&&(Y+j<parameters.resY)) {
              //Normalized 2D Gaussian function, the total cumulative value of a hit stays 1 independent of range.
              //This is necessary to ensure that after long runs there's no overexposure of the low density regions
              values[index(gridX+i, gridY+j)].add(c, h, s, b, sp, a, gck.v[gck.maxSize+i][gck.maxSize+j][range]);
              updateStatBins(gridX+i, gridY+j);
            }
          }
        }
      }
    }
  }


  void updateStatBins(int i, int j) {
    maxValues.max(values[index(i, j)]);
    minValues.min(values[index(i, j)]);
    invLogValues.invLog(maxValues, minValues);
    invRangeValues.invRange(maxValues, minValues);
  }

  // This is the second important part, used for displaying the grid. It resamples the accumulation grid
  //  to arbitrary resolution, e.g 200x200 bins to 500x500 pixels or 2000x2000 bins to 1000x1000 pixels.
  //  Both downscaling and upscaling are supported. Non-integer ratios,
  //  e.g. 1.5x1.5 bins per pixel are handled by weighing values for partial overlap, half a bin would add half its value. 
  //  Furthermore the range of the returned values should be independent of the requested resolution. For this the returned values
  //  are averaged over the sampling area.

  ResultBin getValues(int i, int j, int w, int h) {
    float binsPerPixelx = (float)parameters.resX/(float)w;
    float binsPerPixely = (float)parameters.resY/(float)h;  
    float startx=max(0f, i*binsPerPixelx);
    int sx = (int)startx;
    float residusx = 1f-startx+sx;
    float starty=max(0f, j*binsPerPixely);
    int sy = (int)starty;
    float residusy = 1f-starty+sy;
    float endx=startx+binsPerPixelx-0.0001f;
    int ex = (int)endx;
    float residuex = endx-ex;
    float endy=starty+binsPerPixely-0.0001f;
    int ey = (int)endy;
    float residuey = endy-ey; 

    Bin c=new Bin();
    float area=0f; // Running total of the number of bins
    float factorx=0f;
    float factory=0f;
    float phi;

    for (int x=sx; x<ex+1; x++) {
      factorx=1f;
      if (x==sx) factorx=residusx; //Take into account partial overlap of first column of bin
      if (x==ex) factorx=residuex;//Take into account partial overlap of last column of bins
      for (int y=sy; y<ey+1; y++) {
        factory=1f;
        if (y==sy) factory=residusy; //Take into account partial overlap of first row of bins
        if (y==ey) factory=residuey; //Take into account partial overlap of last column of bins
        if ((x<parameters.resX)&&(y<parameters.resY)) {
          phi=factorx*factory*factorx*factory;
          c.add(values[index(x, y)], phi);
          area+=phi;
        }
      }
    }
    //Weighted average value over involved bins, this preserves the range of the values. 
    c.div(area); 
    ResultBin result = new ResultBin();    
    result.rawValues=new Bin(c);
    result.normValues=new Bin(c);
    result.normValues.norm(minValues, invRangeValues);
    result.logNormValues=new Bin(c);
    result.logNormValues.logNorm(minValues, invLogValues);
    result.avgValues=new Bin(c);
    result.avgValues.div(result.rawValues.count);



    return result;
  }
}






class Bin {
  float count;
  float hue;
  float sat;
  float bri;
  float speed;
  float acc;
  float rcount;
  float rhue;
  float rsat;
  float rbri;
  float rspeed;
  float racc;
  Bin() {
  }

  Bin(Bin b) {
    count=b.count; 
    hue=b.hue; 
    sat=b.sat; 
    bri=b.bri; 
    speed=b.speed;
    acc=b.acc;
    rcount=b.count; 
    rhue=b.rhue; 
    rsat=b.rsat; 
    rbri=b.rbri; 
    rspeed=b.rspeed;
    racc=b.racc;
  }

  void add(float c, float h, float s, float b, float sp, float a) {
    count+=c; 
    hue+=h; 
    sat+=s; 
    bri+=b; 
    speed+=sp;
    acc+=a;
    rcount=0.5*rcount+0.5*c; 
    rhue=0.5*rhue+0.5*h; 
    rsat=0.5*rsat+0.5*s; 
    rbri=0.5*rbri+0.5*b; 
    rspeed=0.5*rspeed+0.5*sp;
    racc=0.5*racc+0.5*a;
  }

  void add(float c, float h, float s, float b, float sp, float a, float f) {
    count+=f*c; 
    hue+=f*h; 
    sat+=f*s; 
    bri+=f*b; 
    speed+=f*sp;
    acc+=f*a;
    
     rcount=(1.0-f)*rcount+f*c; 
    rhue=(1.0-f)*rhue+f*h; 
    rsat=(1.0-f)*rsat+f*s; 
    rbri=(1.0-f)*rbri+f*b; 
    rspeed=(1.0-0.5*f)*rspeed+0.5*f*sp;
    racc=(1.0-f)*racc+f*a;
    
  }

  void add(Bin b) {
    count+=b.count; 
    hue+=b.hue; 
    sat+=b.sat; 
    bri+=b.bri; 
    speed+=b.speed;
    acc+=b.acc;
     rcount=0.5*rcount+0.5*b.rcount; 
    rhue=0.5*rhue+0.5*b.rhue; 
    rsat=0.5*rsat+0.5*b.rsat; 
    rbri=0.5*rbri+0.5*b.rbri; 
    rspeed=0.5*rspeed+0.5*b.rspeed;
    racc=0.5*racc+0.5*b.racc;
    
  }

  void add(Bin b, float f) {
    count+=f*b.count; 
    hue+=f*b.hue; 
    sat+=f*b.sat; 
    bri+=f*b.bri; 
    speed+=f*b.speed;
    acc+=f*b.acc;
    
     rcount=(1.0-f)*rcount+f*b.rcount; 
    rhue=(1.0-f)*rhue+f*b.rhue; 
    rsat=(1.0-f)*rsat+f*b.rsat; 
    rbri=(1.0-f)*rbri+f*b.rbri; 
    rspeed=(1.0-0.5*f)*rspeed+0.5*f*b.rspeed;
    racc=(1.0-f)*racc+f*b.racc;
  }
  void div(float f) {
    count/=f; 
    hue/=f; 
    sat/=f; 
    bri/=f; 
    speed/=f;
    acc/=f;
     rcount/=f; 
    rhue/=f; 
    rsat/=f; 
    rbri/=f; 
    rspeed/=f;
    racc/=f;
  }

  void div(Bin b) {
    count/=b.count; 
    hue/=b.hue; 
    sat/=b.sat; 
    bri/=b.bri; 
    speed/=b.speed;
    acc/=b.acc;
     rcount/=b.rcount; 
   rhue/=b.rhue; 
    rsat/=b.rsat; 
    rbri/=b.rbri; 
    rspeed/=b.rspeed;
    racc/=b.racc;
  }

  void reset() {
    count=0; 
    hue=0; 
    sat=0; 
    bri=0; 
    speed=0;
    acc=0;
     rcount=0; 
    rhue=0; 
    rsat=0; 
    rbri=0; 
    rspeed=0;
    racc=0;
  }

  void max(Bin b) {
    if (b.count>count) count=b.count; 
    if (b.hue>hue) hue=b.hue; 
    if (b.sat>sat) sat=b.sat; 
    if (b.bri>bri) bri=b.bri; 
    if (b.speed>speed) speed=b.speed; 
    if (b.acc>racc) acc=b.acc;
    if (b.rcount>rcount) rcount=b.rcount; 
    if (b.rhue>rhue)rhue=b.rhue; 
    if (b.rsat>rsat) rsat=b.rsat; 
    if (b.rbri>rbri) rbri=b.rbri; 
    if (b.rspeed>rspeed) rspeed=b.rspeed; 
    if (b.racc>racc) racc=b.racc;
  }
  void min(Bin b) {
    if (b.count<count) count=b.count; 
    if (b.hue<hue) hue=b.hue; 
    if (b.sat<sat) sat=b.sat; 
    if (b.bri<bri) bri=b.bri; 
    if (b.speed<speed) speed=b.speed; 
    if (b.acc<acc) acc=b.acc;
        if (b.rcount<rcount) rcount=b.rcount; 
    if (b.rhue<rhue)rhue=b.rhue; 
    if (b.rsat<rsat) rsat=b.rsat; 
    if (b.rbri<rbri) rbri=b.rbri; 
    if (b.rspeed<rspeed) rspeed=b.rspeed; 
    if (b.racc<racc) racc=b.racc;
  }

  void invRange(Bin b1, Bin b2) {
    count=invRange(b1.count, b2.count); 
    hue=invRange(b1.hue, b2.hue); 
    sat=invRange(b1.sat, b2.sat); 
    bri=invRange(b1.bri, b2.bri); 
    speed=invRange(b1.speed, b2.speed); 
    acc=invRange(b1.acc, b2.acc);
     rcount=invRange(b1.rcount, b2.rcount); 
    rhue=invRange(b1.rhue, b2.rhue); 
    rsat=invRange(b1.rsat, b2.rsat); 
    rbri=invRange(b1.rbri, b2.rbri); 
    rspeed=invRange(b1.rspeed, b2.rspeed); 
    racc=invRange(b1.racc, b2.racc);
  }

  float invRange(float f1, float f2) {
    if (f1>f2) return 1f/(f1-f2);
    if (f1<f2) return 1f/(f2-f1);
    return 0f;
  }

  void invLog(Bin b1, Bin b2) {
    count=invLog(b1.count, b2.count); 
    hue=invLog(b1.hue, b2.hue); 
    sat=invLog(b1.sat, b2.sat); 
    bri=invLog(b1.bri, b2.bri); 
    speed=invLog(b1.speed, b2.speed); 
    acc=invLog(b1.acc, b2.acc);
     rcount=invLog(b1.rcount, b2.rcount); 
    rhue=invLog(b1.rhue, b2.rhue); 
    rsat=invLog(b1.rsat, b2.rsat); 
    rbri=invLog(b1.rbri, b2.rbri); 
    rspeed=invLog(b1.rspeed, b2.rspeed); 
    racc=invLog(b1.racc, b2.racc);
  }

  float invLog(float f1, float f2) {
    if (f1>f2) return 1f/FastFunctions.log2(1f+f1-f2);
    if (f1<f2) return 1f/FastFunctions.log2(1f+f2-f1);
    return 0f;
  }

  void logNorm(Bin b1, Bin b2) {
    count=logNorm(count, b1.count, b2.count); 
    hue=logNorm(hue, b1.hue, b2.hue); 
    sat=logNorm(sat, b1.sat, b2.sat); 
    bri=logNorm(bri, b1.bri, b2.bri); 
    speed=logNorm(speed, b1.speed, b2.speed); 
    acc=logNorm(acc, b1.acc, b2.acc);
    rcount=logNorm(rcount, b1.rcount, b2.count); 
    rhue=logNorm(rhue, b1.rhue, b2.rhue); 
    rsat=logNorm(rsat, b1.rsat, b2.rsat); 
    rbri=logNorm(rbri, b1.rbri, b2.rbri); 
    rspeed=logNorm(rspeed, b1.rspeed, b2.rspeed); 
    racc=logNorm(racc, b1.racc,b2.racc);
  }

  float logNorm(float v, float f1, float f2) {
    return  FastFunctions.log2(v-f1+1f)*f2;
  }

  void norm(Bin b1, Bin b2) {
    count=norm(count, b1.count, b2.count); 
    hue=norm(hue, b1.hue, b2.hue); 
    sat=norm(sat, b1.sat, b2.sat); 
    bri=norm(bri, b1.bri, b2.bri); 
    speed=norm(speed, b1.speed, b2.speed); 
    acc=norm(acc, b1.acc, b2.acc);
    rcount=norm(rcount, b1.rcount, b2.rcount); 
    rhue=norm(rhue, b1.rhue, b2.rhue); 
    rsat=norm(rsat, b1.rsat, b2.rsat); 
    rbri=norm(rbri, b1.rbri, b2.rbri); 
    rspeed=norm(rspeed, b1.rspeed, b2.rspeed); 
    racc=norm(racc, b1.racc, b2.racc);
  }

  float norm(float v, float min, float invrange) {
    return  (v-min)*invrange;
  }
}


// Auxiliary structure that contains all values for a pixel
class ResultBin {
  Bin rawValues;
  Bin normValues;
  Bin logNormValues;
  Bin avgValues;
  ResultBin() {
  }

  color getMonochrome() {
    return color(logNormValues.count);
  }
}