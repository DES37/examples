
HLine[] h;

void setup() 
{
 size(600, 400);
 h = new HLine[20];

for (int i=0;i<20;i++) {
h[i]=new HLine(random(100),random(3));
}
}

void draw() { 
 background(204);
 for (int i=0; i<20; i++) {
   h[i].update();
 }
} 

class HLine { 
 float ypos, speed; 
 HLine (float y, float s) {  
   ypos = y; 
   speed = s; 
 } 
 void update() { 
   ypos += speed; 
   if (ypos > height) { 
     ypos = 0; 
   } 
   line(0, ypos, width, ypos); 
 } 
}