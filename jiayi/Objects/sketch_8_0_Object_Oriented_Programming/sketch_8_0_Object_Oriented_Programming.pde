//THE GOAL OF AN OBJECT ORIENTED PROGRAMMING WILL HAVE CODE THAT LOOKS LIKE THIS.
Ball b;

void setup (){
  size(320,240);
     b=new ball();
}

void draw(){
  background(255);
  b.update();
  b.checkEdges();
  b.display();
}