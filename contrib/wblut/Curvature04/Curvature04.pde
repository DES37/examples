import toxi.geom.*;
import toxi.math.*;

Curver[] curvers;
int NUMCURVERS=100 ;
int[][] grid;
color[][] colorGrid;
int count;
void setup(){
  size(800,800);

  smooth();
  noStroke();

  reset();
}

void draw(){
  boolean resetNeeded=true;
  for(int i=0;i<NUMCURVERS;i++){
    resetNeeded&=curvers[i].inactive;
    if(!curvers[i].inactive){

      curvers[i].drawFrill(colorGrid);

    }
  }
  noStroke();
  fill(0);
  for(int i=0;i<NUMCURVERS;i++){
    if(!curvers[i].inactive){
      curvers[i].drawCenter();
      curvers[i].update(grid);
    }
  }
  if (resetNeeded){
    count++;
    for(int i=0;i<NUMCURVERS;i++){
     curvers[i].reset();
     
     }
     if(count>5) noLoop();
  }

}

void reset(){
  background(255);
  count=0;

  grid = new int[width][height];
  colorGrid = new color[width][height];
  color cul = color(random(256f),random(256f),random(256f));
  color cur = color(random(256f),random(256f),random(256f));
  color cll = color(random(256f),random(256f),random(256f));
  color clr = color(random(256f),random(256f),random(256f));  

  for(int w=0;w<width;w++){
    for(int h=0;h<height;h++){  

      colorGrid[w][h]=color((1f-(float)w/width)*(1f-(float)h/height)*red(cul)+((float)w/width)*(1f-(float)h/height)*red(cur)+(1f-(float)w/width)*((float)h/height)*red(cll)+((float)w/width)*((float)h/height)*red(clr),(1f-(float)w/width)*(1f-(float)h/height)*green(cul)+((float)w/width)*(1f-(float)h/height)*green(cur)+(1f-(float)w/width)*((float)h/height)*green(cll)+((float)w/width)*((float)h/height)*green(clr),(1f-(float)w/width)*(1f-(float)h/height)*blue(cul)+((float)w/width)*(1f-(float)h/height)*blue(cur)+(1f-(float)w/width)*((float)h/height)*blue(cll)+((float)w/width)*((float)h/height)*blue(clr),60);
    }
  }
  curvers = new Curver[NUMCURVERS];
  Vec3D pos = new Vec3D(width/2,height/2,0f);
  Vec3D hdg = new Vec3D();
  for(int i=0;i<NUMCURVERS;i++){
    //    pos.set(width/2+2*cos(i*TWO_PI/NUMCURVERS),height/2+2*sin(i*TWO_PI/NUMCURVERS),0f);
    pos.set(width/2,height/2,0f);
    hdg.set(cos(i*TWO_PI/NUMCURVERS),sin(i*TWO_PI/NUMCURVERS),0f);
    hdg.normalize();
    curvers[i] = new Curver(pos,hdg);

  }
    loop();
}


void mousePressed(){
  reset();
  loop();

}

void keyPressed(){
  if((key=='s')||(key=='S')) saveFrame();

}
