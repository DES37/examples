class Train {

  float x;
  float y;
  float r;
  float w;
  float h;

  Train (float tempX, float tempY, float tempR, float tempW, float tempH) {
    x=tempX;
    y=tempY;
    r=tempR;
    w=tempW;
    h=tempH;
  }


  void display() {
    noStroke();
    fill(r);
    rect(x, y, w, h);
  }
  void travel() {
    x++;
  }
}