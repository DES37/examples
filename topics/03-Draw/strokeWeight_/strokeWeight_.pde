/* Using stokeWeight()
 *
 * mouseX ~ strokeWeight
 * mouseY ~ 
 *
 * note: Renderers handle stroke differently and some don't allow zero weight
 *
 * author: Spencer Mathews
 * date: 5/2017
 */

TODO think about

void setup() {
  size(500, 200);
  //noLoop();
}

void draw() {
  background(255);
  stroke(0, 64);
  

  float x = 0, px = 0, y = 0;
  float weight = .1;

  // loose condition
  while (x<width) {
    strokeWeight(weight);
    line(px, height/2, x, height/2);
    //line(px, y, x, y);

    weight *= 1.5;
    px = x;
    //x += weight;
    x += 50;
    //y += 10;
  }
  
  //weight = height;
  //while (weight> 1
}