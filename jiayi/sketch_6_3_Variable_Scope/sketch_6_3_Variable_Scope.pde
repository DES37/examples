//int x=0; //globle variable does not work well with loops. and, in gereral, it's not great.

void setup() {
  size (600, 400);
}

void draw() {
  background (0);
  stroke(255);

  for (int x=0; x<width; x=x+20) { //x here is a local variable; declare it right when you need to use it.
    line(x, 0, x, height);

  }
}