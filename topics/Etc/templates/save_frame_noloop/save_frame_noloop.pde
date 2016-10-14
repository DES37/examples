// Spencer Mathews
// April 2016
// Minimal example of how to save a single frame

void setup() {
  size(500, 500);
  // noLoop() ensures that draw() is only executed once so only one frame is drawn and saved
  noLoop();
}

void draw() {
  // defaults to saving screen-####.tif in sketch folder
  saveFrame();
}