/* Spencer Mathews
 *
 * DIY particle system
 * Rewrite OpenProcessing 54024
 * for fun and understanding
 */

Particle[] particles;
int numParticles = 500;
float mx, my;
float easing = .3;

void setup() {
  size(900, 450);

  mx = 0;
  my = 0;

  particles = new Particle[numParticles];
  for (int i=0; i<particles.length; i++) {
    particles[i] = new Particle();
  }

  stroke(255, 5);
  strokeWeight(1);
  background(0);
}

void draw() {

  //fill(0,2);
  //rect(0,0,width,height);

  mx += easing*(mouseX-mx);
  my += easing*(mouseY-my);

  for (int i=0; i<particles.length; i++) {
    //particles[i].display(mx, my);
    particles[i].display(mouseX, mouseY);
  }
}



class Particle {

  float x, y;
  float px, py;
  float dx, dy;

  float w;
  float wMax = 5;  // orig=5
  float drag = 100;  // origin~100 not sure if this is the best name, slowing is really the drag
  float slowing = 1.05;  // orign=1.05 how much to slow down per frame, was 1.05

  Particle() {
    x=random(width);
    y=random(height);

    px=0;
    py=0;
    dx=0;
    dy=0;

    w = random(1/wMax, wMax);  // randomizing is key!
  }

  void display(float mx, float my) {
    if (!mousePressed) {
      dx /= slowing;
      dy /= slowing;
    }

    dx += w*(mx-x)/drag;
    dy += w*(my-y)/drag;
    x += dx;
    y += dy;

    stroke(255, 5);
    strokeWeight(1);
    line(x, y, px, py);

    px = x;
    py = y;
  }
}