PFont zigBlack;

void setup() {
  size(500, 500);
  zigBlack = createFont("BodoniStd-Bold", 100);
  //zigBlack = createFont("FrizQuadrataStd", 100);

  textFont(zigBlack);
  fill(0);
}

void draw() {
  background(204);
  text("LAX", 50, 140);
  text("LHR", 50, 270);
  text("TXL", 50, 400);
}