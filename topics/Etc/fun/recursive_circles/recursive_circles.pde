/* Recursively construct circles
 *
 * author:Spencer Mathews
 * date: 4/2016
 */ 

float minRadius;

void setup() {
  size(500,500);
  ellipseMode(RADIUS);
  background(0);
  stroke(255);
  fill(0);
  //noLoop();
  minRadius=5;
}

void draw() {
  background(0);
  float x,y,r;
  x=width/2;
  y=height/2;
  r=width/2;
  line(0,y,width,y);
  
  minRadius = map(mouseX, 0, width, 1, width); 
  drawCircle(x,y,r);

}


void drawCircle(float x, float y, float r) {
 ellipse(x,y,r,r);
 println(x,y,r);
 
 if (r >= minRadius) {
  drawCircle(x+r/2,y,r/2);
  drawCircle(x-r/2,y,r/2);
 }
}