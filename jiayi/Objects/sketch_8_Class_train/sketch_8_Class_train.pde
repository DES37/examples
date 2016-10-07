Train lightgray, darkgray;

void setup() {
  size (600, 400);
  lightgray=new Train(100, 100, 55, 40, 20);
  darkgray=new Train (143, 100, 100, 40, 20);
}

void draw() {
  background(255);

  lightgray.display();
  lightgray.travel();

  darkgray.display();
  darkgray.travel();
}