//I want my x position to change very randomly.  

float xPercentage = 0;

void draw() {
  background(200);
  xPercentage += .01;
  float x = noise(xPercentage) * width; //adds noise to xPercentage value
  line(x, 0, x, height); 
}