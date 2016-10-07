
//EXAMPLE 1 -- CHANGE BACKGROUND COLOR ACCORDING TO MOUSE POSITION
void setup() {
 size(640, 360);
}

void draw() {
 background(50);
 if (mouseX>200) {
   background(255, 100, 0);
 }
}




////EXAMPLE 2 -- MOVE THE BALL BACK TO THE LEFT, IF THE BALL GOES OFF THE RIGHT EDGE.
//float xPosition=0;

//void setup() {
// size(460, 360);
//}

//void draw() {
// background(50);

// ellipse(xPosition, 100, 20, 20);
// xPosition=xPosition+1;

// if (xPosition==width) {
//   xPosition=0;
// }
//}