class Particle {
  float x, y;
  float r;

  //constructor #1
  Particle() {
    x=random(width);
    y=random(height);
    r=random(4, 18);
  }

  //constructor #2
  Particle(float tempX, float tempY, float tempR) {
    x=tempX;
    y=tempY;
    r=tempR;
  }

  void display() {
    stroke(255);
    noFill();
    ellipse (x, y, r*2, r*2);
  }
  
  //evaluating overlapping.
          boolean overlaps(Particle other){
              float d=dist(x,y, other.x, other.y);
              if (d<r+other.r){
                return true;
              }else{
                return false;
              }
            }
  
  
  
}