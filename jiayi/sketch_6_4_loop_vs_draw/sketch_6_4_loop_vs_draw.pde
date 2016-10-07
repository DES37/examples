void setup () {
  size (600, 400);
}

void draw() {
  background(0);
  stroke(255);  

  int x=0;

  while (x<width) {           // everything the loop does all go inside one frame.
    line(x, 0, x, height);    // in this case, all these vertical lines will show up at once,
    x=x+20;                   // when the loop is done looping.
  }                           // what if i want the lines to show up one by one?
                              // this type of animation needs to be achieved in draw.
}

//Example 2: draw a vertical line one by one to the right.
//int x=50;

//void setup() {
// size(600, 400); 
// background (0);
// stroke(255);
//}

//void draw() {
// line(x, 0, x, height);
// x=x+50;
//}
//this one goes by too fast. how to control the speed of animation? See sketch_6_4_loop_animation.