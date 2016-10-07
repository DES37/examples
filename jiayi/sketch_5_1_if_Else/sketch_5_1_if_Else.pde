
void setup() {
  size(500, 300);
}

void draw() {
  background(50);//draw an overall background of gray.
  rectMode(CENTER);//center coordinates for those rectangles that's coming up.

  stroke(255, 0, 0);// gonna draw four red lines next.
  line(100, 0, 100, height);
  line(200, 0, 200, height);
  line(300, 0, 300, height);
  line(400, 0, 400, height);

/*Use the conditional statements to cut up the space, starting from the right:
If > 400, then draw a rectangle at 450,
if < 400, then we have four possibilities:
1. if >300, then we are looking at th space between 300 and 400, draw a rect at 350.
2. if >200, then we are looking at th space between 300 and 400, draw a rect at 250.
3. if >100, then we are looking at th space between 300 and 400, draw a rect at 150.
4. the last possibility is <100 (there is no more otherwise if), then draw a rect at 50.
*/
  if (mouseX>400) {
    noStroke();
    rect(450, height/2, 10, height);
  } else if (mouseX>300) {
    noStroke();
    rect(350, height/2, 10, height);
  } else if (mouseX>200) {
    noStroke();
    rect(250, height/2, 10, height);
  } else if (mouseX>100) {
    noStroke();
    rect(150, height/2, 10, height);
  } else {
    noStroke();
    rect(50, height/2, 10, height);
  }
}