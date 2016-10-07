
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

  //if (mouseX>400) {
  //  noStroke();
  //  rect(450, height/2, 10, height);
  //} else if (mouseX>300) {
  //  noStroke();
  //  rect(350, height/2, 10, height);
  //} else if (mouseX>200) {
  //  noStroke();
  //  rect(250, height/2, 10, height);
  //} else if (mouseX>100) {
  //  noStroke();
  //  rect(150, height/2, 10, height);
  //} else {
  //  noStroke();
  //  rect(50, height/2, 10, height);
  //}

  // to achieve the same results as above with the && conditional statements.
  if ((mouseX>0)&&(mouseX<100)) {
    noStroke();
    rect(50, height/2, 10, height);
  }
  if ((mouseX>100)&&(mouseX<200)) {
    noStroke();
    rect(150, height/2, 10, height);
  }
  if ((mouseX>200)&&(mouseX<300)) {
    noStroke();
    rect(250, height/2, 10, height);
  }
  if ((mouseX>300)&&(mouseX<400)) {
    noStroke();
    rect(350, height/2, 10, height);
  }
  if ((mouseX>400)&&(mouseX<500)) {
    noStroke();
    rect(450, height/2, 10, height);
  }


  //mouseY changes bakcground color to purple.
  if ((mouseY<100) || (mouseY>200)) {
    background(45, 26, 70);
  }
}