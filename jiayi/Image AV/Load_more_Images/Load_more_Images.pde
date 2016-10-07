PImage img1, img2, img3;

void setup() {
  fullScreen();
  img1 = loadImage ("tw1.jpg");
  img2 = loadImage ("tw2.jpg");
  img3 = loadImage ("tw3.jpg");
}

void draw() {
  image(img1, width/2-150-300-10, height/4);
  image(img2, width/2-150, height/4);
  image(img3, width/2+150+10, height/4);
}