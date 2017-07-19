/* Example of createFont()
 *
 * note:
 * prefer createFont (vector fonts TTF/OTF) over loadFont (VLW)!
 *
 * author: Spencer Mathews
 */


PFont f;
void setup() {
  f=loadFont("Baskerville-48.vlw");
}
void draw() {
  textFont(f, 12);
  text("Test", 50, 50);
}