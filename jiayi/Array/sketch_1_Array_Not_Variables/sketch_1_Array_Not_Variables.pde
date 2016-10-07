////EXAMPLE 1: Many Variables
//float x1=-20;
//float x2=20;

//void setup () {
// size (500, 500);
//}

//void draw() {
// background (0);
// x1+=0.5;
// x2+=1;

// ellipse(x1, 100, 50, 50);
// ellipse(x2, 200, 50, 50);
//}

////EXAMPLE: Too Many Variables
//float x1=-20;
//float x2=20;
//float x3=-30;
//float x4=40;
//float x5=25;

//void setup () {
//  size (500, 500);
//}

//void draw() {
//  background (0);
//  x1+=0.5;
//  x2+=1;
//  x3+=0.7;
//  x4+=3;
//  x5+=1.5;

//  ellipse(x1, 100, 50, 50);
//  ellipse(x2, 150, 50, 50);
//  ellipse(x3, 200, 50, 50);
//  ellipse(x4, 250, 50, 50);
//  ellipse(x5, 300, 50, 50);
//}

//Array, Not Variables
float[] x=new float[3000]; //3000 x location
float[] y=new float[3000]; //3000 y location
float[] speed={0.5, 1, 1.8, 3, 0.7}; //5 speeds

void setup() {
  size (500, 500); 
  for (int i=0; i<x.length; i++) {
    x[i]=random(-10, 200);
    y[i]=random(-10, 200);
  }
}

void draw() {
  background(0);
  for (int i=0; i<x.length; i++) {
    x[i]=x[i]+speed[int(random (0, 5))];
    y[i]=y[i]+speed[int(random (0, 5))];

    ellipse(x[i], y[i], 10, 10);
  }
}