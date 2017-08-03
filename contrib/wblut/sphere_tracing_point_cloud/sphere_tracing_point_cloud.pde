//http://www.wblut.com/2017/05/27/sphere-tracing-point-cloud/

import java.util.List;

List<SphereTracer> tracers;
List<PVector> points;

void setup() {
  fullScreen(P3D);
  smooth(8);
  initializeTracers();
  SDF sdf=createSDF();
  tracePoints(sdf);
}

void initializeTracers(){
  //a regular grid of parallel tracers
  tracers=new ArrayList<SphereTracer>();
  float x, y;
  float zmax=1500;
  float cutoff=3000; 
  int resX=100; 
  int hResX=resX/2;
  float sX=600.0;
  float dX=sX/resX;
  int resY=100; 
  int hResY=resY/2;
  float sY=600.0;
  float dY=1000.0/resY;

  for (int i=0; i<resX+1; i++) {
    x=(i-hResX)*dY;
    for (int j=0; j<resY; j++) {
      y=(j-hResY)*dY;
      tracers.add(new SphereTracer(new PVector(x, y, zmax), new PVector(0, 0, -1), cutoff, 0.1));
    }
  }
}

SDF createSDF(){
  //Union some spheres
  UnionSDF sdf=new UnionSDF();
  for (int r=0; r<40; r++) {
    sdf.add(new SphereSDF(random(10, 80), new PVector(random(-250, 250), random(-250, 250), random(-250, 250))));
  }
  return sdf;
}

void tracePoints(SDF sdf){
  points=new ArrayList<PVector>();
  for (SphereTracer tracer : tracers) {
    PVector p=tracer.trace(sdf);
    if (p!=null) points.add(p);
  }
}

void draw() {
  background(25);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(200, 200, 200, -1, -1, 1);
  translate(width/2, height/2);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, -PI, PI));
  stroke(255, 150);
  for(PVector point:points){
   point(point.x,point.y,point.z); 
  }
  
}

//Simple class that sphere traces along a ray
static class SphereTracer {
  Ray ray;
  float closestApproach;
  float cutoff; 
  float precision;
  float t;
  int steps;
  static int MAXSTEPS;

  //Create SphereTracer at origin, with direction.
  //If it traces beyond cutoff it will stop and return "null".
  //If signed distance is smaller than precision, it will return its current position.
  SphereTracer(PVector origin, PVector direction, float cutoff, float precision) {
    ray=new Ray(origin, direction);
    this.cutoff=cutoff;
    closestApproach= Float.POSITIVE_INFINITY;
    this.precision=precision;
    t=0;
    steps=0;
  }

  //Sphere trace a signed distance function
  PVector trace(SDF sdf) {
    t=0.0;
    steps=0;
    float d;
    do {
      d=sdf.signedDistance(ray.getPoint(t));
      if (d<closestApproach) closestApproach=d;
      if (d<precision) return ray.getPoint(t);
      t+=d;
      steps++;
    } while (t<cutoff);
    return null;
  }
}

//Interface that implements a signed distance function
static interface SDF {
  float signedDistance(PVector p);
}

//Implementation of SDF that gives signed distance to sphere
static class SphereSDF implements SDF {
  float radius;
  PVector center;
  
  //Create sphere with radius and center
  SphereSDF(float r, PVector center) {
    radius=r;
    this.center=center.copy();
  }

  float signedDistance(PVector p) {
    return PVector.sub(p, center).mag()-radius;
  }
}

//Implementation of SDF that unions several component SDFs
static class UnionSDF implements SDF {
  List<SDF> components;

  UnionSDF() {
    components=new ArrayList<SDF>();
  }

  UnionSDF add(SDF sdf) {
    components.add(sdf);
    return this;
  }

  float signedDistance(PVector p) {
    float sd=Float.POSITIVE_INFINITY;
    for (int i=0; i<components.size(); i++) {
       sd=Math.min(sd, components.get(i).signedDistance(p)); 
    }
    return sd;
  }
}

static class Ray {
  PVector origin;
  PVector direction;
  
  //Create ray with origin and direction
  Ray(PVector o, PVector dir){
   origin=o.copy();
   direction=dir.copy();
   direction.normalize();
  } 
  
  //Get point on ray at distance t from origin
  PVector getPoint(float t){
   PVector result=direction.copy();
   result.mult(t);
   result.add(origin);
   return result;
  }
}