//int y=0;
//void setup() {
//  size (600, 400); 
//}
//void draw() {
//  for (int x=0; x<width; x=x+20) {
//    rect(x, y, 20, 20);
//  }
//  y=y+20;
//}

size (600,400);

for (int x=0; x<width; x=x+20){
  for (int y=0; y<height;y=y+20){
    rect(x,y,20,20);
  }
}