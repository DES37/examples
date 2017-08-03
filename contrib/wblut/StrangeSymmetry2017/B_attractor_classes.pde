/* Generic interface for a 2D coordinate map
 *  A map takes a 2D Point and generates a new one.
 */

interface Map{
  PVector map(PVector p);
  PVector map(float x, float y);

  // the above functions require a new PVector to be declared each time the function is called
  // A decent image needs 100000+ calls. The variation methods below rely on a result PVector already existing.
  // This makes the code somwhat more obscure but more efficient.
  void map(float x, float y,PVector result);
  void map(PVector p,PVector result);
}

/* Generic class for a 2D attractor
 * implements a map and methods for copying and changing.
 */

class Attractor implements Map{
  float[] parameters;
  int NOP;
  String label;

  Attractor(){
    NOP=0;  
    label="Attractor";
  }

  float getParameter(int i){
    return parameters[i];
  }

  int getNOP(){
    return NOP;
  }

  void mutate(float f){
    for(int i=0;i<NOP;i++){
      parameters[i]+=random(-f,f);
    }
  }

  Attractor get(){
    return new Attractor();
  }
  
  void info(){
    println(label);
    for(int i=0;i<NOP;i++){
      println("   Parameter "+i+" = "+parameters[i]);
    }
    println();
  }

  // Numerical magic to filter out some of the uninteresting results for some attractors.
  // Google for "maximum Lyapunov exponent" 
  float estimateMaxLyapunov(){
    PVector p1=new PVector(random(-0.01f,0.01f),random(-0.01f,0.01f));
    PVector p2=new PVector(p1.x+0.000001f,p1.y);

    float maxLyapunov=0f;
    int N=0;
    float d=0f;
    for(int i=0;i<4400;i++){
      p1=map(p1);
      p2=map(p2);
      d=PVector.dist(p1,p2);
      if(d>0f){
        if(i>400){
          maxLyapunov+=FastFunctions.log2(d*1000000f);
          N++;
        }
        p2.set(p1.x+0.000001f/d*(p2.x-p1.x),p1.y+0.000001f/d*(p2.y-p1.y),0f);
      }
      else{
        p2.set(p1.x+0.000001f,p1.y,0f);
      }
    }
    return (N>0)?0.721347f*maxLyapunov/N:0f;
  }

  PVector map(float x, float y){
    return new PVector(x,y);
  }

  PVector map(PVector p){
    return map(p.x,p.y);
  }

  void map(float x, float y, PVector result){
    result.x=x;
    result.y=y; 
  }

  void map(PVector p, PVector result){
    map(p.x,p.y,result);

  }
}

/*
/  The following consists of a number of different attractor maps.
 /  An AttractorSystem randomly selects one of these cases.
 */


class TrigAttractor extends Attractor{
  
  TrigAttractor(){
    super();
    label="TrigAttractor";
    NOP=16;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-2.5f,2.5f);
    }
  }

  PVector map(float x, float y){
    float nx=parameters[0]*sin(parameters[1]*y)+parameters[2]*cos(parameters[3]*x)+parameters[4]*sin(parameters[5]*x)+parameters[6]*cos(parameters[7]*y);
    float ny=parameters[8]*sin(parameters[9]*y)+parameters[10]*cos(parameters[11]*x)+parameters[12]*sin(parameters[13]*x)+parameters[14]*cos(parameters[15]*y);    
    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    result.x=parameters[0]*sin(parameters[1]*y)+parameters[2]*cos(parameters[3]*x)+parameters[4]*sin(parameters[5]*x)+parameters[6]*cos(parameters[7]*y);
    result.y=parameters[8]*sin(parameters[9]*y)+parameters[10]*cos(parameters[11]*x)+parameters[12]*sin(parameters[13]*x)+parameters[14]*cos(parameters[15]*y);  
  }

  TrigAttractor get(){
    TrigAttractor ta = new TrigAttractor();
    for(int i=0;i<NOP;i++){
      ta.parameters[i]=parameters[i];
    }
    return ta;
  }
}


class PlaidAttractor extends Attractor{
  PlaidAttractor(){
    super();
    label="PlaidAttractor";
    NOP=12;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-2f,2f);
    }
    float eml=estimateMaxLyapunov();
    while(eml<0.05f){
      for(int i=0;i<NOP;i++){
        parameters[i]=random(-2f,2f);
      }
      eml=estimateMaxLyapunov();

    }
  }

  PVector map(float x, float y){
    float nx=parameters[0]+parameters[1]*y+parameters[2]*y*y+parameters[3]*y*y*y+parameters[4]*y*y*y*y+parameters[5]*y*y*y*y*y;
    float ny=parameters[6]+parameters[7]*x+parameters[8]*x*x+parameters[9]*x*x*x+parameters[10]*x*x*x*x+parameters[11]*x*x*x*x*x;
    return new PVector(nx,ny);
  }

  void map(float x, float y, PVector result){
    result.x=parameters[0]+parameters[1]*y+parameters[2]*y*y+parameters[3]*y*y*y+parameters[4]*y*y*y*y+parameters[5]*y*y*y*y*y;
    result.y=parameters[6]+parameters[7]*x+parameters[8]*x*x+parameters[9]*x*x*x+parameters[10]*x*x*x*x+parameters[11]*x*x*x*x*x;
  }

  PlaidAttractor get(){
    PlaidAttractor pa = new PlaidAttractor();
    for(int i=0;i<NOP;i++){
      pa.parameters[i]=parameters[i];
    }
    return pa;
  }
}


// Not a true attractor but interesting results 
class WreathAttractor extends Attractor{
  float cc,sc;
  WreathAttractor(){
    super();
    label="WreathAttractor";
    NOP=6;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-1.2f,1.2f);
    }
    parameters[5]=2+(int)random(19.0f);
    cc=cos(TWO_PI/parameters[5]);
    sc=sin(TWO_PI/parameters[5]);
  }

  PVector map(float x, float y){
    float nx=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y+parameters[3]))*cc+y*sc;
    float ny=10f*parameters[4]-(x+parameters[1]*sin(parameters[2]*y+parameters[3]))*sc+y*cc;
    return new PVector(nx,ny);
  }

  void map(float x, float y, PVector result){
    result.x=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y+parameters[3]))*cc+y*sc;
    result.y=10f*parameters[4]-(x+parameters[1]*sin(parameters[2]*y+parameters[3]))*sc+y*cc;
  }

  WreathAttractor get(){
    WreathAttractor wa = new WreathAttractor();
    for(int i=0;i<NOP;i++){
      wa.parameters[i]=parameters[i];
    }
    wa.cc=cos(TWO_PI/parameters[5]);
    wa.sc=sin(TWO_PI/parameters[5]);
    return wa;
  }

  void mutate(float f){
    for(int i=0;i<NOP;i++){
      parameters[i]+=random(-f,f);
    }

    cc=cos(TWO_PI/parameters[5]);
    sc=sin(TWO_PI/parameters[5]);
  }
}

class ModifiedWreathAttractor extends Attractor{
  float cc,sc;
  ModifiedWreathAttractor(){
    super();
    label="ModifiedWreathAttractor";
    NOP=9;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-1.2f,1.2f);
    }
    parameters[8]=2+(int)random(19.0f);
    cc=cos(TWO_PI/parameters[8]);
    sc=sin(TWO_PI/parameters[8]);
  }

  PVector map(float x, float y){
    float nx=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y*x+parameters[3]))*cc+y*sc;
    float ny=10f*parameters[4]-(x+parameters[5]*sin(parameters[6]*y*x+parameters[7]))*sc+y*cc;
    return new PVector(nx,ny);
  }

  void map(float x, float y, PVector result){
    result.x=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y*x+parameters[3]))*cc+y*sc;
    result.y=10f*parameters[4]-(x+parameters[5]*sin(parameters[6]*y*x+parameters[7]))*sc+y*cc;
  }

  ModifiedWreathAttractor get(){
    ModifiedWreathAttractor wa = new ModifiedWreathAttractor();
    for(int i=0;i<NOP;i++){
      wa.parameters[i]=parameters[i];
    }
    wa.cc=cos(TWO_PI/parameters[8]);
    wa.sc=sin(TWO_PI/parameters[8]);
    return wa;
  }

  void mutate(float f){
    for(int i=0;i<NOP;i++){
      parameters[i]+=random(-f,f);
    }

    cc=cos(TWO_PI/parameters[8]);
    sc=sin(TWO_PI/parameters[8]);
  }
}

class DesyncedWreathAttractor extends Attractor{
  float ccx,scx,ccy,scy;
  DesyncedWreathAttractor(){
    super();
    label="DesyncedWreathAttractor";
    NOP=7;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-1.2f,1.2f);
    }
    parameters[4]=2+(int)random(11.0f);
    ccx=cos(TWO_PI/parameters[4]);
    scx=sin(TWO_PI/parameters[4]);
    parameters[6]=2+(int)random(11.0f);
    ccy=cos(TWO_PI/parameters[6]);
    scy=sin(TWO_PI/parameters[6]);
  }

  PVector map(float x, float y){
    float nx=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y*x+parameters[3]))*ccx+y*scx;
    float ny=10f*parameters[5]-(x+parameters[1]*sin(parameters[2]*y*x+parameters[3]))*scy+y*ccy;
    return new PVector(nx,ny);
  }

  void map(float x, float y, PVector result){
    result.x=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y*x+parameters[3]))*ccx+y*scx;
    result.y=10f*parameters[5]-(x+parameters[1]*sin(parameters[2]*y*x+parameters[3]))*scy+y*ccy;
  }

  DesyncedWreathAttractor get(){
    DesyncedWreathAttractor wa = new DesyncedWreathAttractor();
    for(int i=0;i<NOP;i++){
      wa.parameters[i]=parameters[i];
    }
    wa.ccx=cos(TWO_PI/parameters[4]);
    wa.scx=sin(TWO_PI/parameters[4]);
    wa.ccy=cos(TWO_PI/parameters[6]);
    wa.scy=sin(TWO_PI/parameters[6]);
    return wa;
  }

  void mutate(float f){
    for(int i=0;i<NOP;i++){
      parameters[i]+=random(-f,f);
    }
    ccx=cos(TWO_PI/parameters[4]);
    scx=sin(TWO_PI/parameters[4]);
    ccy=cos(TWO_PI/parameters[6]);
    scy=sin(TWO_PI/parameters[6]);
  }
}

class GenericWreathAttractor extends Attractor{
  float cc,sc;
  GenericWreathAttractor(){
    super();
    label="GenericWreathAttractor";
    NOP=15;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-1.2f,1.2f);
    }
    parameters[14]=2+(int)random(19.0f);
    cc=cos(TWO_PI/parameters[14]);
    sc=sin(TWO_PI/parameters[14]);
  }

  PVector map(float x, float y){
    float nx=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y+parameters[3]))*cc+(y+parameters[4]*sin(parameters[5]*x+parameters[6]))*sc;
    float ny=10f*parameters[7]-(x+parameters[8]*sin(parameters[9]*y+parameters[10]))*sc+(y+parameters[11]*sin(parameters[12]*x+parameters[13]))*cc;
    return new PVector(nx,ny);
  }

  void map(float x, float y, PVector result){
    result.x=10f*parameters[0]+(x+parameters[1]*sin(parameters[2]*y+parameters[3]))*cc+(y+parameters[4]*sin(parameters[5]*x+parameters[6]))*sc;
    result.y=10f*parameters[7]-(x+parameters[8]*sin(parameters[9]*y+parameters[10]))*sc+(y+parameters[11]*sin(parameters[12]*x+parameters[13]))*cc;
  }

  GenericWreathAttractor get(){
    GenericWreathAttractor wa = new GenericWreathAttractor();
    for(int i=0;i<NOP;i++){
      wa.parameters[i]=parameters[i];
    }
    wa.cc=cos(TWO_PI/parameters[14]);
    wa.sc=sin(TWO_PI/parameters[14]);
    return wa;
  }

  void mutate(float f){
    for(int i=0;i<NOP;i++){
      parameters[i]+=random(-f,f);
    }

    cc=cos(TWO_PI/parameters[14]);
    sc=sin(TWO_PI/parameters[14]);
  }
}


//Clifford Pickover attractor
class CliffordAttractor extends Attractor{
  CliffordAttractor(){
    super();
    label="CliffordAttractor";
    NOP=4;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-2.5f,2.5f);
    }
    float eml=estimateMaxLyapunov();
    while(eml<0.05f){
      for(int i=0;i<NOP;i++){
        parameters[i]=random(-2.5f,2.5f);
      }
      eml=estimateMaxLyapunov();

    }
  }

  PVector map(float x, float y){
    float nx=sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x);
    float ny=sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y);
    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    result.x=sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x);
    result.y=sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y);
  }

  CliffordAttractor get(){
    CliffordAttractor ca = new CliffordAttractor();
    for(int i=0;i<NOP;i++){
      ca.parameters[i]=parameters[i];
    }
    return ca;
  }
}


//Peter de Jong attractor
class PeterdeJongAttractor extends Attractor{
  PeterdeJongAttractor(){
    super();
    label="PeterdeJongAttractor";
    NOP=4;
    parameters = new float[NOP];
    for(int i=0;i<NOP;i++){
      parameters[i]=random(-2.5f,2.5f);
    }
    float eml=estimateMaxLyapunov();
    while(eml<0.05f){
      for(int i=0;i<NOP;i++){
        parameters[i]=random(-2.5f,2.5f);
      }
      eml=estimateMaxLyapunov();

    }
  }

  PVector map(float x, float y){
    float nx=sin(parameters[0]*y)-cos(parameters[1]*x);
    float ny=sin(parameters[2]*x)-cos(parameters[3]*y);
    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    result.x=sin(parameters[0]*y)-cos(parameters[1]*x);
    result.y=sin(parameters[2]*x)-cos(parameters[3]*y);
  }

  PeterdeJongAttractor get(){
    PeterdeJongAttractor pa = new PeterdeJongAttractor();
    for(int i=0;i<NOP;i++){
      pa.parameters[i]=parameters[i];
    }
    return pa;
  }
}

//  BlendedAttractor blends two types of attractor, a Clifford attractor, and a custom formula
class SimpleBlendedAttractor extends Attractor{
  SimpleBlendedAttractor(){
    super();
    label="SimpleBlendedAttractor";
    NOP=9;
    parameters = new float[NOP];
    for(int i=0;i<8;i++){
      parameters[i]=random(-2f,2f);
    }
    parameters[8]=random(0f,1f);// single blending parameter
  }

  PVector map(float x, float y){
    float nx=parameters[8]*(sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x))+(1.0f-parameters[8])*(y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6])));
    float ny=parameters[8]*(sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y))+(1.0f-parameters[8])*(parameters[7]-x);
    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    result.x=parameters[8]*(sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x))+(1.0f-parameters[8])*(y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6])));
    result.y=parameters[8]*(sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y))+(1.0f-parameters[8])*(parameters[7]-x);
  }

  SimpleBlendedAttractor get(){
    SimpleBlendedAttractor ba = new SimpleBlendedAttractor();
    for(int i=0;i<8;i++){
      ba.parameters[i]=parameters[i];
    }
    ba.parameters[8]=parameters[8];
    return ba;
  }
}

class BlendedAttractor extends Attractor{
  BlendedAttractor(){
    super();
    label="BlendedAttractor";
    NOP=10;
    parameters = new float[NOP];
    for(int i=0;i<8;i++){
      parameters[i]=random(-2f,2f);
    }
    parameters[8]=random(0f,1f);// blending parameter for x
    parameters[9]=random(0f,1f);// blending parameter for y
  }

  PVector map(float x, float y){
    float nx=parameters[8]*(sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x))+(1.0f-parameters[8])*(y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6])));
    float ny=parameters[9]*(sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y))+(1.0f-parameters[9])*(parameters[7]-x);
    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    result.x=parameters[8]*(sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x))+(1.0f-parameters[8])*(y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6])));
    result.y=parameters[9]*(sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y))+(1.0f-parameters[9])*(parameters[7]-x);
  }

  BlendedAttractor get(){
    BlendedAttractor ba = new BlendedAttractor();
    for(int i=0;i<8;i++){
      ba.parameters[i]=parameters[i];
    }
    ba.parameters[8]=parameters[8];
    ba.parameters[9]=parameters[9];
    return ba;
  }
}


// BranchedAttractor uses the same two types of attractor but instead of blending it selects
// one of the two and maps according to that one.

class SimpleBranchedAttractor extends Attractor{
  SimpleBranchedAttractor(){
    super();
    label="SimpleBranchedAttractor";
    NOP=9;
    parameters = new float[NOP];
    for(int i=0;i<8;i++){
      parameters[i]=random(-2f,2f);
    }
    parameters[8]=random(0f,1f);// single branching parameter 
  }

  PVector map(float x, float y){
    float nx;
    float ny;

    if(random(1.0f)<parameters[8]){
      nx=sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x);
      ny=sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y);
    }
    else{
      nx=y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6]));
      ny=parameters[7]-x;
    }

    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    if(random(1.0f)<parameters[8]){
      result.x=sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x);
      result.y=sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y);     
    }
    else{
      result.x=y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6]));   
      result.y=parameters[7]-x;
    }
  }

  SimpleBranchedAttractor get(){
    SimpleBranchedAttractor ba = new SimpleBranchedAttractor();
    for(int i=0;i<8;i++){
      ba.parameters[i]=parameters[i];
    }
    ba.parameters[8]=parameters[8];
    return ba;
  }
}

class BranchedAttractor extends Attractor{

  BranchedAttractor(){
    super();
    label="BranchedAttractor";
    NOP=10;
    parameters = new float[NOP];
    for(int i=0;i<8;i++){
      parameters[i]=random(-2f,2f);
    }
    parameters[8]=random(0f,1f);// branching parameter for x
    parameters[9]=random(0f,1f);// branching parameter for y
  }

  PVector map(float x, float y){
    float nx;
    float ny;

    if(random(1.0f)<parameters[8]){
      nx=sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x);
    }
    else{
      nx=y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6]));
    }
    if(random(1.0f)<parameters[9]){
      ny=sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y);
    }
    else{
      ny=parameters[7]-x;
    }
    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    if(random(1.0f)<parameters[8]){
      result.x=sin(parameters[0]*y)+parameters[2]*cos(parameters[0]*x);
    }
    else{
      result.x=y+parameters[4]*x/abs(x)*sqrt(abs(parameters[5]*x-parameters[6]));
    }
    if(random(1.0f)<parameters[9]){
      result.y=sin(parameters[1]*x)+parameters[3]*cos(parameters[1]*y);
    }
    else{
      result.y=parameters[7]-x;
    }
  }

  BranchedAttractor get(){
    BranchedAttractor ba = new BranchedAttractor();
    for(int i=0;i<8;i++){
      ba.parameters[i]=parameters[i];
    }
    ba.parameters[8]=parameters[8];
    ba.parameters[9]=parameters[9];
    return ba;
  }
}

// Gumowski Mira transform

class GumowskiMiraAttractor extends Attractor{

  GumowskiMiraAttractor(){
    super();
    label="GumowskiMiraAttractor";
    NOP=3;
    parameters = new float[NOP];
    parameters[0]=random(.1f);
    parameters[1]=random(-1f,.5f);
    parameters[2]=random(.1f);
  }
  PVector map(float x, float y){
    float nx=y+parameters[0]*(1f-parameters[2]*y*y)*y+parameters[1]*x+2.0f*(1f-parameters[1])*x*x/(1f+x*x);
    float ny=-x+parameters[1]*nx+2.0f*(1f-parameters[1])*nx*nx/(1f+nx*nx);
    return new PVector(nx,ny);
  }
  void map(float x, float y, PVector result){
    result.x=y+parameters[0]*(1f-parameters[2]*y*y)*y+parameters[1]*x+2.0f*(1f-parameters[1])*x*x/(1f+x*x);
    result.y=-x+parameters[1]*result.x+2.0f*(1f-parameters[1])*result.x*result.x/(1f+result.x*result.x);
  }

  GumowskiMiraAttractor get(){
    GumowskiMiraAttractor gm = new GumowskiMiraAttractor();
    for(int i=0;i<NOP;i++){
      gm.parameters[i]=parameters[i];
    }
    return gm;
  }
}

// modified Gumowski Mira transform

class ModGumowskiMiraAttractor extends Attractor{
  
  float cc,sc;
  ModGumowskiMiraAttractor(){
    super();
    label="ModGumowskiMiraAttractor";
    NOP=4;
    parameters = new float[NOP];
    parameters[0]=random(.1f);
    parameters[1]=random(-1f,.5f);
    parameters[2]=random(.1f);
    parameters[3]=2+(int)random(15.0f);
    cc=cos(TWO_PI/parameters[3]);
    sc=sin(TWO_PI/parameters[3]);
  }

  PVector map(float x, float y){
    float nx=sc*y+cc*(parameters[0]*(1f-parameters[2]*y*y)*y+parameters[1]*x+2.0f*(1f-parameters[1])*x*x/(1f+x*x));
    float ny=-sc*x+cc*(parameters[1]*nx+2.0f*(1f-parameters[1])*nx*nx/(1f+nx*nx));
    return new PVector(nx,ny);
  }

  void map(float x, float y, PVector result){
    float tx=y+parameters[0]*(1f-parameters[2]*y*y)*y+parameters[1]*x;
    float ty=-x+2.0f*(1f-parameters[1])*tx*tx/(1f+tx*tx);
    result.x=cc*tx-sc*ty+2.0f*(1f-parameters[1])*x*x/(1f+x*x);
    result.y=cc*ty+sc*tx+parameters[1]*tx;
  }

  void mutate(float f){
    for(int i=0;i<NOP;i++){
      parameters[i]+=random(-f,f);
    }
    cc=cos(TWO_PI/parameters[3]);
    sc=sin(TWO_PI/parameters[3]);

  }

  ModGumowskiMiraAttractor get(){
    ModGumowskiMiraAttractor gm = new ModGumowskiMiraAttractor();
    for(int i=0;i<NOP;i++){
      gm.parameters[i]=parameters[i];
    }
    gm.cc=cos(TWO_PI/parameters[3]);
    gm.sc=sin(TWO_PI/parameters[3]);
    return gm;
  }
}

// A branched attractor with free choice of the two (or more) sub-attractors
class GenericBranchedAttractor extends Attractor{
  Attractor[] subAttractors;
  int NOA;

  GenericBranchedAttractor(){
    super();
    label="GenericBranchedAttractor";
    NOA=2+(int)random(2.999999f);
    NOP=NOA;
    subAttractors=new Attractor[NOA];
    parameters = new float[NOP];
    float total=0f;
    for (int i=0;i<NOP;i++){
      parameters[i]=random(0f,1f);// branching parameter
      total+=parameters[i];
    }
    for (int i=0;i<NOP;i++){
      parameters[i]/=total;
    }
  }

  GenericBranchedAttractor(int n){
    super();
    NOA=n;
    NOP=NOA;
    subAttractors=new Attractor[NOA];
    parameters = new float[NOP];
    float total=0f;
    for (int i=0;i<NOP;i++){
      parameters[i]=random(0f,1f);// branching parameter
      total+=parameters[i];
    }
    for (int i=0;i<NOP;i++){
      parameters[i]/=total;
    }
  }

  void map(float x, float y, PVector result){
    float r=random(1.0f);
    int sel=0;
    float cumul=parameters[0];
    while((r>cumul)&&(sel<NOP-1)){
      sel++;
      cumul+=parameters[sel]; 
    }
    subAttractors[sel].map(x,y,result);
  }

  PVector map(float x, float y){
    PVector result=new PVector();
    float r=random(1.0f);
    int sel=0;
    float cumul=parameters[0];
    while((r>cumul)&&(sel<NOP-1)){
      sel++;
      cumul+=parameters[sel]; 
    }
    subAttractors[sel].map(x,y,result);
    return result;
  }

  void mutate(float f){
    float total=0f;
    for (int i=0;i<NOP;i++){
      parameters[i]=max(parameters[i]+random(-f,f),0f);
      total+=parameters[i];
    }
    for (int i=0;i<NOP;i++){
      parameters[i]/=total;
      subAttractors[i].mutate(f);
    }
  }

  GenericBranchedAttractor get(){
    GenericBranchedAttractor ba = new GenericBranchedAttractor(NOA);   

    for (int i=0;i<NOP;i++){
      ba.parameters[i]=parameters[i];
      ba.subAttractors[i]=subAttractors[i].get();
    }
    return ba;
  }
  
  void info(){
    println(label);
    for(int i=0;i<NOP;i++){
      println("Parameter "+i+" = "+parameters[i]);
    }
    for(int i=0;i<NOP;i++){
      println("Subattractor "+i+" = "+subAttractors[i].label);
      subAttractors[i].info();
    }
  }

}

// A blended attractor with free choice of the two (or more) sub-attractors
class GenericBlendedAttractor extends Attractor{
  Attractor[] subAttractors;
  int NOA;

  GenericBlendedAttractor(){
    super();
    label="GenericBlendedAttractor";
    NOA=2+(int)random(2.999999f);
    NOP=NOA;
    subAttractors=new Attractor[NOA];
    parameters = new float[NOP];
    float total=0f;
    for (int i=0;i<NOP;i++){
      parameters[i]=random(0f,1f);// branching parameter
      total+=parameters[i];
    }
    for (int i=0;i<NOP;i++){
      parameters[i]/=total;
    }
  }

  GenericBlendedAttractor(int n){
    super();
    NOA=n;
    NOP=NOA;
    subAttractors=new Attractor[NOA];
    parameters = new float[NOP];
    float total=0f;
    for (int i=0;i<NOP;i++){
      parameters[i]=random(0f,1f);// branching parameter
      total+=parameters[i];
    }
    for (int i=0;i<NOP;i++){
      parameters[i]/=total;
    }
  }

  void map(float x, float y, PVector result){

    result.set(PVector.mult(subAttractors[0].map(x,y),parameters[0]));
    for(int i=1;i<NOA;i++){
      result.add(PVector.mult(subAttractors[i].map(x,y),parameters[i]));
    }
  }

  PVector map(float x, float y){
    PVector result =PVector.mult(subAttractors[0].map(x,y),parameters[0]);
    for(int i=1;i<NOA;i++){
      result.add(PVector.mult(subAttractors[i].map(x,y),parameters[i]));
    }
    return result;
  }

  void mutate(float f){
    float total=0f;
    for (int i=0;i<NOP;i++){
      parameters[i]=max(parameters[i]+random(-f,f),0f);
      total+=parameters[i];
    }
    for (int i=0;i<NOP;i++){
      parameters[i]/=total;
      subAttractors[i].mutate(f);
    }
  }

  GenericBlendedAttractor get(){
    GenericBlendedAttractor ba = new GenericBlendedAttractor(NOA);   

    for (int i=0;i<NOP;i++){
      ba.parameters[i]=parameters[i];
      ba.subAttractors[i]=subAttractors[i].get();
    }
    return ba;
  }
  
  void info(){
    println(label);
    for(int i=0;i<NOP;i++){
      println("Parameter "+i+" = "+parameters[i]);
    }
    for(int i=0;i<NOP;i++){
      println("Subattractor "+i+" = "+subAttractors[i].label);
      subAttractors[i].info();
    }
  }

}
/* The attractor system runs many particles through a randomly generated map chosen with a certain weighing from one of the
 /  above.
 /  A particle gets updated a fixed number of times (its lifetime) before it is randomly reinitialized
 /  within the limits defined by the lower and upper limits for x and y.
 /  The age of each particle and its agelimit is stored in a separate array.
 /  A high number of particles gives smooth low density areas, a long lifetime gives more detail in high density areas.
 */


class AttractorSystem {
  AttractorSystemParameters parameters;
  // numParticles: number of Particles
  // minParticleLife: shortest possible lifetime
  // maxParticleLife;
  // minX;
  // maxX;
  // minY;
  // maxY;
  // symmetry;
  // centerOfSymmetry;
  // mirror;
  // centerOfMirror;
  // mirrorRotation;
  // rotation;
  // centerOfRotation;

  Attractor attractor;
  Particle[] particles;


  float[] cosLUT;
  float[] sinLUT;
  float cosRot;
  float sinRot;
  float cosMirrorRot;
  float sinMirrorRot;

  AttractorSystem(AttractorSystemParameters ASP){
    parameters=ASP.get();
    reset(true);
    attractor=selectAttractor(parameters.type,true);

    resetPreCalc();
  }

  Attractor selectAttractor(int type, boolean allowGeneric){
    Attractor attractor;
    GenericBranchedAttractor GBrA;
    GenericBlendedAttractor GBlA;
    int r=type;
    if(r==-1){
      if(random(1.0f)<0.5f){
        r=(int)random(3.999999f);
      }
      else{
        r=4+(int)random((allowGeneric)?11.999999f:10.999999f);
      }
    }
    switch(r){
    case 0:
      attractor = new BlendedAttractor();
      return attractor;
    case 1:
      attractor = new BranchedAttractor();
      return attractor;
    case 2:
      attractor = new SimpleBlendedAttractor();
      return attractor;
    case 3:
      attractor = new SimpleBranchedAttractor();
      return attractor;
    case 4:
      attractor = new GumowskiMiraAttractor(); 
      return attractor;
    case 5:
      attractor = new ModGumowskiMiraAttractor(); 
      return attractor;
    case 6:
      attractor = new TrigAttractor(); 
      return attractor;
    case 7:
      attractor = new CliffordAttractor(); 
      return attractor;
    case 8:
      attractor = new PeterdeJongAttractor(); 
      return attractor;
    case 9:
      attractor = new PlaidAttractor(); 
      return attractor;
    case 10:
      attractor = new WreathAttractor(); 
      return attractor;   
    case 11:
      attractor = new ModifiedWreathAttractor(); 
      return attractor; 
    case 12:
      attractor = new DesyncedWreathAttractor(); 
      return attractor; 
    case 13:
      attractor = new GenericWreathAttractor(); 
      return attractor; 
    case 14:
      GBrA = new GenericBranchedAttractor(2);
      for(int i=0;i<GBrA.NOA;i++){
        GBrA.subAttractors[i]= selectAttractor(-1,false);
      }
      return GBrA;
    case 15:
      GBlA = new GenericBlendedAttractor(2);
      for(int i=0;i<GBlA.NOA;i++){
        GBlA.subAttractors[i]= selectAttractor(-1,false);
      }
      return GBlA;
    default:
      attractor = new SimpleBranchedAttractor();
      return attractor;
    }
  }

  void reset(boolean resize){
    if (resize) particles = new Particle[parameters.numParticles];
    for(int i=0;i<parameters.numParticles;i++){
      reset(i, resize);
    }
  }

  void reset(int i, boolean resize){
    if(resize){  
      particles[i]=new Particle(createPVector(),3);
    }
    else{
      particles[i].setAndReset(createPVector());
      particles[i].value=1f;
      particles[i].dead=false;
      particles[i].age=0;
    }
    particles[i].timeOfDeath=parameters.particleLife;
  }

  PVector createPVector(){
    switch(parameters.sourceType){
    case 0:
      return  new PVector(random(parameters.minX,parameters.maxX),random(parameters.minY,parameters.maxY));
    case 1:
      if(random(1.0f)<0.5f){
        return  new PVector(random(parameters.minX,parameters.maxX),0.5f*(parameters.minY+parameters.maxY));
      }
      else{
        return  new PVector(0.5f*(parameters.minX+parameters.maxX),random(parameters.minY,parameters.maxY));
      }
    case 2:
      if(random(1.0f)<0.5f){
        return  new PVector(random(parameters.minX,parameters.maxX),parameters.minY+((int)random(11))*0.1f*(parameters.maxY-parameters.minY));
      }
      else{
        return  new PVector(parameters.minX+((int)random(11))*0.1f*(parameters.maxX-parameters.minX),random(parameters.minY,parameters.maxY));
      }
    case 3:
      float a=random(TWO_PI);
      float r= parameters.maxX;
      return  new PVector(r*cos(a),r*sin(a));
    case 4:
      a=random(TWO_PI);
      r=0.5f*((int)random(1,11))*parameters.maxX;
      return  new PVector(r*cos(a),r*sin(a));
    case 5:
      int iX=(int)random(9.999999f);
      int iY=(int)random(9.999999f);
      while((iX+iY)%2==1){
        iY=(int)random(9.999999f);
      }
      return  new PVector(parameters.minX+(iX+random(1f))*0.1f*(parameters.maxX-parameters.minX),parameters.minY+(iY+random(1f))*0.1f*(parameters.maxY-parameters.minY));
    case 6:
      r= random(10f*parameters.maxX);
      a= r*TWO_PI/parameters.maxX;
      return  new PVector(r*cos(a),r*sin(a));
    default:
      return  new PVector(random(parameters.minX,parameters.maxX),random(parameters.minY,parameters.maxY));
    }
  }

  void setSourceType(int s){
    if(s!=parameters.sourceType){
      parameters.sourceType=s;
      for(int i=0;i<parameters.numParticles;i++){
        reset(i,false);
      }
    }
  }

  void setSymmetry(int s) {
    if(s!=parameters.symmetry){
      parameters.symmetry=s;
      resetPreCalc();
    }
  }

  void setMirrorRotation(float r){
    if(r!=parameters.mirrorRotation){
      parameters.mirrorRotation=r;
      resetPreCalc();
    }
  }

  void setRotation(float r) {
    if(r!=parameters.rotation){
      parameters.rotation=r;
      resetPreCalc();
    }
  }

  void resetPreCalc(){
    cosLUT=new float[parameters.symmetry];
    sinLUT=new float[parameters.symmetry];
    for(int i=0;i<parameters.symmetry;i++){
      cosLUT[i]=cos(i*TWO_PI/parameters.symmetry);
      sinLUT[i]=sin(i*TWO_PI/parameters.symmetry);
    }
    cosMirrorRot=cos(parameters.mirrorRotation-parameters.rotation);
    sinMirrorRot=sin(parameters.mirrorRotation-parameters.rotation);    
    cosRot=cos(parameters.rotation);
    sinRot=sin(parameters.rotation);
  }

  void setRange(float r) {
    if(r!=parameters.maxX){
      parameters.minX=-r;
      parameters.maxX=r;
      parameters.minY=-r;
      parameters.maxY=r;
    }
  }

  void setNumParticles(int nop){
    if(nop!=parameters.numParticles){
      parameters.numParticles=nop;
      particles = new Particle[parameters.numParticles];
      for(int i=0;i<parameters.numParticles;i++){
        reset(i,true);
      }
    }
  }

  void setParticleLife(int ID){
    if(ID!=parameters.particleLife){
      parameters.particleLife=ID;
      for(int i=0;i<parameters.numParticles;i++){
        particles[i].timeOfDeath=parameters.particleLife;
      }
    }
  }

  // Independent copy of the attractor system, the particle array is blank.
  AttractorSystem get(){
    AttractorSystem attractorSystem = new AttractorSystem(parameters);
    attractorSystem.attractor = attractor.get();
    return attractorSystem;
  }

  // Mutate the attractor map
  void mutate(float f){
    attractor.mutate(f);
  }

  //  
  void update(PVector result){
    for(int i=0;i<parameters.numParticles;i++){
      if(particles[i].dead) reset(i,false);
      int NofMirror=0;
      if(parameters.mirror%2==0)NofMirror++;
      if(parameters.mirror%3==0)NofMirror++;
      if(parameters.mirror==0)NofMirror=0;
      float r=random(parameters.symmetry+NofMirror-0.000001f);
      if(r<1f){
        attractor.map(particles[i].x,particles[i].y,result);
        particles[i].set(result);
        particles[i].age++;
        if((sq(particles[i].x-particles[i].buffer[0].x)+sq(particles[i].y-particles[i].buffer[0].y))<1e-12){
          particles[i].dead=true;
          particles[i].value=max(1f,particles[i].timeOfDeath-particles[i].age);
          particles[i].age=(particles[i].timeOfDeath+particles[i].age)/2;
        }
        if(((particles[i].age>=particles[i].timeOfDeath))||(abs(particles[i].x)+abs(particles[i].y)>1e6)){
          // At time of death, reincarnate particle
          particles[i].dead=true;
        }
      }
      else if(r<1+NofMirror){
        float tx=particles[i].x-parameters.centerOfMirror.x;
        float my=particles[i].y-parameters.centerOfMirror.y;
        float mx=cosMirrorRot*tx+sinMirrorRot*my;
        my=cosMirrorRot*my-sinMirrorRot*tx;        
        int mirrorChoice=(int)random(1.999999f)+2;
        while(parameters.mirror%mirrorChoice>0){
          mirrorChoice=(int)random(1.999999f)+2;
        }
        switch(mirrorChoice){
        case 2:
          mx*=-1f;
          break;
        case 3:
          my*=-1f;
          break;
        }
        tx=mx;
        mx=cosMirrorRot*tx-sinMirrorRot*my;
        my=cosMirrorRot*my+sinMirrorRot*tx;
        particles[i].setAndKeep(parameters.centerOfMirror.x+mx,parameters.centerOfMirror.y+my);
      }
      else{
        int s=(int)r-NofMirror;
        float rx=particles[i].x-parameters.centerOfSymmetry.x;
        float ry=particles[i].y-parameters.centerOfSymmetry.y;
        particles[i].setAndKeep(parameters.centerOfSymmetry.x+rx*cosLUT[s]-ry*sinLUT[s],parameters.centerOfSymmetry.y+ry*cosLUT[s]+rx*sinLUT[s]);
      }
    }
  }

  void update(){
    PVector localResult = new PVector();
    update(localResult); 

  }
}