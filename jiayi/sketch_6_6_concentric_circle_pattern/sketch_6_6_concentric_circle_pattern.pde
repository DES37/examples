void setup () {
  size (800, 800); 
  background (0);
  ellipseMode(CENTER);
  noFill();
  stroke(255);
  strokeWeight(1);
  noLoop();
}

void draw () {

  for (float i=0; i<10; i++) {
    float x=50;
    x=x+x*i;
    for (float j=0; j<10; j++) {
      float y=50;
      y=y+y*j;

      for (float k=0; k<5; k++) {
        float ir=10;  //inner most circle radius
        float spacing=10;  //radius difference between each circle
        float r;

//Mod Example:
        //if ( (i+j+k) %2 == 0){
        // stroke(3,124,193);
        //} else {
        // stroke(255,162,0);
        //}

        r=ir+spacing*k;
        ellipse (x, y, r, r);
      }
    }
  }
}