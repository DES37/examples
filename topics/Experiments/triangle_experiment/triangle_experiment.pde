// SM other sketches may be better for illustrating all beginShapes
// this is for fun, want to turn it into a generative growing triangle mesh

void setup() {
  size(600, 200);
}
void draw() {

  //beginShape(TRIANGLES);
  //vertex(30, 75);
  //vertex(40, 20);
  //vertex(50, 75);
  //vertex(60, 20);
  //vertex(70, 75);
  //vertex(80, 20);
  //endShape();

  translate(50, 0);
  //beginShape(TRIANGLE_STRIP);  // need 3+ vertex, cretes triangle with previous two points
  //vertex(30, 75);
  //vertex(40, 20);
  //vertex(50, 75);
  //vertex(30, 30);
  //vertex(60, 20);
  //vertex(70, 75);
  //vertex(80, 20);
  //vertex(90, 75);
  //endShape();

  translate(100, 0);
  beginShape(TRIANGLE_FAN);  // need 3+vertex, first point is center, repeat second point to complete TWO_PI
  vertex(57.5, 50);
  vertex(57.5, 15); 
  vertex(92, 50); 
  vertex(57.5, 85); 
  vertex(22, 50); 
  vertex(57.5, 15); 
  endShape();
}