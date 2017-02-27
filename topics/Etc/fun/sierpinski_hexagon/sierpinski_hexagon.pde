/* Spencer Mathews, 11/2016
 *
 * 
 *
 * Inspired by http://math.bu.edu/DYSYS/arcadia/sect3.html
 */
 
Hexagon h;
PVector p;
float interp = 2.0/3.0;  // amount of interpolation between points
int iteratesPerFrame = 100;

void setup() {
  size(500, 500, FX2D);

  float r = 240;
  h = new Hexagon(width/2.0, height/2.0, r);
  p = PVector.random2D();
  p.mult(random(r));
  background(0);
  h.displayShape();

  float trashIterates = 15;
  for ( int j=0; j<trashIterates; j++) {
    int i = int(random(h.points.length));
    p = p.lerp(h.points[i], interp);
  }
}
void draw() {
  translate(width/2, height/2);

  for (int j=0; j<iteratesPerFrame; j++) {
    int i = int(random(h.points.length));
    p = p.lerp(h.points[i], interp);

    //fill(255, 0, 0);
    //ellipse(p.x, p.y, 2, 2);
    stroke(255, 0, 0);
    point(p.x, p.y);
  }
  surface.setTitle(int(frameRate) + " fps");
}



class Hexagon {

  PVector pos;
  float r;
  PVector[] points;

  Hexagon(float x, float y, float r) {
    this.pos = new PVector(x, y);
    this.points = new PVector[6];

    float dTheta = TWO_PI/6;
    for (int i=0; i<points.length; i++) {
      points[i] = PVector.fromAngle(dTheta*i);  // create unit vector
      points[i].mult(r);                        // scale to desired radius
    }
  }

  void displayShape() {
    pushMatrix();
    resetMatrix();
    translate(pos.x, pos.y);
    stroke(0);
    fill(255);
    beginShape();
    for (int i=0; i<points.length; i++) {
      vertex(points[i].x, points[i].y);
    }
    vertex(points[0].x, points[0].y);
    endShape();
    popMatrix();
  }
  void displayFan() {
    pushMatrix();
    resetMatrix();
    translate(pos.x, pos.y);
    stroke(0);
    fill(255);
    beginShape(TRIANGLE_FAN);
    vertex(0, 0);
    for (int i=0; i<points.length; i++) {
      vertex(points[i].x, points[i].y);
    }
    vertex(points[0].x, points[0].y);
    endShape();
    popMatrix();
  }
}