// Spencer Mathews, April 2016
// How to use HSB colorMode


void setup() {
  size(360, 100);
  colorMode(HSB, 360, 100, 100, 100);
  noLoop();
}


void draw() {
  for (int i=0; i<360; i+=2) {
    //fill(i, 100, 100);
    stroke(i, 100, 100);
    line(i, 0, i, 360);
    println(g.strokeWeight);
 }
}