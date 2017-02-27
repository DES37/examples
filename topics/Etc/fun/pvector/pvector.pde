/* Spencer Mathews
 * 
 * Networks and Webs
 *
 * started: 5/2016 
 */


float threshold;
float speed = 1;
int num_points = 100;
PVector[] points;

void setup() {
  size(500, 500);
  stroke(0, 16);
  //strokeWeight(1);
  points = new PVector[num_points];
  for (int i = 0; i<points.length; i++) {
    points[i] = new PVector(random(0, width), random(0, height));
  }
}

void draw() {
  background(255);

  threshold = mouseX;
  fill(0);

  // loop through all points
  for (int i = 0; i<points.length; i++) {
    // draw point
    point(points[i].x, points[i].y);

    // connect to nearby points
    // could be interesting to connect to n-nearest
    // think of how to use clever algorithms to speed up
    for (int j = 0; j<points.length; j++) {
      if (PVector.dist(points[i], points[j]) < threshold) {
        line(points[i].x, points[i].y, points[j].x, points[j].y);
      }
    }
  }


  for (int i = 0; i<points.length; i++) {
    points[i].set(points[i].x+random(-speed, speed), points[i].y+random(-speed, speed));
    points[i].x = constrain(points[i].x, 0, width-1);
    points[i].y = constrain(points[i].y, 0, height-1);
  }

  // frame.setTitle() changed to surface.SetTitle() in Processing 3
  //frame.setTitle(int(frameRate) + " fps");
  surface.setTitle(int(frameRate) + " fps");

  text(threshold, 0, height-5);
}