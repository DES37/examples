//http://www.wblut.com/tutorials/processing/kaleidoscope/

PShader kaleidoscope;
Box[] boxes;
boolean applyFilter;

void setup() {
  size(1200, 800, P3D);
  smooth(8);
  kaleidoscope=loadShader("kaleidoscope.glsl");
  kaleidoscope.set("sides", 6.0);
  kaleidoscope.set("offset", 0);

  boxes=new Box[50];
  for (int i=0; i<boxes.length; i++) {
    boxes[i]=new Box(color(random(255), random(100), random(100)), random(-200, 200), random(-200, 200), random(-200, 200), random(10, 100));
  }
}

void draw() {
  background(0);
  lights();
  translate(width/2, height/2);
  rotateY(radians(frameCount)); 
  rotateX(QUARTER_PI);
  translate(0, 80);
  for (Box box : boxes) {
    box.draw();
  }
  if (applyFilter) filter(kaleidoscope);
}

void mousePressed() {
  applyFilter=!applyFilter;
}

class Box {
  color c;
  float x, y, z, s;
  Box(color cc, float xx, float yy, float zz, float ss) {
    c=cc;
    x=xx;
    y=yy;
    z=zz;
    s=ss;
  }

  void draw() {
    fill(c);
    pushMatrix();
    translate(x, y, z);
    box(s);
    popMatrix();
  }
}