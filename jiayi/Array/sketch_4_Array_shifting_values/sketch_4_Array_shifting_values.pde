int []x=new int[60];
int []y=new int[60];
int []a=new int[60];
 
void setup() {
  size (500, 500);
  noStroke();
  for (int i=0; i<60; i++) {
    a[i]=(59-i)*4; //reverse storage order-dark first
  }
}
 
void draw() {
  background(0);
  for (int i=59; i>0; i--) { //reverse fill - fill index 59 first
    x[i]=x[i-1]; //x location is always the previous x location
    y[i]=y[i-1];
 
    fill(a[i]);
    ellipse(x[i], y[i], 50, 50);
  }
  x[0]=mouseX; //index 0 (first storage unit) is always mouse value
  y[0]=mouseY;
}