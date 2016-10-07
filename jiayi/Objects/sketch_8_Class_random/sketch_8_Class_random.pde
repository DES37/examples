Train color1, color2, color3, color4, color5, color6, color7;

void setup() {
  size (1200, 400);
  color1=new Train(10, 100, 55, 40, 20);
  color2=new Train (10+43*1, 100, 100, 40, 20);
  color3=new Train (10+43*2, 100, 100, 40, 20);
  color4=new Train (10+43*3, 100, 100, 40, 20);
  color5=new Train (10+43*4, 100, 100, 40, 20);
  color6=new Train (10+43*5, 100, 100, 40, 20);
  color7=new Train (10+43*6, 100, 100, 40, 20);
}

void draw() {
  background(255);
  //frameRate(30); control blinking rate.

  color1.display();
  color1.travel();

  color2.display();
  color2.travel();

  color3.display();
  color3.travel();

  color4.display();
  color4.travel();

  color5.display();
  color5.travel();

  color6.display();
  color6.travel();

  color7.display();
  color7.travel();
}