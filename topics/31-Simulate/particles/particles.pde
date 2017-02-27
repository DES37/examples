/* Spencer Mathews
 *
 *
 * started: 8/2016
 */

int numParticles = 100;
PVector[] particles;

Particle p;
VectorField vf;

color bg_color;


void setup() {
  size(500, 500);

  bg_color = color(0, 1);

  p = new Particle(-width/4, -height/2);
  vf = new VectorField();

  background(0);
}

void draw() {
  background(bg_color);
  
  stroke(bg_color);
  fill(bg_color);
  rect(0, 0, width, height);

  translate(width/2, height/2);
  //translate(mouseX, mouseY);
  
  p.display();
  p.update(vf);
  

}