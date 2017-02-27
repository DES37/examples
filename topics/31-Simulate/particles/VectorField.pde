class VectorField {

  // 
  float a, b, c, d;
  
  PVector v;  //used to compute velocity at a point

  VectorField() {
    a=-0.1;
    b=0;
    c=0;
    d=-0.1;
    
    v = new PVector();
  }

  PVector velocity(float x, float y) {
    v.set(a*x+b*y, c*x+d*y);
    return v;
  }
  
  void display() {
    
  }
}