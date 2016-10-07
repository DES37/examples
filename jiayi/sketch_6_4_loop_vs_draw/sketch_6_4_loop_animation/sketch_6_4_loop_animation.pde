float frX=0; //flexible animation frame width, so that the while loop can meet exit condition.
int aSpeed=1; //control advancing speed


void setup () {
  size (600, 400);
}

void draw() {
  background(0);
  stroke(255);

  int x=0; //each time it draws, x needs to go back to 0 and start all over from left,
  //where frX continues to get bigger and bigger.
  while (x<frX) {         
    line(x, 0, x, height);    
    x=x+20;    //x can only be 0, 20, 40, 60, etc.
  }

  frX=frX+aSpeed;
}

/*
step 1 draw a background.
step 2 program goes inside the while loop, and draws a number of lines on a frame,
or it doesn't draw and comes out the loop and continue to increase endX until it hits the next increment of x.
 
The animations goes like this: frame 1 - one line, frame 2 - two lines, frame 3 - three lines, etc. refresh background inbetween. each frame.
*/