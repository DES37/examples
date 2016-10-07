//DRAW 5 CONCENTRIC CIRCLES

void setup () {
  size (100, 100); 
  background (0);
  ellipseMode(CENTER);
  noFill();
  stroke(255);
  strokeWeight(1);
  noLoop();
}

void draw () {

      for (float k=0; k<5; k++) {
        float x=50;
        float y=50;
        float ir=10;  //inner most circle radius
        float spacing=10;  //radius difference between each circle
        float r;

        r=ir+spacing*k;
        ellipse (x, y, r, r);
      }

}