/* Spencer Mathews, 11/2016
 *
 * Default values of PGraphics fields
 *

 * PApplet is `this` associated PGraphics object is `this.g`
 * PGraphics is a subclass of PImage
 * PGraphics http://processing.github.io/processing-javadocs/core/processing/core/PGraphics.html
 * subclasses:
 * |-PGraphicsFX2D
 * |-PGraphicsJava2D
 * |-PGraphicsGL
 * | |-PGraphics2D
 * | |-PGraphics3D
 */

void setup() {
  surface.setVisible(false);
  noLoop();
}

void draw () {
  print("backgroundColor "); 
  printColor(g.backgroundColor);

  println("\nsmooth", g.smooth);

  println("\ncolorMode", g.colorMode, "(", g.colorModeX, ", ", g.colorModeY, ", ", g.colorModeZ, ", ", g.colorModeA, ")");

  println("\nstroke", g.stroke);
  print("strokeColor "); 
  printColor(g.strokeColor);  // set with stroke()
  println("strokeCap", g.strokeCap);
  println("strokeJoin", g.strokeJoin);
  println("strokeWeight", g.strokeWeight);



  println("\nfill", g.fill);
  print("fillColor "); 
  printColor(g.fillColor);  // set with fill()

  println("/nellipseMode", g.ellipseMode);
  println("rectMode", g.rectMode);

  println("shapeMode", g.shapeMode);
  println("imageMode", g.imageMode);

  println("\npixelCount", g.pixelCount);

  //how do we get current blendMode?
}

void printColor(color c) {
  println(hex(g.backgroundColor), "(", red(g.backgroundColor), ", ", green(g.backgroundColor), ", ", blue(g.backgroundColor), ")");
}

void printBool(boolean b) {
  if (b) {
    println("TRUE");
  } else {
    println("FALSE");
  }
}

/*
int textAlign  // The current text align (read-only)
 int textAlignY  // The current vertical text alignment (read-only)
 PFont textFont  // The current text font (read-only)
 float textLeading  // The current text leading (read-only)
 int textMode  // The current text mode (read-only)
 float textSize  // The current text size (read-only)
 
 PImage textureImage  // Current image being used as a texture
 int textureMode  // Sets whether texture coordinates passed to vertex() calls will be based on coordinates that are based on the IMAGE or NORMALIZED.
 float textureU  // Current horizontal coordinate for texture, will always be between 0 and 1, even if using textureMode(IMAGE).
 float textureV  // Current vertical coordinate for texture, see above.
 
 boolean tint  // True if tint() is enabled (read-only).
 */