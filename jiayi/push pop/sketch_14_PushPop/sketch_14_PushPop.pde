//Multiple Translations
void setup() {
 size (200, 200);
}

void draw() {
 translate (mouseX, mouseY); 
 /*everything below this line of code is stuck to a new coordinate system,
   which in this case, it is set by the positions of the mouse.*/
    
 rect(0, 0, 30, 30);
 translate (35, 10);
 rect (0, 0, 15, 15);
} 
//each time it draws, the coordinates are set to default.



//-------------------------
////Isolating Transformations
//void setup() {
//  size (200, 200);
//}

//void draw() {
//  pushMatrix(); //isolating the big rectangle
//  translate (mouseX, mouseY); 
//  rect(0, 0, 30, 30);
//  popMatrix();
  
//  translate (35, 10); //the smaller rectangle is not affected by mouse
//  rect (0, 0, 15, 15);
//} 