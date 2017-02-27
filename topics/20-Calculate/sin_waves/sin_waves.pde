/* Spencer Mathews
 * 
 * Fun exploration of sin waves
 */

// visible bounds of our centered coordinate system
float xMin, xMax, yMin, yMax;

void setup() {
  size(600, 600, FX2D);  // FX2D or P2D default JAVA2D
  xMin = -width/2;
  xMax = width/2;
  yMin = -height/2;  // note that -y is still up
  yMax = height/2;
}

void draw() {
  background(0);

  // move origin to center of sketch
  translate(-xMin, -yMin);

  float scale = mouseX;
  float amplitude = mouseY/2;  // scale to fill height

  for (float i=xMin; i<xMax; i++) {

    //stroke(128*(1+sin(i/scale)));  // roughly equivalent to map, is it faster?
    for (float j=yMin; j<yMax; j++) {

      stroke(128*(1+sin(dist(i, j, 0, 0 )/scale)));  // roughly equivalent to map, is it faster?

      // Empirically FX2D renderer is way way faster (FPS) than P2D for this kinda thing
      // P2D has marginally faster framerate but is noticeably more responsive than JAVA2D
      // what about other shapes besides points?
      point(i, j);  // points are colored by stroke()
    }
    
    // draw sin wave
    stroke(255, 0, 0);
    //strokeWeight(10);
    //we are lucky Java follows IEEE 754 floating-point standard so division by zero returns Infinity 
    point(i, amplitude*sin(i/scale));
    // TRY DRAWING THIS AS A LINE/SHAPE!!
  }
  
  // display fps on title bar
  surface.setTitle(int(frameRate) + " fps");
}