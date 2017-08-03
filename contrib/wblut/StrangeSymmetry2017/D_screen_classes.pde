// Displaying the accumulation grid
class AttractorDisplay{
  AccumulationGrid grid; // accumulation grid
  AttractorSystem attractorSystem; // associated attractor
  AttractorDisplayParameters parameters; // display parameters
  GaussianConvolutionKernel gck;
  float focus;
  PVector tempResult = new PVector();
  int NOfUpdates;

  AttractorDisplay(GridParameters GP, AttractorSystemParameters ASP, AttractorDisplayParameters parameters){
    this.parameters=parameters.get();     
    attractorSystem = new AttractorSystem(ASP);
    grid=new AccumulationGrid(GP);
    this.focus=1.5f;
    this.gck =new GaussianConvolutionKernel(20,10,2f, focus);
    NOfUpdates=0;
  }


  //estimate spatial extent of attractor
  void setLimits(int steps){
    float xmin =grid.parameters.minVisX;
    float xmax=grid.parameters.maxVisX;
    float ymin=grid.parameters.minVisY;
    float ymax=grid.parameters.maxVisY;
    float dx,dy,dnx,dny;
    for (int rep=0;rep<steps;rep++){
      attractorSystem.update(tempResult);
      for(int t=0;t<attractorSystem.parameters.numParticles;t++){
        if (attractorSystem.particles[t].age>5) { // Ignore first few steps
          xmin=min(xmin,attractorSystem.particles[t].x);
          xmax=max(xmax,attractorSystem.particles[t].x);
          ymin=min(ymin,attractorSystem.particles[t].y);
          ymax=max(ymax,attractorSystem.particles[t].y);
        }
      }
    }
    dx=grid.parameters.maxVisX-grid.parameters.minVisX;
    dy=grid.parameters.maxVisY-grid.parameters.minVisY;
    dnx=xmax-xmin;
    dny=ymax-ymin;

    float sr=FastFunctions.sqrt(dx/dy*dny/dnx);
    grid.parameters.minVisX=(xmax+xmin)/2f-1.2f*sr*dnx/2f;
    grid.parameters.minVisY=(ymax+ymin)/2f-1.2f/sr*dny/2f;    
    grid.parameters.maxVisX=(xmax+xmin)/2f+1.2f*sr*dnx/2f;
    grid.parameters.maxVisY=(ymax+ymin)/2f+1.2f/sr*dny/2f;    
    reset(true,false);
  }

  // update all particles
  void update(int steps, boolean firstPass){
    float px, py;
    if (firstPass) setLimits(steps);// if it's the first this attractor updates, rescale to its approximate limits.  
    for (int rep=0;rep<steps;rep++){
      attractorSystem.update(tempResult);
      AttractorSystemParameters ASP=attractorSystem.parameters;// shorthand for the attractor system parameters
      for(int t=0;t<ASP.numParticles;t++){
        if (attractorSystem.particles[t].age>parameters.cutoff) {
          if(ASP.rotation!=0f){
            px=ASP.centerOfRotation.x+attractorSystem.cosRot*(attractorSystem.particles[t].x-ASP.centerOfRotation.x)-attractorSystem.sinRot*(attractorSystem.particles[t].y-ASP.centerOfRotation.y);
            py=ASP.centerOfRotation.y+attractorSystem.sinRot*(attractorSystem.particles[t].x-ASP.centerOfRotation.x)+attractorSystem.cosRot*(attractorSystem.particles[t].y-ASP.centerOfRotation.y);  
          }
          else{
            px=attractorSystem.particles[t].x;
            py=attractorSystem.particles[t].y;
          }
          grid.add(px,py,attractorSystem.particles[t].value,attractorSystem.particles[t].hue,attractorSystem.particles[t].sat,attractorSystem.particles[t].bri,attractorSystem.particles[t].speed,attractorSystem.particles[t].acc,parameters.quality,focus,gck);     
        }
      }
      NOfUpdates++;
    }
    firstPass=false;
  }

  void getPixels(){
    ResultBin resultBin;
    loadPixels();
    for(int i=0;i<parameters.displayWidth;i++){
      for(int j=0;j<parameters.displayHeight;j++){
        resultBin= grid.getValues(i,j,parameters.displayWidth,parameters.displayHeight);
         float hue=parameters.hueFunction.f(resultBin.normValues.rspeed);//+0.25*parameters.hueFunction.f(resultBin.normValues.speed);
         float sat=parameters.satFunction.f(resultBin.logNormValues.racc);
         float bri=parameters.briFunction.f(resultBin.logNormValues.count);
        pixels[parameters.displayX+i+width*(j+parameters.displayY)]=color(hue,sat,bri);
      }
    }
    updatePixels();
  }

  void clear(){
    fill(0);
    noStroke();
    rect(parameters.displayX,parameters.displayY,parameters.displayWidth,parameters.displayHeight);
  }

  void frame(color c){
    fill(c);
    noStroke();
    rect(parameters.displayX,parameters.displayY,parameters.displayWidth,1);
    rect(parameters.displayX,parameters.displayY+parameters.displayHeight-1,parameters.displayWidth,1);    
    rect(parameters.displayX,parameters.displayY,1,parameters.displayHeight);    
    rect(parameters.displayX+parameters.displayWidth-1,parameters.displayY,1,parameters.displayHeight);    
  }

  void drawCenters(){
    noFill();
    stroke(0f,1f,1f);
    line(parameters.displayX+0.5f*parameters.displayWidth-5,parameters.displayY+0.5f*parameters.displayHeight,parameters.displayX+0.5f*parameters.displayWidth+5,parameters.displayY+0.5f*parameters.displayHeight);
    line(parameters.displayX+0.5f*parameters.displayWidth,parameters.displayY+0.5f*parameters.displayHeight-5,parameters.displayX+0.5f*parameters.displayWidth,parameters.displayY+0.5f*parameters.displayHeight+5);
    stroke(0.25f,1f,1f);
    PVector cor =getAttractorDisplayCoords(attractorSystem.parameters.centerOfSymmetry);
    ellipse(cor.x,cor.y,4,4);    
    stroke(0.50f,1f,1f);
    cor = getAttractorDisplayCoords(attractorSystem.parameters.centerOfMirror);
    ellipse(cor.x,cor.y,6,6);
    line(cor.x+5*attractorSystem.cosMirrorRot,cor.y+5*attractorSystem.sinMirrorRot,cor.x-5*attractorSystem.cosMirrorRot,cor.y-5*attractorSystem.sinMirrorRot);
    line(cor.x-5*attractorSystem.sinMirrorRot,cor.y+5*attractorSystem.cosMirrorRot,cor.x+5*attractorSystem.sinMirrorRot,cor.y-5*attractorSystem.cosMirrorRot);          
    stroke(0.75f,1f,1f);
    cor = getAttractorDisplayCoords(attractorSystem.parameters.centerOfRotation);
    ellipse(cor.x,cor.y,8,8);
    noStroke();
  }

  PVector getAttractorDisplayCoords(PVector p){
    float x=attractorSystem.parameters.centerOfRotation.x+attractorSystem.cosRot*(p.x-attractorSystem.parameters.centerOfRotation.x)-attractorSystem.sinRot*(p.y-attractorSystem.parameters.centerOfRotation.y);
    float y=attractorSystem.parameters.centerOfRotation.y+attractorSystem.sinRot*(p.x-attractorSystem.parameters.centerOfRotation.x)+attractorSystem.cosRot*(p.y-attractorSystem.parameters.centerOfRotation.y);  
    x=parameters.displayX+(x-grid.parameters.minVisX)*parameters.displayWidth/(grid.parameters.maxVisX-grid.parameters.minVisX);
    y=parameters.displayY+(y-grid.parameters.minVisY)*parameters.displayHeight/(grid.parameters.maxVisY-grid.parameters.minVisY);
    return new PVector(x,y);
  }

  PVector getSystemCoords(PVector p){
    float tx=grid.parameters.minVisX+(p.x-parameters.displayX)/parameters.displayWidth*(grid.parameters.maxVisX-grid.parameters.minVisX);
    float ty=grid.parameters.minVisY+(p.y-parameters.displayY)/parameters.displayHeight*(grid.parameters.maxVisY-grid.parameters.minVisY);
    float x=attractorSystem.parameters.centerOfRotation.x+attractorSystem.cosRot*(tx-attractorSystem.parameters.centerOfRotation.x)+attractorSystem.sinRot*(ty-attractorSystem.parameters.centerOfRotation.y);
    float y=attractorSystem.parameters.centerOfRotation.y-attractorSystem.sinRot*(tx-attractorSystem.parameters.centerOfRotation.x)+attractorSystem.cosRot*(ty-attractorSystem.parameters.centerOfRotation.y);  
    return new PVector(x,y);
  }

  void reset(boolean gridResized, boolean systemResized){
    grid.reset(gridResized);
    attractorSystem.reset(systemResized);
    NOfUpdates=0;
  }

  void setSize(int ID){
    int locID=ID;
    float f;
    switch(locID){
    case 0:
      f=0.25f;
      break;
    case 1:
      f=0.5f;
      break;
    case 2:
      f=1f;
      break;
    case 3:
      f=2f;
      break;
    case 4:
      f=4f;
      break;
    default:
      f=1f;
    }
    parameters.gridSize=locID;
    int oldX=grid.parameters.resX;
    int oldY=grid.parameters.resY;
    grid.parameters.resX=(int)(f*parameters.displayWidth);
    grid.parameters.resY=(int)(f*parameters.displayHeight);   
    if((oldX!=grid.parameters.resX)||(oldY!=grid.parameters.resY)){
      reset(true,false);
    }
  }

  void setQuality(int ID){
    if(ID!=parameters.quality){
      parameters.quality=ID;
      reset(false, false);
    }
  }

  void setSourceType(int s){
    if(s!=attractorSystem.parameters.sourceType){
      attractorSystem.parameters.sourceType=s;
      reset(false,false);
    }
  }

  void setMirror(int ID){       
    if(ID!=attractorSystem.parameters.mirror){
      attractorSystem.parameters.mirror=ID;
      reset(false,false);    
    }
  }

  void setSymmetry(int s){
    if(s!=attractorSystem.parameters.symmetry){
      attractorSystem.setSymmetry(s);
      reset(false,false);
    }
  }

  void setRotation(float r){
    if(r!=attractorSystem.parameters.rotation){
      attractorSystem.setRotation(r);
      reset(false,false);
    } 
  }

  void setMirrorRotation(float r){
    if(r!=attractorSystem.parameters.mirrorRotation){
      attractorSystem.setMirrorRotation(r);
      reset(false,false);
    } 
  }

  void setRange(float r){
    if(r!=attractorSystem.parameters.maxX){
      attractorSystem.setRange(r);
      reset(false,false);
    } 
  }

  void setNumParticles(int nop){
    if(nop!=attractorSystem.parameters.numParticles){
      attractorSystem.setNumParticles(nop);
      reset(false,true);
    } 
  }

  void setParticleLife(int ID){
    if(ID!=attractorSystem.parameters.particleLife){
      attractorSystem.setParticleLife(ID);
      reset(false,false);
    } 
  }

  void setCutoff(int ID){
    if(ID!=parameters.cutoff){
      parameters.cutoff=ID;
      reset(false,false);
    } 
  }

  void setCenterMode(int ID){
    parameters.centerMode=ID;
  }

  void centerOnPixel(int X, int Y){
    if((X>=parameters.displayX)&&(X<=parameters.displayX+parameters.displayWidth)&&(Y>=parameters.displayY)&&(Y<=parameters.displayY+parameters.displayHeight)){
      PVector m= getSystemCoords(new PVector(X,Y)); 
      PVector o;
      switch(parameters.centerMode){
      case 0:
        o=getSystemCoords(new PVector(parameters.displayX+0.5f*parameters.displayWidth,parameters.displayY+0.5f*parameters.displayHeight)); 
        float tx=m.x-o.x;
        float dy=m.y-o.y;
        float dx=attractorSystem.cosRot*tx-attractorSystem.sinRot*dy;
        dy=attractorSystem.cosRot*dy+attractorSystem.sinRot*tx;
        grid.parameters.minVisX+=dx;
        grid.parameters.maxVisX+=dx;
        grid.parameters.minVisY+=dy;
        grid.parameters.maxVisY+=dy;
        reset(false,false);
        break;
      case 1:
        attractorSystem.parameters.centerOfSymmetry=new PVector(m.x,m.y);
        reset(false,false);
        break;
      case 2:
        attractorSystem.parameters.centerOfMirror=new PVector(m.x,m.y);
        reset(false,false);
        break;
      case 3:
        attractorSystem.parameters.centerOfRotation=new PVector(m.x,m.y);
        reset(false,false);
      }
    }
  }

  void keyPressed(){
    boolean redraw=false;
    if (key == CODED) {
      if (keyCode == UP) {
        grid.parameters.minVisY=grid.parameters.minVisY+0.05*(grid.parameters.maxVisY-grid.parameters.minVisY);
        grid.parameters.maxVisY=grid.parameters.maxVisY+0.05*(grid.parameters.maxVisY-grid.parameters.minVisY);
        reset(false,false);
      } 
      else if (keyCode == DOWN) {
        grid.parameters.minVisY=grid.parameters.minVisY-0.05*(grid.parameters.maxVisY-grid.parameters.minVisY);
        grid.parameters.maxVisY=grid.parameters.maxVisY-0.05*(grid.parameters.maxVisY-grid.parameters.minVisY);
        reset(false,false);
      } 
      else if (keyCode == RIGHT) {
        grid.parameters.minVisX=grid.parameters.minVisX-0.05*(grid.parameters.maxVisX-grid.parameters.minVisX);
        grid.parameters.maxVisX=grid.parameters.maxVisX-0.05*(grid.parameters.maxVisX-grid.parameters.minVisX);
        reset(false,false);
      } 
      else if (keyCode == LEFT) {
        grid.parameters.minVisX=grid.parameters.minVisX+0.05*(grid.parameters.maxVisX-grid.parameters.minVisX);
        grid.parameters.maxVisX=grid.parameters.maxVisX+0.05*(grid.parameters.maxVisX-grid.parameters.minVisX);
        reset(false,false);
      } 
    } 
    else {
      if ((key == 'c')||(key == 'C')) {
        centerOnPixel(mouseX,mouseY);
      }
      else if (key=='+'){
        float mx=0.5f*(grid.parameters.maxVisX+grid.parameters.minVisX);
        float my=0.5f*(grid.parameters.maxVisY+grid.parameters.minVisY);
        float nlx = mx-0.45f*(grid.parameters.maxVisX-grid.parameters.minVisX);
        float nux = mx+0.45f*(grid.parameters.maxVisX-grid.parameters.minVisX);
        float nly = my-0.45f*(grid.parameters.maxVisY-grid.parameters.minVisY);
        float nuy = my+0.45f*(grid.parameters.maxVisY-grid.parameters.minVisY);
        grid.parameters.minVisX=nlx;
        grid.parameters.maxVisX=nux;
        grid.parameters.minVisY=nly;
        grid.parameters.maxVisY=nuy;
        reset(false,false);
      }
      else if (key=='-'){
        float mx=0.5f*(grid.parameters.maxVisX+grid.parameters.minVisX);
        float my=0.5f*(grid.parameters.maxVisY+grid.parameters.minVisY);
        float nlx = mx-0.55f*(grid.parameters.maxVisX-grid.parameters.minVisX);
        float nux = mx+0.55f*(grid.parameters.maxVisX-grid.parameters.minVisX);
        float nly = my-0.55f*(grid.parameters.maxVisY-grid.parameters.minVisY);
        float nuy = my+0.55f*(grid.parameters.maxVisY-grid.parameters.minVisY);
        grid.parameters.minVisX=nlx;
        grid.parameters.maxVisX=nux;
        grid.parameters.minVisY=nly;
        grid.parameters.maxVisY=nuy;
        reset(false,false);
      }
    }
  }
}


// class governing the interface and the various states.
class AttractorDisplayArray{
  static final int INIT=0; // initialization phase
  static final int WAITING=1; // initialization done, waiting for selecting
  static final int FULLSCREENACTIVE=2; // updating and rendering
  static final int FULLSCREENSTEALTH=3; // updating, rendering only on demand
  static final int FULLSCREENCOLOR=4; // no update, fast feedback for color changes
  static final int FULLSCREENMODIFY=5; // preview update only, fast feedback for geometry change
  static final int SAVING=6; // intermediate state, no input during saving
  
  Attractor[] attractors; // array of randomly selected attractors
  float[][] limits; // remember limits of the attractor systems
  AttractorDisplay activeDisplay;
  AttractorDisplay previewDisplay;
  int rows;
  int cols;
  int ax,ay,aw,ah;
  int px, py, pw, ph;
  int mode;
  int prevMode;
  boolean showCenters;
  boolean active;
  boolean responsiveToColorChange;
  boolean responsiveToGridChange;
  boolean responsiveToAttractorChange;
  boolean drawRequested;
  boolean updateOnce;
  int initCounter;
  AttractorDisplayParameters defaultADP;
  AttractorSystemParameters defaultASP;
  GridParameters defaultGP;


  AttractorDisplayArray(int rows, int cols, int ax, int ay,int aw, int ah, int px, int py,int pw, int ph){
    this.rows=max(1,rows);
    this.cols=max(1,cols);
    this.ax=ax;
    this.ay=ay;
    this.aw=aw;
    this.ah=ah;
    this.attractors = new Attractor[this.rows*this.cols];
    this.limits = new float[this.rows*this.cols][4];
    defaultADP=new AttractorDisplayParameters(0,0,aw/cols,ah/rows,1,0,1,2,new genericFunction(1.0f,0.5f,1f,0f,0f,1f,false,false,true,false,false),new genericFunction(1.0f,0.5f,1f,0f,0f,1f,false,false,false,false,false),
    new genericFunction(1.0f,0.5f,1f,0f,0f,1f,false,false,false,false,false));
    defaultASP = new AttractorSystemParameters(1000,100,-2f,2f,-2f,2f,1,new PVector(0f,0f),0,new PVector(0f,0f),0f,0f,new PVector(0f,0f),0,-1);
    defaultGP = new GridParameters(aw/(2*cols),ah/(2*rows),-2f,2f,-2f,2f);
    for(int i=0;i<this.rows*this.cols;i++){
      attractors[i] = (new AttractorSystem(defaultASP)).attractor.get();
    } 
    activeDisplay = new AttractorDisplay(defaultGP,defaultASP,defaultADP);
    previewDisplay = new AttractorDisplay(defaultGP,defaultASP,defaultADP);
    previewDisplay.parameters.displayX = px;
    previewDisplay.parameters.displayY = py;
    previewDisplay.parameters.displayWidth = pw;
    previewDisplay.parameters.displayHeight = ph;
    prevMode=mode=INIT;
    initCounter=0;
    processMode();
    showCenters=false;
    drawRequested=false;
    updateOnce=true;


  }

  
  void update(){
    if(updateOnce){
      switch(mode){
      case INIT:
        activeDisplay.grid.parameters=defaultGP.get();
        activeDisplay.attractorSystem.parameters=defaultASP.get();
        activeDisplay.parameters=defaultADP.get();
        activeDisplay.parameters.displayX=ax+aw/cols*(initCounter%cols);
        activeDisplay.parameters.displayY=ay+ah/rows*(initCounter/cols);
        activeDisplay.parameters.displayWidth=aw/cols;
        activeDisplay.parameters.displayHeight=ah/rows;
        activeDisplay.attractorSystem.attractor=attractors[initCounter].get();            
        activeDisplay.attractorSystem.resetPreCalc();
        activeDisplay.setSize(2);
        activeDisplay.setQuality(0);       
        activeDisplay.reset(true,false);
        activeDisplay.update(100,true);
        activeDisplay.clear();
        activeDisplay.getPixels();
        activeDisplay.frame(color(0.06f,0f,0.5f));
        limits[initCounter][0]=activeDisplay.grid.parameters.minVisX;
        limits[initCounter][1]=activeDisplay.grid.parameters.minVisY;
        limits[initCounter][2]=activeDisplay.grid.parameters.maxVisX;
        limits[initCounter][3]=activeDisplay.grid.parameters.maxVisY;
        initCounter++;
        if(initCounter==cols*rows){
          prevMode=INIT;
          mode=WAITING;
          initCounter=0;
          processMode();
        }
        prevMode=INIT;
        break;
      case WAITING:
        prevMode=WAITING;
        break;
      case FULLSCREENSTEALTH:
        activeDisplay.update(1000,false);
        if(drawRequested){
          activeDisplay.clear();
          activeDisplay.getPixels();
          drawRequested=false; 
        }
        prevMode=FULLSCREENSTEALTH;
        break;
      case FULLSCREENCOLOR:
        activeDisplay.clear();
        activeDisplay.getPixels();
        prevMode=FULLSCREENCOLOR;
        updateOnce=false;
        break;
      case FULLSCREENACTIVE:
        activeDisplay.update(250,false);
        activeDisplay.clear();
        activeDisplay.getPixels();
        prevMode=FULLSCREENACTIVE;
        break;
      case FULLSCREENMODIFY:
        drawPreview();
        if(showCenters) previewDisplay.drawCenters();
        prevMode=FULLSCREENMODIFY;
        updateOnce=false;
        break;
      }
    }
  }

  void drawPreview(){
    previewDisplay.attractorSystem=activeDisplay.attractorSystem;
    previewDisplay.grid.parameters.minVisX=activeDisplay.grid.parameters.minVisX;
    previewDisplay.grid.parameters.maxVisX=activeDisplay.grid.parameters.maxVisX;
    previewDisplay.grid.parameters.minVisY=activeDisplay.grid.parameters.minVisY;
    previewDisplay.grid.parameters.maxVisY=activeDisplay.grid.parameters.maxVisY;
    previewDisplay.parameters.cutoff=activeDisplay.parameters.cutoff;
    previewDisplay.parameters.briFunction=activeDisplay.parameters.briFunction;
    previewDisplay.reset(false,false);
    previewDisplay.update(100,false);
    previewDisplay.clear();
    previewDisplay.getPixels();
  }

  void saveImage(){
java.util.Date dNow = new java.util.Date( );
  java.text.SimpleDateFormat ft = new java.text.SimpleDateFormat ("yyyy_MM_dd_hhmmss_S");
    PImage img=createImage(aw,ah,ARGB);
     img.copy(g,ax,ay,aw,ah,0,0,aw,ah);
    img.save(sketchPath("/saves/"+this.getClass().getName()+"/"+this.getClass().getName()+"_"+ft.format(dNow)+  ".png"));
  }

  void setType(int t){// change type of generated attractors
    if((t!=defaultASP.type)&&(mode==WAITING)){
      defaultASP.type=t;
      switchMode(INIT);
    }  
  }


// process current state and handle state toggles
void processMode(){
    switch(mode){
    case INIT: 
      active=false;
      responsiveToColorChange=false;
      responsiveToGridChange=false;
      responsiveToAttractorChange=false;
      showCenters=false;
      break;
    case WAITING: 
      active=false;
      responsiveToColorChange=false;
      responsiveToGridChange=false;
      responsiveToAttractorChange=false;
      showCenters=false;
      break;
    case FULLSCREENACTIVE: 
      active=true;
      responsiveToColorChange=false;
      responsiveToGridChange=false;
      responsiveToAttractorChange=false;
      showCenters=false;
      break;
    case FULLSCREENSTEALTH: 
      active=true;
      responsiveToColorChange=false;
      responsiveToGridChange=false;
      responsiveToAttractorChange=false;
      showCenters=false;
      break;
    case FULLSCREENCOLOR: 
      active=true;
      responsiveToColorChange=true;
      responsiveToGridChange=false;
      responsiveToAttractorChange=false;
      showCenters=false;
      break;
    case FULLSCREENMODIFY: 
      active=true;
      responsiveToColorChange=false;
      responsiveToGridChange=true;
      responsiveToAttractorChange=true;
      showCenters=true;
      break;
    case SAVING: 
      active=true;
      responsiveToColorChange=false;
      responsiveToGridChange=false;
      responsiveToAttractorChange=false;
      showCenters=false;
      break;
    }
  }

  // handle state changes
  void switchMode(int requestedMode){
    switch(mode){
    case INIT:
      break;
    case WAITING:
      switch(requestedMode){
      case INIT:
        for(int i=0;i<this.rows*this.cols;i++){
          attractors[i] = (new AttractorSystem(defaultASP)).attractor.get();
        }
        mode=INIT;
        prevMode=WAITING;
        processMode();
        break;
      }
      break;
    case FULLSCREENACTIVE:
      switch(requestedMode){
      case INIT:
        mode=INIT;
        prevMode=FULLSCREENACTIVE;
        processMode();
        break;
      case FULLSCREENMODIFY:
        mode=FULLSCREENMODIFY;
        prevMode=FULLSCREENACTIVE;
        processMode();
        break;
      case FULLSCREENSTEALTH:
        mode=FULLSCREENSTEALTH;
        prevMode=FULLSCREENACTIVE;
        processMode();
        break;
      case FULLSCREENCOLOR:
        if( activeDisplay.NOfUpdates>0){
          mode=FULLSCREENCOLOR;
          prevMode=FULLSCREENMODIFY;
          processMode();
        }
        break;
      case SAVING:
        if(prevMode!=SAVING){
          mode=SAVING;
          prevMode=FULLSCREENACTIVE;
          processMode();
          saveImage();
          mode=prevMode;
          prevMode=SAVING;
          processMode();
        }
        break;
      }
      break;
    case FULLSCREENMODIFY:
      switch(requestedMode){
      case FULLSCREENACTIVE:
        mode=FULLSCREENACTIVE;
        prevMode=FULLSCREENMODIFY;
        processMode();
        break;
      case FULLSCREENSTEALTH:
        mode=FULLSCREENSTEALTH;
        prevMode=FULLSCREENMODIFY;
        processMode();
        break;
      case FULLSCREENCOLOR:
        if( activeDisplay.NOfUpdates>0){
          mode=FULLSCREENCOLOR;
          prevMode=FULLSCREENMODIFY;
          processMode();
        }
        break;  
      }
      break;
    case FULLSCREENCOLOR:
      switch(requestedMode){
      case FULLSCREENACTIVE:
        mode=FULLSCREENACTIVE;
        prevMode=FULLSCREENCOLOR;
        processMode();
        break;
      case FULLSCREENSTEALTH:
        mode=FULLSCREENSTEALTH;
        prevMode=FULLSCREENCOLOR;
        processMode();
        break;
      case FULLSCREENMODIFY:
        mode=FULLSCREENMODIFY;
        prevMode=FULLSCREENCOLOR;
        processMode();
        break;  
      case SAVING:
        if(prevMode!=SAVING){
          mode=SAVING;
          prevMode=FULLSCREENCOLOR;
          processMode();
          saveImage();
          mode=prevMode;
          prevMode=SAVING;
          processMode();
        }
        break;
      }
      break;
    case FULLSCREENSTEALTH:
      switch(requestedMode){
      case FULLSCREENACTIVE:
        mode=FULLSCREENACTIVE;
        prevMode=FULLSCREENSTEALTH;
        processMode();
        break;
      case FULLSCREENMODIFY:
        mode=FULLSCREENMODIFY;
        prevMode=FULLSCREENSTEALTH;
        processMode();
        break;
      case FULLSCREENCOLOR:
        if( activeDisplay.NOfUpdates>0){
          mode=FULLSCREENCOLOR;
          prevMode=FULLSCREENMODIFY;
          processMode();
        }
        break;  
      }
      break;
    }
  }

  void mousePressed(){
    if((mouseX>=ax)&&(mouseX<=ax+aw)&&(mouseY>=ay)&&(mouseY<=ay+ah)){
      if(mode==WAITING){
        float resulti,resultj;
        resulti = (mouseX-ax)/(aw/(float)cols);
        resultj = (mouseY-ay)/(ah/(float)rows);
        if((resulti>=0)&&(resulti<cols)&&(resultj>=0)&&(resultj<rows)){
          int selectedAttractor=(int)resulti+cols*(int)resultj;
          activeDisplay.parameters.displayX=ax;
          activeDisplay.parameters.displayY=ay;
          activeDisplay.parameters.displayWidth=aw;
          activeDisplay.parameters.displayHeight=ah;
          activeDisplay.grid.parameters.minVisX=limits[selectedAttractor][0];
          activeDisplay.grid.parameters.minVisY=limits[selectedAttractor][1];
          activeDisplay.grid.parameters.maxVisX=limits[selectedAttractor][2];
          activeDisplay.grid.parameters.maxVisY=limits[selectedAttractor][3];        
          activeDisplay.attractorSystem.attractor=attractors[selectedAttractor].get();      
          activeDisplay.attractorSystem.attractor.info();
          activeDisplay.reset(false,false);
          activeDisplay.attractorSystem.resetPreCalc();
          activeDisplay.setSize(3);
          activeDisplay.setQuality(0); 
          mode=FULLSCREENACTIVE;
          prevMode=WAITING;
          processMode();
        }
      }
      else if(mode==FULLSCREENSTEALTH){
        drawRequested=true;
      }
    }
  }

  void mouseReleased(){
    updateOnce=true; 
  }

  void processMutate(){
    if(mode==FULLSCREENACTIVE){
      for(int i=0;i<rows*cols;i++){         
        attractors[i] = activeDisplay.attractorSystem.attractor.get();
        attractors[i].mutate(0.1f);
      }
    }
    mode=INIT;
    prevMode=FULLSCREENACTIVE;
    processMode();
  }

  void keyPressed(){
    switch(key){
    case '1':
      switchMode(AttractorDisplayArray.INIT);
      break; 
    case '2':
      switchMode(AttractorDisplayArray.FULLSCREENACTIVE);
      break;
    case '3':
      switchMode(AttractorDisplayArray.FULLSCREENMODIFY);
      break;
    case '5':
      switchMode(AttractorDisplayArray.FULLSCREENSTEALTH);
      break;
    case '4':
      switchMode(AttractorDisplayArray.FULLSCREENCOLOR);
      break; 
    }
    if(mode==FULLSCREENMODIFY) activeDisplay.keyPressed();
  }

  void keyReleased(){
    updateOnce=true; 
  }
}