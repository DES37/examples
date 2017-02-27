
float scale;
float scaleMax = 0.1;
float scaleY;


void setup() {
  size(500, 500);
  stroke(255);
  noFill();
}

void draw() {
  noise2d();
}

/*
 * Plot noise x against x
 */
void noise1d() {
  background(0);

  // mouseX controls how quickly to move through the perlin noise space
  scale = map(mouseX, 0, width, 0, scaleMax);

  beginShape();
  for (int i=0; i<width; i++) {
    float x = i;
    // mouseY explores the second dimension of noise space
    float y = noise(i*scale, mouseY*scale)*height;
    vertex(x, y);
  }
  endShape();
}

void noise2d() {
  background(0);

  // mouseX controls how quickly to move through the perlin noise space
  scale = map(mouseX, 0, width, 0, scaleMax);
  scaleY = map(mouseY, 0, height, 0, scaleMax);

  beginShape();
  for (int i=0; i<width; i++) {
    float x = i;
    // consider a fixed scaling for frameCount so animation is smooth and consistent
    // otherwise 
    float y = noise(i*scale, frameCount*scaleY)*height;
    vertex(x, y);
  }
  endShape();
}