/* Spencer Mathews, 11/2016
 *
 * ? review how to pull out transformation matrix
 *
 * left-handed 3d
 * must use translate for box() and sphere()
 * rotate() -> rotateZ()
 *
 * note: In opengl +Y goes up (it's reversed in processing)!
 * eye coordinates (view space/eye space) use **right-handed** coordinate system and camera at origin looks along -Z
 * Normalized Device Coordinates (NDC) uses left-handed and camera at origin looking along +Z
 */

void setup() {
  size(500, 500, P3D);
  //rectMode(CENTER);  // did not seem to do anything!?
  //frameRate(10);
}
void draw() {
  background(0);

  println("----- before -----");
  g.printCamera();
  g.printMatrix();
  g.printProjection();

  if (mousePressed) {
    println("----- mousePressed -----");
    //ortho();  // set default ortho projection ortho(-width/2, width/2, -height/2, height/2);
    /* workaround to orth weirdness according to #1278 */
    //float x0 = 0;
    //float x1 = width;
    //float y0 = 0;
    //float y1 = height;
    //float left = x0 - width/2;
    //float right = x1 - width/2;
    //float bottom = -(y1 - height/2);
    //float top = -(y0 - height/2);
    //ortho(left, right, bottom, top);


    //    camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    camera();
  } else {
    perspective();  // set default perspective projection
    /* default perspective projection */
    //float fovy = PI/3.0;
    //float aspect = float(width)/float(height);
    //float cameraZ = (height/2.0) / tan(fovy/2.0);  // default: (height/2.0) / tan(PI*60.0/360.0));
    //perspective(fovy, aspect, cameraZ/10.0, cameraZ*10.0);
  }

  println("----- after -----");
  g.printCamera();
  g.printMatrix();
  g.printProjection();

  //camera();

  //lights();  // set default lighting
  //ambientLight
  //directionalLight
  //spotLight
  //pointLight

  translate(width/2, height/2, 0);
  //stroke(255, 0, 0, 128);
  //fill(255, 128);
  box(50);
  sphere(mouseY);
}