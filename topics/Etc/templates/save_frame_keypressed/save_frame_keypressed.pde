// Spencer Mathews
// April 2016
// What: Example of how to save frames when ENTER key is pressed
// How: Copy the keyPressed function defined below into your code

void setup() {
  size(500, 500);
}

void draw() {
}

// The keyPressed() function is called once every time a key is pressed.
// The key that was pressed is stored in the key variable. For non-ASCII keys, use the keyCode variable.
void keyPressed() {
  if (keyCode == ENTER || keyCode == RETURN) {
    // ".tif", ".tga", ".jpg", and ".png" are supported, "####" is replaced with current frame number at time of save
    saveFrame("frames/####.tif");
  }
}
