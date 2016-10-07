Particle p1, p2;

void setup() {
  size (600, 400);
  p1=new Particle(100, 100, 50);
  p2=new Particle();
}

void draw() {
  background(0);

  /*Example 1: first way of approaching evaluation of two circles overlapping. 

  float d=dist(p1.x, p1.y, p2.x, p2.y); //distance between the centers of the circles.
  if (d<p1.r+p2.r) {
    background(0, 100, 0);
  }
  */
  
  /*Example 2: a better way of approaching the same problem with an overlaps function defined
  in the Paricle class.
  */
  if (p2.overlaps(p1)){
    background(0,100,0);
  }

  p1.display();
  p2.display();

  p2.x=mouseX;
  p2.y=mouseY;
}