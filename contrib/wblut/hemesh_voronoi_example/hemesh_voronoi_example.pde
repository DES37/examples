//http://www.wblut.com/2010/10/20/hemesh-voronoi-example/

//HE_Mesh 3.0.0+
import wblut.nurbs.*;
import wblut.hemesh.*;
import wblut.geom.*;
import wblut.core.*;
import wblut.processing.*;
import wblut.math.*;

float[][] points;
int numpoints;
HE_Mesh container;
HE_MeshCollection cells;
int numcells;
WB_Plane P1,P2;
WB_Render render;
void setup() {
  size(1000,1000,P3D);
  smooth(8);
  //create a sphere
  HEC_Geodesic geo=new HEC_Geodesic();
  geo.setRadius(300); 
  container=new HE_Mesh(geo);
  
  //slice off most of both hemispheres
  P1=new WB_Plane(new WB_Point(0,0,-10), new WB_Vector(0,0,1));
  P2=new WB_Plane(new WB_Point(0,0,10), new WB_Vector(0,0,-1));
  HEM_Slice s=new HEM_Slice().setPlane(P1);
  container.modify(s);
  s=new HEM_Slice().setPlane(P2);
  container.modify(s);
  
  //generate points
  numpoints=50;
  points=new float[numpoints][3];
  for(int i=0;i<numpoints;i++) {
    points[i][0]=random(-250,250);
    points[i][1]=random(-250,250);
    points[i][2]=random(-20,20);
  }
  
  //generate voronoi cells
  HEMC_VoronoiCells vcmc=new HEMC_VoronoiCells();
  vcmc.setPoints(points).setContainer(container).setOffset(5);
  cells=vcmc.create();
  numcells=cells.size();
  render=new WB_Render(this);
}

void draw() {
  background(255);
  lights();
  translate(width/2,height/2,0);
  rotateX(1f/height*mouseY*TWO_PI-PI);
  rotateY(1f/width*mouseX*TWO_PI-PI);
  drawFaces();
  drawEdges();
}

void drawEdges(){
  stroke(0);
  strokeWeight(2);
  for(int i=0;i<numcells;i++) {
    render.drawEdges(cells.getMesh(i));
  } 
}

void drawFaces(){
  noStroke();
  for(int i=0;i<numcells;i++) {
    fill(100+i,i,i);
    render.drawFaces(cells.getMesh(i));
  }   
}