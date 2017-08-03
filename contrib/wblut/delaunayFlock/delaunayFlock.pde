//http://www.wblut.com/2009/02/19/delaunay-triangulation-of-a-flock/

import quickhull3d.*;
GridBoid[] gb;
Grid g;
int numBoids;
float bufferX,bufferY;
float cogX, cogY,cogZ;
Point3d[] points;
QuickHull3D hull;


void setup(){
  size(800,800,P3D);
  background(255);
  numBoids=500;
  g=new Grid(20,new PVector(-450,-450,-45), new PVector(450,450,45));
  gb=new GridBoid[numBoids];
  points = new Point3d[numBoids+4];
  hull = new QuickHull3D();
  for(int i=0;i<numBoids;i++){
    gb[i]=new GridBoid(new PVector(random(-450,450),random(-450,450),0), new PVector(random(-.1,.1),random(-.1,.1),0),g,i);
  }
 
  
}

void draw(){
  generatePoints();
  hull.build (points);
  background(255);
  int[][] faceIndices = hull.getFaces( QuickHull3D.POINT_RELATIVE);
  pushMatrix();
  bufferX=bufferX*0.95f+0.05f*mouseX;
  bufferY=bufferY*0.95f+0.05f*mouseY;
  translate(width/2,height/2); 
  for (int i = 0; i < hull.getNumFaces(); i++)
  {     
    int n=faceIndices[i].length;
    Point3d p1=points[faceIndices[i][0]];
    Point3d p2=points[faceIndices[i][1]];
    Point3d p3=points[faceIndices[i][2]];
    Vector3d v1=new Vector3d(p2.x-p1.x,p2.y-p1.y,p2.z-p1.z);
    Vector3d v2=new Vector3d(p3.x-p2.x,p3.y-p2.y,p3.z-p2.z);
    Vector3d v3=new Vector3d();
    v3.cross(v1,v2);   
    if(v3.z<=0){      
      beginShape();
      for (int k = 0; k <3; k++)    { 
        p1=points[faceIndices[i][k]];
        if(faceIndices[i][k]<numBoids){        
        fill(120*sq(1.0f-gb[faceIndices[i][k]].vel.y)+120*sq(1.0f-gb[faceIndices[i][k]].vel.x));
        }
        else{
         fill(255); 
        }
        int cx=(int)(((float)p1.x+450f)/900f*448);
        int cy=(int)(((float)p1.y+450f)/900f*448);
        vertex((float)p1.x,(float)p1.y);
      }
      endShape(CLOSE);
      
    }
    

  }
  popMatrix();



  for(int i=0;i<numBoids;i++){

    gb[i].update(false);
  }






}

void generatePoints(){
  for(int i=0;i< numBoids;i++){
    points[i]=new Point3d(gb[i].pos.x, gb[i].pos.y,0);
    points[i].z=points[i].x*points[i].x+points[i].y*points[i].y;
  }
  points[numBoids]=new Point3d(-450f, -450f,450f*900f);
  points[numBoids+1]=new Point3d(-450f, 450f,450f*900f);
  points[numBoids+2]=new Point3d(450f, 450f,450f*900f);
  points[numBoids+3]=new Point3d(450f, -450f,450f*900f);

}




void mouseClicked(){
  for(int i=0;i<numBoids;i++){
    gb[i].pos.set(random(-450,450),random(-450,450),0);
    gb[i].vel.set(random(-1,1),random(-1,1),0);
  }
}

class Boid{
  PVector pos;
  PVector vel;
  PVector acc;
  int id;
  float maxForce;   
  float maxSpeed;
  PVector sep;
  PVector ali;
  PVector coh;
  PVector flee;
  PVector diff;

  Boid(PVector p, PVector v, int id){
    pos=new PVector(p.x,p.y,p.z); 
    vel=new PVector(v.x,v.y,v.z);
    acc=new PVector();
    sep=new PVector();
    ali=new PVector();
    coh=new PVector();

    diff=new PVector();
    this.id=id;
    maxForce=0.01f;
    maxSpeed=1.0f;

  }

  void flock(ArrayList neighbors,float r2, boolean lines){
    float alisum=0f;
    float sepsum=0f;        

    sep.set(0,0,0);
    ali.set(0,0,0);
    coh.set(0,0,0);


    for(int i=0;i<min(5,neighbors.size());i++){//neighbors.size();i++){
      GridBoidNeighbor gbn = (GridBoidNeighbor)(neighbors.get(i));
      GridBoid neighbor=gbn.neighbor; 
      float d2=gbn.distance2;

      if(d2<0.25f*r2){     
        if(lines) line(pos.x,pos.y,pos.z,gbn.pos.x,gbn.pos.y,gbn.pos.z);
        diff.set(pos.x-gbn.pos.x,pos.y-gbn.pos.y,pos.z-gbn.pos.z);
        diff.div(d2);
        sep.add(diff.x,diff.y,diff.z);
        sepsum++;       
      }

      if(d2<r2){  
        coh.add(gbn.pos.x,gbn.pos.y,gbn.pos.z);
        diff.set(neighbor.vel.x,neighbor.vel.y,neighbor.vel.z);
        ali.add(diff);       
        alisum++;
      }      
    }
    if (sepsum>0) sep.div(.5f*sepsum);
    if (alisum>0) {
      ali.div(alisum);
      coh.div(alisum);
      diff.set(coh.x,coh.y,coh.z);
      steer(diff,coh); 



    }

    ali.limit(maxForce);
    acc.add(sep);
    acc.add(ali);
    acc.add(coh);
    


  }

  void update(){
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel); 
    acc.set(0,0,0);
  }

  void render(){
    vertex(pos.x,pos.y,pos.z);
    vertex(pos.x+vel.x,pos.y+vel.y,pos.z+vel.z);

  }

  void steer(PVector target, PVector steer) {
    PVector desired = PVector.sub(target,pos); 
    float d2 = sq(desired.x)+sq(desired.y)+sq(desired.z); 
    if (d2 > 0) {      
      desired.div(d2);
      desired.mult(maxSpeed*maxSpeed);
      steer.set(desired.x-vel.x, desired.y-vel.y,desired.z-vel.z);
      steer.limit(maxForce);
    } 
    else {
      steer.set(0,0,0);
    }
  }
}

class GridBoid extends Boid{
  PVector index;
  PVector prevIndex;
  Grid parent;


  GridBoid(PVector p, PVector v, Grid g, int id){
    super(p,v, id);
    parent=g;
    index=new PVector();
    prevIndex=new PVector();
    parent.getIndex(p, index);
    parent.add(this, index);
  }

  void update(boolean lines){  
    prevIndex.set(index.x,index.y,index.z);
    super.flock(parent.getNeighbors(this,true),parent.r2,lines);
    super.update();   
    parent.wrap(pos);
    parent.getIndex(pos, index);
    if((index.x!=prevIndex.x)||(index.y!=prevIndex.y)||(index.z!=prevIndex.z)){
      parent.remove(this, prevIndex);
      parent.add(this, index);
    }



  }

}

class GridBoidNeighbor{
  GridBoid neighbor;
  float distance2;
  PVector pos;

  GridBoidNeighbor(GridBoid b, float d2, PVector p){
    neighbor=b;
    distance2=d2;
    pos=p;
  }

}

class Grid{
  GridCell[] cells ;
  PVector limits;
  PVector min;
  PVector max;
  float r2;

  Grid(int w,  PVector min, PVector max){

    this.min=new PVector(min.x,min.y,min.z);
    this.max=new PVector(max.x,max.y,max.z);
    limits=new PVector(w,w,w);
    r2=sq((max.x-min.x)/w);
    limits.y=(int)(w*(max.y-min.y)/(max.x-min.x)+0.5f);
    limits.z=(int)(w*(max.z-min.z)/(max.x-min.x)+0.5f);  
    cells=new GridCell[(int)limits.x*(int)limits.y*(int)limits.z];
    for (int i=0;i<(int)limits.x*(int)limits.y*(int)limits.z;i++){
      cells[i]=new GridCell(); 
    }

  }

  void wrap(PVector pos){
    if(pos.x<min.x) pos.x+=(max.x-min.x); 
    if(pos.x>=max.x) pos.x-=(max.x-min.x);
    if(pos.y<min.y) pos.y+=(max.y-min.y); 
    if(pos.y>=max.y) pos.y-=(max.y-min.y);
    if(pos.z<min.z) pos.z+=(max.z-min.z); 
    if(pos.z>=max.z) pos.z-=(max.z-min.z);
  }

  void bounce(PVector pos,PVector vel){
    if(pos.x<min.x){ 
      vel.x*=-1;
      pos.x=2*min.x-pos.x;
    }
    if(pos.x>=max.x){ 
      vel.x*=-1;
      pos.x=2*max.x-pos.x;
    }
    if(pos.y<min.y){ 
      vel.y*=-1;
      pos.y=2*min.y-pos.y;
    }
    if(pos.y>=max.y){ 
      vel.y*=-1;
      pos.y=2*max.y-pos.y;
    }
    if(pos.z<min.z){ 
      vel.z*=-1;
      pos.z=2*min.z-pos.z;
    }
    if(pos.z>=max.z){ 
      vel.z*=-1;
      pos.z=2*max.z-pos.z;
    }
  }

  void getIndex(PVector p, PVector result){
    result.x=(int)((p.x-min.x)/(max.x-min.x)*limits.x-0.000001f);
    result.y=(int)((p.y-min.y)/(max.y-min.y)*limits.y-0.000001f);
    result.z=(int)((p.z-min.z)/(max.z-min.z)*limits.z-0.000001f);
  }

  void add(GridBoid b, PVector index){
    if((int)index.x+(int)limits.x*((int)index.y+(int)limits.y*(int)index.z)>(int)limits.x*(int)limits.y*(int)limits.z-1) println(index.x+" "+index.y+" "+index.z+" "+limits.x+" "+limits.y+" "+limits.z);
    cells[(int)index.x+(int)limits.x*((int)index.y+(int)limits.y*(int)index.z)].add(b);
  }

  void remove(GridBoid b, PVector index){
    cells[(int)index.x+(int)limits.x*((int)index.y+(int)limits.y*(int)index.z)].remove(b);
  }

  ArrayList getNeighbors(GridBoid b, boolean wrap){

    int lx=(int)b.index.x-1;
    int ux=(int)b.index.x+1;
    int ly=(int)b.index.y-1;
    int uy=(int)b.index.y+1;  
    int lz=(int)b.index.z-1;
    int uz=(int)b.index.z+1; 
    float locx,locy,locz;
    float loci,locj,lock;
    ArrayList result= new ArrayList();
    if(wrap){
      for(int i=lx;i<ux+1;i++){
        for(int j=ly;j<uy+1;j++){
          for(int k=lz;k<uz+1;k++){
            loci=(i<0)?(i+(int)limits.x-1):((i>(int)limits.x-1)?i-limits.x:i);
            locj=(j<0)?(j+(int)limits.y-1):((j>(int)limits.y-1)?j-limits.y:j);
            lock=(k<0)?(k+(int)limits.z-1):((k>(int)limits.z-1)?k-limits.z:k);

            for(int m=0;m<cells[(int)(loci+limits.x*(locj+limits.y*lock))].boids.size();m++){
              GridBoid potentialNeighbor =(GridBoid)(cells[(int)(loci+limits.x*(locj+limits.y*lock))].boids.get(m));
              locx=(i<0)?(potentialNeighbor.pos.x-max.x+min.x):((i>(int)limits.x-1)?potentialNeighbor.pos.x+max.x-min.x:potentialNeighbor.pos.x);
              locy=(j<0)?(potentialNeighbor.pos.y-max.y+min.y):((j>(int)limits.y-1)?potentialNeighbor.pos.y+max.y-min.y:potentialNeighbor.pos.y);
              locz=(k<0)?(potentialNeighbor.pos.z-max.z+min.z):((k>(int)limits.z-1)?potentialNeighbor.pos.z+max.z-min.z:potentialNeighbor.pos.z);
              float d2=sq(b.pos.x-locx)+sq(b.pos.y-locy)+sq(b.pos.z-locz);

              if((d2>0f)&&(d2<r2)){
                result.add(new GridBoidNeighbor(potentialNeighbor,d2,new PVector(locx,locy,locz)));
              }
            }         
          }
        }
      }
    }
    else{
      for(int i=lx;i<ux+1;i++){
        for(int j=ly;j<uy+1;j++){
          for(int k=lz;k<uz+1;k++){
            loci=(i<0)?0:((i>(int)limits.x-1)?limits.x-1:i);
            locj=(j<0)?0:((j>(int)limits.y-1)?limits.y-1:j);
            lock=(k<0)?0:((k>(int)limits.z-1)?limits.z-1:k);

            for(int m=0;m<cells[(int)(loci+limits.x*(locj+limits.y*lock))].boids.size();m++){
              GridBoid potentialNeighbor =(GridBoid)(cells[(int)(loci+limits.x*(locj+limits.y*lock))].boids.get(m));
              locx=potentialNeighbor.pos.x;
              locy=potentialNeighbor.pos.y;
              locz=potentialNeighbor.pos.z;
              float d2=sq(b.pos.x-locx)+sq(b.pos.y-locy)+sq(b.pos.z-locz);

              if((d2>0f)&&(d2<r2)){
                result.add(new GridBoidNeighbor(potentialNeighbor,d2,new PVector(locx,locy,locz)));
              }
            }         
          }
        }
      }
    }

    return result;       



  }



  void report(){
    for (int i=0;i<limits.x*limits.y*limits.z;i++){
      println(i+" "+cells[i].boids.size());
    }
  }


}

class GridCell{
  ArrayList boids;

  GridCell(){
    boids=new ArrayList();
  }

  void add(GridBoid b){
    boids.add(b); 
  }

  void remove(GridBoid b){
    boids.remove(b); 
  }


}