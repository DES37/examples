//http://www.wblut.com/2009/02/19/voronoi-fractal-21/
// first version http://www.wblut.com/2008/04/01/voronoi-fractal/

int NUMPOINTS; 
int MAXORDER; 
ArrayList voronois;
ArrayList borders;
ArrayList points;

import processing.pdf.*;



void setup(){
  size(800,800);  
  smooth();  
  NUMPOINTS=4; // Number of cells per iteration
  MAXORDER=5; // Number of iteration. Total number of cells is NUMPOINTS^MAXORDER 
  borders=new ArrayList();
  points=new ArrayList();
  voronois=new ArrayList();
  reset(); 
}

void reset(){   
  borders.clear();
  points.clear();
  voronois.clear();
  generateBorders();
  generatePoints(NUMPOINTS); 
  Voronoi mainVoronoi=new Voronoi(points,borders,0,color(150,150,150),color(0,120));
  voronois.add(mainVoronoi);
  divide(mainVoronoi);
  loop();
 
}

void draw(){  
    drawVoronoi();
   noLoop();// stop drawing, unless something changes
}

void drawVoronoi(){
  background(0); 
  fill(255);
  Iterator voronoiItr = voronois.iterator();
    while(voronoiItr.hasNext()){
      Voronoi currentVoronoi = (Voronoi)voronoiItr.next();
      if(currentVoronoi.order>MAXORDER){
        //stroke(0);
        //fill(currentVoronoi.fillColor);
        currentVoronoi.drawRounded(1f);  //use drawRounded() for Bezier curves   
        /*fill(255);
        currentVoronoi.drawRounded(.9f); */ 
      }
    }
    /*voronoiItr = voronois.iterator();
    while(voronoiItr.hasNext()){
      Voronoi currentVoronoi = (Voronoi)voronoiItr.next();     
      if(currentVoronoi.order>MAXORDER){
        stroke(currentVoronoi.strokeColor);
        //strokeWeight(currentVoronoi.strokeWeight);
        noFill();
        currentVoronoi.drawRounded(.8f);   
      }      
    }  */   
}

Point2D map(Point2D p){
 /*Point2D result=new Point2D();
  result.x=p.x+random(-10f,10f);
 result.y=p.y+random(-10f,10f); 
 return result;*/
 return p;
  
}

void generateBorders(){// Create initial borders
  borders.clear();
  ArrayList borderPoints = new ArrayList();
  Segment2D border=new Segment2D();
  boolean circle=false;// If true, then the initial boundary is a circle
  if (circle){
    float a = TWO_PI/128.0f;
    for(int i=0;i<128;i++){
      Point2D borderPoint = new Point2D(width/2+width/2*cos(a*i),height/2+height/2*sin(a*i));
      borderPoints.add(borderPoint);
    }
    for(int i=0;i<128;i++){
      int nexti=(i==127)?0:i+1; 
      border=new Segment2D((Point2D)borderPoints.get(i),(Point2D)borderPoints.get(nexti),i);
      borders.add(border);
    }
  }
  else{
    border=new Segment2D(0,0,width-1,0,0);
    borders.add(border);
    border=new Segment2D(0,height-1,0,0,1);
    borders.add(border);
    border=new Segment2D(width-1,0,width-1,height-1,2);
    borders.add(border);
    border=new Segment2D(width-1,height-1,0,height-1,3);
    borders.add(border);
  }
}

void generateBorders(ArrayList periphery){// Create borders from a cell (so a new graph can be made inside the cell)
  borders.clear();
  for(int i=0;i<periphery.size();i++){
    Point2D pointi =(Point2D)periphery.get(i);
    int nexti=i+1;
    if(nexti>periphery.size()-1)nexti=0;
    Point2D pointj=(Point2D)periphery.get(nexti);    
    borders.add(new Segment2D(pointi,pointj));
  }
}

void generatePoints(int n){
  points.clear();  
  float minx,maxx,miny,maxy;
  minx=miny=20000000;
  maxx=maxy=-1;
  Iterator borderItr = borders.iterator();
  while(borderItr.hasNext()){
    Segment2D currentBorder =(Segment2D) borderItr.next();
    minx=min(minx,currentBorder.start.x);
    minx=min(minx,currentBorder.end.x);
    miny=min(miny,currentBorder.start.y);
    miny=min(miny,currentBorder.end.y);    
    maxx=max(maxx,currentBorder.start.x);
    maxx=max(maxx,currentBorder.end.x);
    maxy=max(maxy,currentBorder.start.y);
    maxy=max(maxy,currentBorder.end.y); 

  }

  for(int i=0;i<n;i++){
    SegmentPoint2D trialPoint=new SegmentPoint2D(random(minx,maxx), random(miny,maxy));
    while(!inside(trialPoint,borders)){
      trialPoint=new  SegmentPoint2D(random(minx,maxx), random(miny,maxy));
    }
    points.add(trialPoint);
  }
}


void divide(final Voronoi voronoi){
  if((voronoi.order<MAXORDER+1)){//Limits the recursion
    Iterator cellItr = voronoi.cells.iterator();

    while(cellItr.hasNext()){
      Cell currentCell= (Cell) cellItr.next();
      generateBorders(currentCell.periphery);
      int dividedFillRed=(int)constrain(red(voronoi.fillColor)+random(-20,20),0,255);
      int dividedFillGreen=(int)constrain(green(voronoi.fillColor)+random(-20,20),0,255);
      int dividedFillBlue=(int)constrain(blue(voronoi.fillColor)+(int)random(-20,20),0,255);
      int dividedFillAlpha=255;
      int dividedStrokeRed=0;
      int dividedStrokeGreen=0;
      int dividedStrokeBlue=0;
      int dividedStrokeAlpha=100;    
      int dividedNumpoints=(voronoi.order==MAXORDER)?1:NUMPOINTS;
      generatePoints(dividedNumpoints);
      Voronoi divVoronoi=new Voronoi(points,borders,voronoi.order+1, color(dividedFillRed,dividedFillGreen,dividedFillBlue,dividedFillAlpha),color(dividedStrokeRed,dividedStrokeGreen,dividedStrokeBlue,dividedStrokeAlpha));

      voronois.add(divVoronoi);
      divide(divVoronoi);
    }
  }
}



void mousePressed(){
  reset();
}


void keyPressed(){
 if((key=='s')||(key=='S')){
  int randomID = (int)random(10000000);
   beginRecord(PDF, "voronoi"+randomID+".pdf");
    drawVoronoi();
  endRecord();
 } 
  
}