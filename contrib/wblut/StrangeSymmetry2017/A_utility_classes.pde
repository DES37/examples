// A Particle is an extension of PVector that stores previous value in a buffer array (if set() is properly used).
// The original PVector x,y,z properties are directly available for efficiency. 
// Particle also contains some status variables such as its age, lifetime and hit-value (normally 1).

class Particle extends PVector{
  int bufferLength; // Number of previous positions to store.
  PVector[] buffer; // PVector buffer of previous positions.
  int age;
  int timeOfDeath;

  // The next two properties are added to include an optimalization trick. If a particle gets stuck in a drain
  // such as the center of a spiral the program will add the remaining lifetime of the particle to this location instead
  // of going through lots of stationary updates. In pseudo-code: if velocity=0 then set the value to remaining lifetime and
  // declare the particle dead. On the next update, this higher value of the particle is added in one go, the value is reset to 1 and the particle is reincarnated.

  float value;  // Amount to add to hit count on the grid. Normally 1.
  boolean dead; // If this flag is set, the oparticle is reinitialized on the next update.

  float hue;
  float sat;
  float bri;
  
  float speed;
  float acc;

  Particle(){
    super();
    bufferLength=1;
    buffer=new PVector[1];
    buffer[0] = new PVector();
    value=1f;
    dead=false;
    age=0;
    timeOfDeath=1;
  }

  Particle(float x, float y, int bufferLength){
    super(x,y,0f);
    this.bufferLength= max(1,bufferLength);
    buffer=new PVector[this.bufferLength];
    for(int i=0;i<this.bufferLength;i++){
      buffer[i] = new PVector(x,y,0f);
    }
    value=1f;
    dead=false;
    age=0;
    timeOfDeath=1;
    hue=map(x*x+y*y,0,1,0,1);
    sat=1f;
    bri=0f;
    speed=0f;
    acc=0f;
  }


  Particle(PVector p,int bufferLength){
    this(p.x,p.y,bufferLength);
  }

  // use set to store a new position and store the previous positions 

PVector set(float x, float y){    
    for(int i=0;i<bufferLength-1;i++){
      buffer[bufferLength-i-1].x=buffer[bufferLength-i-2].x;
      buffer[bufferLength-i-1].y=buffer[bufferLength-i-2].y;
      buffer[bufferLength-i-1].z=buffer[bufferLength-i-2].z;
    }
    buffer[0].x=this.x;
    buffer[0].y=this.y;
    buffer[0].z=0f;
    this.x=x;
    this.y=y;
    this.z=0f;
    acc=speed;
    speed=dist(buffer[0], this);
    acc-=speed;
return this;
  }

  PVector set(PVector p){
    return set(p.x,p.y);
  }

  // setAndReset stores a new position and resets the buffer: use this to avoid particles
  // being reincarnated with huge speeds or accelerations (difference between current
  // position and previous positions).

  void setAndReset(float x, float y){
    for(int i=0;i<bufferLength;i++){
      buffer[i].x=x;
      buffer[i].y=y;
      buffer[i].z=0f;
    }
    this.x=x;
    this.y=y;
    this.z=0f;
      speed=0f;
    acc=0f;

  }

  void setAndReset(PVector p){
    setAndReset(p.x,p.y);
  }

  // setAndKeep stores a new position and keeps the relative positions of the buffer: use this
  // to move a particle without affecting its speed or acceleration (difference between current
  // position and previous positions). This is used for rotation and mirroring.

  void setAndKeep(float x, float y){
    for(int i=bufferLength-1;i>-1;i--){
      buffer[i].x+=this.x-x;
      buffer[i].y+=this.y-y;
      buffer[i].z=0f;
    }
    this.x=x;
    this.y=y;
    this.z=0f;
  }

  void setAndKeep(PVector p){
    setAndKeep(p.x,p.y);
  }
}


// Pre-calculated normalized 2D-Gaussian functions
// The first two indices give the coordinates for the planar function. The origin is (maxSize,maxSize).
// The third index selects the spread: 0 is no spread (1 in the center, 0 everywhere else).
// Higher indices give larger spreads: index/rangeFactor. Focus biases the spread function through a power law.

class GaussianConvolutionKernel{
  float[][][] v; // function values
  int[] limits; // square range where the function is non-zero.
  int maxSize; // maximum size of kernel in "array units"
  int maxRange; // maximum size of kernel in pixels

  GaussianConvolutionKernel(int maxRange, int maxSize, float rangeFactor, float focus){
    this.maxRange=maxRange;
    this.maxSize=maxSize;
    v = new float[2*maxSize+1][2*maxSize+1][maxRange+1];
    limits = new int[maxRange+1];
    v[maxSize][maxSize][0]=1.0f;
    limits[0]=0;   
    for(int r=1; r<maxRange+1;r++){
      float sigma=max(0.4f,r/rangeFactor*FastFunctions.pow(r/(float)maxRange,focus)); // standard deviations < 0.4 give a center value > 1, avoid this...
      limits[r]=constrain((int)(abs(sigma*sigma*FastFunctions.log2(0.001f*TWO_PI*sigma*sigma))+0.5f),0,maxSize); // cutoff function at 0.001.
      for(int i=-limits[r];i<limits[r]+1;i++){
        for(int j=-limits[r];j<limits[r]+1;j++){             
          v[i+maxSize][j+maxSize][r]=1f/(TWO_PI*sigma*sigma)*exp(-(i*i+j*j)/(2*sigma*sigma));         
        }
      }
    }
  }

}