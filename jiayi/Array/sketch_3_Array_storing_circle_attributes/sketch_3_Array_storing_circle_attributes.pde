int no = 20;
float[] x = new float[no]; // x-position
float[] y = new float[no]; // y-position
float[] r = new float[no]; // radius
int[] c = new int[no]; // color of circle 0-red, 1- green

void setup(){
  size(600,400);
 for (int i = 0; i < no; i++){  
   r[i] = random(10, 50);
   x[i] = random(r[i], width - r[i]); // always show full circles
   y[i] = random(r[i], height - r[i]); // always show full circles
   c[i] = int(random(0,2));
}
}
 
void draw(){
  background(255);
  noStroke();
  for (int i=0; i<20; i++){
 
    if (dist(x[i], y[i], mouseX, mouseY) <= r[i]) {
      if (c[i] == 0) {
      fill(255, 0, 0, 128);
      ellipse(x[i], y[i], r[i]+10, r[i]+10); // if c[i] = 0, draw larger red circle
      } else {
      fill(0, 255, 0, 128); // fill red
      ellipse(x[i], y[i], r[i]-10, r[i]-10); // if c[i] = 1, draw smaller green circle
      }
    } else {
      if (c[i] == 0) {
        fill(255, 0, 0, 128); // fill red
      } else {
        fill(0, 255, 0, 128); // fill green
      }
      ellipse(x[i], y[i], r[i], r[i]);
    }
  }
}