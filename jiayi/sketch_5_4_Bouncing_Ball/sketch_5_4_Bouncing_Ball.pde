float xPosition=100;
float xSpeed=10;

void setup () {
  size (600, 400);
}
void draw() {
  background (0);
  noStroke();
  fill(255);

  ellipse(xPosition, 100, 25, 25);
  xPosition=xPosition+xSpeed; //same as when we used x=x+10, here we gave it a variable of xSpeed.
  
  if(xPosition>600 || xPosition<0){
    xSpeed=-xSpeed;//this might just be too close to -=
    //xSpeed=xSpeed * (-1); //can also use this.
    
  }
}