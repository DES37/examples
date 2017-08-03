


interface Function{
  float f(float x); 
}

// a general function to map linear range
class genericFunction implements Function{
  boolean invert;
  boolean symmetric;
  boolean repeat;
  boolean pingPong;
  boolean reverse;
  boolean defInvert;
  boolean defSymmetric;
  boolean defRepeat;
  boolean defPingPong;
  boolean defReverse;
  float bias;
  float ib;
  float gain;
  float ig;
  float multiplier;
  float offset;
  float lowerValue;
  float upperValue;
  float defBias;
  float defGain;
  float defMultiplier;
  float defOffset;
  float defLowerValue;
  float defUpperValue;

  genericFunction(float b, float g, float m, float o, float lv, float uv, boolean i, boolean s, boolean r, boolean p, boolean rev){
    defInvert=invert=i;
    defSymmetric=symmetric=s;
    defRepeat=repeat=r;
    defPingPong=pingPong=p;
    defReverse=reverse;
    defBias=bias=constrain(b,0.01f,0.99f);
    ib=1f/bias-2f; 
    defGain=gain=constrain(g,0.01f,0.99f);
    ig=1f/gain;
    defMultiplier=multiplier=m;
    defOffset=offset=o;
    defInvert=invert=i;
    defLowerValue=lowerValue=lv;
    defUpperValue=upperValue=uv;
  }

  genericFunction(genericFunction gf){
    invert=gf.invert;
    symmetric=gf.symmetric;
    repeat=gf.repeat;
    pingPong=gf.pingPong;
    reverse=gf.reverse;
    bias=gf.bias;
    ib=1f/bias; 
    gain=gf.gain;
    ig=1f/gain-2f;
    multiplier=gf.multiplier;
    offset=gf.offset;
    invert=gf.invert;
    lowerValue=gf.lowerValue;
    upperValue=gf.upperValue;
    defInvert=gf.defInvert;
    defSymmetric=gf.defSymmetric;
    defRepeat=gf.defRepeat;
    defPingPong=gf.defPingPong;
    defReverse=gf.defReverse;
    defBias=gf.defBias;
    defGain=gf.defGain;
    defMultiplier=gf.defMultiplier;
    defOffset=gf.defOffset;
    defInvert=gf.defInvert;
    defLowerValue=gf.defLowerValue;
    defUpperValue=gf.defUpperValue;    
  }

  float f(float x){
    float locx=multiplier*x+offset;

    if (repeat){
      while ((locx<0)||(locx>1f)){
        if(locx>1f) locx-=1f;
        if(locx<0f) locx+=1f;
        if(pingPong) locx=1f-locx;
      }
    }
    else{
      constrain(locx,0f,1f); 
    }
    if(reverse) locx=1f-locx;
    if(symmetric) locx=1f-4f*sq(locx-0.5f);
    if(bias!=1.0f) locx=FastFunctions.pow(locx,ib);
    if(gain!=0.5f){
      if((locx>0f)&&(locx<1f)){
      if(locx<0.5f){
        locx/=(ig*(1f-2*locx)+1f);
      }
      else{
        locx=(ig*(1f-2*locx)-locx)/(ig*(1f-2*locx)-1f);
      }
      }
    }
    if(invert)locx=1f-locx;
    return lowerValue+locx*(upperValue-lowerValue);
  }

  genericFunction get(){
    return new genericFunction(this);
  }

  void setBias(float b){
    bias=constrain(b,0.1f,4.0f);
    ib=1f/bias; 
  }
  void setGain(float g){
    gain=constrain(g,0.01f,0.99f);
    ig=1f/gain-2f;
  }

  void setMultiplier(float m){
    multiplier=m;
  }

  void setOffset(float o){
    offset=o;
  }

  void setLowerValue(float lv){
    lowerValue=lv; 
  }

  void setUpperValue(float uv){
    upperValue=uv; 
  }
}


// drawing a colorbar
class Colorbar{

  float cx,cy,cw,ch;
  Function cf;
  float dx;
  int type;

  Colorbar(float cx, float cy, float cw, float ch, Function cf, int type){
    this.cx=cx;
    this.cy=cy;
    this.cw=cw;
    this.ch=ch;
    this.cf=cf;
    dx=cw/(int)cw;
    this.type=type;
  }
  
  void draw(){
    noStroke();
    for(int i=0;i<(int)cw;i++){
      if(type==0){// hue bar
        fill(cf.f(i*dx/cw),.8f,.8f);
      }
      else if(type==1){// saturation bar
        fill(0f,cf.f(i*dx/cw),0.5f);
      }
      else{// brightness bar
        fill(0f,0f,cf.f(i*dx/cw));
      }
      rect(cx+i*dx,cy,dx,ch);
    }

  }
}