class Train {

  float x;
  float y;
  float r;
  float w;
  float h;
  //Processing defined variable - color
  //color c = color(255, 204, 0);
  color c = color(random(255), random(255), random(255));

  Train (float tempX, float tempY, float tempR, float tempW, float tempH) {
    x=tempX; //can initialize and specify value in the object sketch.
    y=tempY;
    r=tempR;
    w=tempW;
    h=tempH;
    //h=20; //Or, you can initialize it here, then take away float tempH.
  }


  void display() {
    noStroke(); 
    fill(c); // c takes color definition from above.
    h=random(0,400); //random h height.
    rect(x, y, w, h);
  }
  void travel() {
    x++;
    y=y+random(-10,10); //random motion along y axis.
  }
}