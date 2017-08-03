//http://www.wblut.com/2016/01/16/windswept-b/

import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

HE_Mesh mesh;
WB_AABBTree tree;
WB_Render render;
WB_RandomOnSphere rnds;
WB_Ray randomRay;
WB_Vector bias;
boolean growing;
int counter;

void setup() {
  fullScreen(P3D);
  smooth(8);
  render=new WB_Render(this);
  rnds=new WB_RandomOnSphere();
  createMesh(); 
}

void createMesh() {
  
  HEC_Beethoven creator=new HEC_Beethoven();
  creator.setScale(5).setZAngle(PI/3);
  mesh=new HE_Mesh(creator);
  mesh.simplify(new HES_TriDec().setGoal(0.5));
  tree=new WB_AABBTree(mesh, 10);
  
  growing=true;
  counter=0;
  bias=rnds.nextVector();
}


void draw() {
  background(20);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(width/2, height/2, 0);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, PI, -PI));

  hint(DISABLE_DEPTH_TEST);
  noLights();
  fill(255);
  noStroke();
  pushMatrix();
  scale(1.8);
  render.drawFaces(mesh);
  popMatrix();

  hint(ENABLE_DEPTH_TEST);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  scale(1.6);
  fill(255);
  noStroke();
  render.drawFaces(mesh);
  noFill();
  stroke(0, 50);
  render.drawEdges(mesh);


  if (growing) {
    for (int i=0; i<5; i++) {
      grow();
      counter++;
    }
  }
  
  if (counter==500) {
    mesh.subdivide(new HES_CatmullClark());
    growing=false;
    counter++;
  }
}

void grow() {
  WB_Point rayOrigin=new WB_Point(bias).mulSelf(-500);
  WB_Vector rayDirection=bias.add(random(-0.3, 0.3), random(-0.3, 0.3), random(-0.3, 0.3));
  randomRay=new WB_Ray(rayOrigin, rayDirection);
  HE_FaceIntersection fi=HET_MeshOp.getFurthestIntersection( tree, randomRay);
  WB_Point point;
  if (fi!=null) {
    point=fi.point;
    point.addMulSelf(120, randomRay.getDirection());
    HEM_TriSplit.splitFaceTri(mesh, fi.face, point);
    tree=new WB_AABBTree(mesh, 10);
    stroke(255,0,0);
    render.drawRay(randomRay,1500);
  }
}

void mousePressed(){
 createMesh();  
}