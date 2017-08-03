
// Collection of the parameters that define the attractorsystem and the tracing particles
class AttractorSystemParameters{
  int numParticles;
  int particleLife;
  float minX;
  float maxX;
  float minY;
  float maxY;
  int symmetry;
  PVector centerOfSymmetry;
  int mirror;
  PVector centerOfMirror;
  float mirrorRotation;
  float rotation;
  PVector centerOfRotation;
  int sourceType;
  int type;

  AttractorSystemParameters(int numParticles,int particleLife,float minX,float maxX, float minY,float maxY,int symmetry,
  PVector centerOfSymmetry,int mirror,PVector centerOfMirror,float mirrorRotation,float rotation, PVector centerOfRotation, int sourceType, int type){
    this.numParticles=numParticles;
    this.particleLife=particleLife;
    this.minX=minX;
    this.maxX=maxX;
    this.minY=minY;
    this.maxY=maxY;
    this.symmetry=symmetry;
    this.centerOfSymmetry=centerOfSymmetry.get();
    this.mirror=mirror;
    this.centerOfMirror=centerOfMirror.get();
    this.mirrorRotation=mirrorRotation;
    this.rotation=rotation;   
    this.centerOfRotation=centerOfRotation.get();
    this.sourceType=sourceType;    
    this.type=type;
  }

  AttractorSystemParameters(AttractorSystemParameters ASP){
    this.numParticles=ASP.numParticles;
    this.particleLife=ASP.particleLife;
    this.minX=ASP.minX;
    this.maxX=ASP.maxX;
    this.minY=ASP.minY;
    this.maxY=ASP.maxY;
    this.symmetry=ASP.symmetry;
    this.centerOfSymmetry=ASP.centerOfSymmetry.get();
    this.mirror=ASP.mirror;
    this.centerOfMirror=ASP.centerOfMirror.get();
    this.rotation=ASP.rotation;
    this.mirrorRotation=ASP.mirrorRotation;
    this.centerOfRotation=ASP.centerOfRotation.get();
    this.sourceType=ASP.sourceType;
    this.type=ASP.type;
  }

  AttractorSystemParameters get(){
    return new AttractorSystemParameters(this);
  }
}

// Collection of the parameters that define the accumulation grid and the visible part of the attractor
class GridParameters{
  int resX;
  int resY; 
  float minVisX,minVisY,maxVisX,maxVisY;
  GridParameters(int resX, int resY, float minVisX, float maxVisX, float minVisY, float maxVisY){
    this.resX=resX;
    this.resY=resY;
    this.minVisX=minVisX;
    this.minVisY=minVisY;
    this.maxVisX=maxVisX;
    this.maxVisY=maxVisY;
  }

  GridParameters( GridParameters GP){
    this.resX=GP.resX;
    this.resY=GP.resY;
    this.minVisX=GP.minVisX;
    this.minVisY=GP.minVisY;
    this.maxVisX=GP.maxVisX;
    this.maxVisY=GP.maxVisY;
  }

  GridParameters get(){
    return new GridParameters(this);
  }
}

// Collection of the parameters that control the display of the accumulation grid
class AttractorDisplayParameters{
  int displayX;
  int displayY;
  int displayWidth;
  int displayHeight;
  int cutoff; 
  int centerMode;
  int quality;
  int gridSize; 
  genericFunction briFunction;
  genericFunction hueFunction;
  genericFunction satFunction;

  AttractorDisplayParameters(int displayX, int displayY, int displayWidth, int displayHeight,int cutoff, int centerMode, int quality, int gridSize,  genericFunction hueFunction,  genericFunction satFunction,  genericFunction briFunction){
    this.cutoff=cutoff;
    this.displayX=displayX;
    this.displayY=displayY;
    this.displayWidth=displayWidth;
    this.displayHeight=displayHeight;
    this.centerMode=centerMode;
    this.quality=quality;
    this.gridSize=gridSize;
    this.briFunction=briFunction.get();
    this.hueFunction=hueFunction.get();
    this.satFunction=satFunction.get();
  }

  AttractorDisplayParameters( AttractorDisplayParameters ADP){
    this.cutoff=ADP.cutoff;
    this.displayX=ADP.displayX;
    this.displayY=ADP.displayY;
    this.displayWidth=ADP.displayWidth;
    this.displayHeight=ADP.displayHeight;
    this.centerMode=ADP.centerMode;
    this.quality=ADP.quality;
    this.gridSize=ADP.gridSize;
    this.briFunction=ADP.briFunction.get();
    this.hueFunction=ADP.hueFunction.get();
    this.satFunction=ADP.satFunction.get();
  }

  AttractorDisplayParameters get(){
    return new AttractorDisplayParameters(this);
  }



}