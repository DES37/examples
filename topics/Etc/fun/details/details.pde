/* Playing with precise dimensions of width and height
 *
 * The upper-left pixel is (0,0) and lower-right is (width-1, height-1)
 *
 * author: Spencer Mathews
 * date: 5/2016
 * status: incomplete
 */

int selection = 0;
int num_selections = 2;

void setup() {
  size(809, 500);
}

void draw() {
  background(255, 0, 0);

  int sWeight = 0;
  if (sWeight<0) sWeight=0;
  strokeWeight(sWeight);

  int offset = 0;
  if(offset<0) offset=0;

  stroke(0,255,0);
  fill(255);
  if (selection == 0) {
    rect(0, 0, width-1, height-1);
    //rect(0, 0, width/2, height);
    //rect(width/2, 0, width-1, height-1);
  } else if (selection == 1) {
    rect(0, 0, width, height);
    //rect(0, 0, width/2, height);
    //rect(width/2, 0, width, height);
  } else {
  }
  
  stroke(0,0,255);
  strokeWeight(1);
  line(0, height/2, sWeight, height/2);
}


void mouseClicked() {
  if (selection == num_selections) {
    selection = 0;
  } else{
    selection++;
  }
}