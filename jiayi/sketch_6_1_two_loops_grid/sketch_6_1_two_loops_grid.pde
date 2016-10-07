////EXAMPLE 1: DRAW VERTICAL LINES.
//float x=50;

//void setup() {
//  size(600, 400);
//  background (0);
//}

//void draw() {
//  while (x<width) {
//    stroke(255);
//    line (x, 0, x, height);
//    x=x+50;
//  }
//}

////EXAMPLE 2: TWO LOOPS - X AND Y. DRAW A GRID.
//float x=50;
//float y=50;

//void setup() {
//size(600, 400);
//background (0);
//}

//void draw() {
//while (x<width) {
//  stroke(255);
//  line (x, 0, x, height);
//  x=x+50;
//}
//while (y<height) {
//  stroke(255);
//  line (0, y, width, y );
//  y=y+50;
//}
//}

////EXAMPLE 3: USE LOOPS TO CREATE ANIMATION.
//float x=0;

//void setup() {
//  size(600, 400);
//}

//void draw() {
//  background (0);

//  x=0;
//  while (x<width && x>=0) {
//    stroke(255);
//    line (x, 0, x, height);
//    x+=random(0, 10);

//    stroke(255, 0, 0); //red line.
//    line (x, 0, x, height);
//    x+= random(10, 100);
//  }
//  println(x);
//}