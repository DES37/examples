/* Spencer Mathews, 10/2016
 *
 * Logistic map cobweb plot
 *
 * ! consider clicking to get second, third interates, etc.
 */


/* configure simulation */
int timeSteps = 2;
float r = 3.5;

/* configure plotting */
float dx = 0.01;
float scaleX;
float scaleY;

void setup() {
  size(800, 800, FX2D);  // FX2D is noticeable faster than default renderer

  scaleX = width;
  scaleY = height;
  //noLoop();
}

void draw() {
  background(0);

  float x;
  float px;

  // set origin to lower left corner, note that +y is now off display
  translate(0, height);

  // draw diagonal line
  stroke(255);
  line(0, 0, width, -height);

  // set r parameter based on vertical mouse position
  r = map(mouseY, 0, height, 4, 0);

  /* draw function curve */
  // can alternatively use curveVertex, in which case the first and last point must be duplicated as guide points
  noFill();
  beginShape();
  //vertex(0*scaleX, -logisticMap(r, 0)*scaleY);
  for (x=0; x<=1.0; x+=dx) {
    vertex(x*scaleX, -logisticMap(r, x)*scaleY);
  }
  // make sure to draw point at 1, since we may miss it do floating point imprecision
  vertex(1.0*scaleX, -logisticMap(r, 1.0)*scaleY);
  endShape();

  // draw iterates as red lines
  stroke(255, 0, 0);

  // set initial x value based on horizonatal mouse position
  x = map(mouseX, 0, width, 0, 1);

  /* display parameters */
  fill(255);
  textSize(24);
  text("r = "+r, 12, -height+30);
  text("x0 = "+x, 12, -height+60);
  
  /* draw first iterate */
  px = x;
  x = logisticMap(r, x);
  line(px*scaleX, 0*scaleY, px*scaleX, -x*scaleY);  // draw first vertical line to meet function curve

  /* iterate */
  for (int i=1; i<timeSteps; i++) {
    line(px*scaleX, -x*scaleY, x*scaleX, -x*scaleY);  // draw horizontal line to meet diagonal
    px = x;
    x = logisticMap(r, x);
    line(px*scaleX, -px*scaleY, px*scaleX, -x*scaleY);  // draw vertical line to meet function curve
  }
  
  //text("x_final = "+x, 12, -height+90);
  
  surface.setTitle(int(frameRate) + " fps");
}

/* iterate logistic map
 *
 */
float logisticMap(float r, float x) {
  return r*x*(1-x);
}