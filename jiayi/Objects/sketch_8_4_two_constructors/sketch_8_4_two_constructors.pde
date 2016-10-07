Particle p1, p2;

void setup() {
  size (600, 400);
  p1=new Particle(100, 100, 50);
  p2=new Particle();
}

void draw() {
  background(0);

  p1.display();
  p2.display();
}