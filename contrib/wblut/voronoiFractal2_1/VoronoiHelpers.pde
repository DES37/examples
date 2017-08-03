
class Point2D{
  float x,y;
  int onBorder;
  Point2D(){
    x=y=0.0f;
    onBorder=-1;
  }
  Point2D(final float x, final float y){
    this.x=x;
    this.y=y;
    onBorder=-1;
  }
  Point2D(final float x, final float y, final int id){
    this.x=x;
    this.y=y;
    onBorder=id;
  }
  Point2D(final Point2D p){
    x=p.x;
    y=p.y;
    onBorder=p.onBorder;
  }

  boolean equals(final Point2D point){
    return((point.x==x)&&(point.y==y));
  }

  boolean equals(final Point2D point, float threshold){
    return((point.x<x+threshold)&&(point.x>x-threshold)&&(point.y<y+threshold)&&(point.y>y-threshold));
  }

  void draw(){
    ellipse(x,y,4,4);
  }


}

class SegmentPoint2D extends Point2D{
  ArrayList belongsToSegment;

  SegmentPoint2D(){
    super();
    belongsToSegment = new ArrayList();

  }
  SegmentPoint2D(final float x, final float y){
    super(x,y);
    belongsToSegment = new ArrayList();
  }
  SegmentPoint2D(final float x, final float y, final int id){
    super(x,y,id);
    belongsToSegment = new ArrayList();
  }
  SegmentPoint2D(final Point2D p){
    super(p);
    belongsToSegment = new ArrayList();
  }

  void add(final Segment2D segment){
    belongsToSegment.add(segment);
  }

  Point2D convertToPoint2D(){
    return new Point2D(x,y,onBorder);   
  }
}

class PeripheryPoint2D extends Point2D{
  float angle;
  Point2D centerPoint;
  PeripheryPoint2D(final Point2D point, final Point2D centerPoint){
    super(point);
    this.centerPoint=new Point2D(centerPoint);
    angle=atan2(point.y-centerPoint.y,point.x-centerPoint.x);
  }
  PeripheryPoint2D(final PeripheryPoint2D point){
    super(point);
    centerPoint=new Point2D(point.centerPoint);
    angle=point.angle;
  }
  Point2D convertToPoint2D(){
    return new Point2D(x,y,onBorder);
  }
}

class Segment2D{
  Point2D start;
  Point2D end;
  ArrayList points;
  Segment2D bisector=null;


  Segment2D(){
    start = new Point2D(0.0f,0.0f);
    end = new Point2D(0.0f,0.0f);
    points=new ArrayList();
    points.add(start);
    points.add(end);
  }

  Segment2D(final float startx,final  float starty,final  float endx,final  float endy){
    start = new Point2D(startx,starty);
    end = new Point2D(endx,endy);
    points=new ArrayList();
    points.add(start);
    points.add(end);
  }

  Segment2D(final float startx,final  float starty,final  float endx,final  float endy, int id){
    start = new Point2D(startx,starty);
    end = new Point2D(endx,endy);
    start.onBorder=id;
    end.onBorder=id;
    points=new ArrayList();
    points.add(start);
    points.add(end);
  }

  Segment2D(final Point2D start,final  Point2D end){
    this.start = new Point2D(start);
    this.end = new Point2D(end);
    points=new ArrayList();
    points.add(start);
    points.add(end);
  }

  Segment2D(final Point2D start,final  Point2D end, int id){
    this.start = new Point2D(start);
    this.end = new Point2D(end);
    this.start.onBorder=id;
    this.end.onBorder=id;
    points=new ArrayList();
    points.add(start);
    points.add(end);
  }

  Segment2D(final Segment2D segment){
    start = new Point2D(segment.start);
    end = new Point2D(segment.end);
    points=new ArrayList();
    points.add(start);
    points.add(end);
  }

  void add(Point2D point){
    Iterator itr = points.iterator();
    boolean unique=true;
    while (itr.hasNext()) {
      if (point.equals((Point2D)itr.next(),0.1f)){
        unique=false;
        break;
      }

    }
    if (unique) points.add(point);
  }

  Point2D get(final int i){
    return (Point2D)points.get(i);
  }

  void draw(){
    line(start.x,start.y,end.x,end.y);
  }

}

class Cell{
  Point2D centerPoint;
  ArrayList periphery;

  Cell(final Point2D point){
    centerPoint=new Point2D(point);
    periphery = new ArrayList();
  }

  void update(){
    clean();
    sort();
    removeCollinearPoints();   
  }

  void clean(){
    ArrayList cleanedPeriphery = new ArrayList();
    for(int i=0;i<periphery.size();i++){
      Point2D pointi=(Point2D)periphery.get(i);
      boolean unique=true;
      for(int j=i+1;j<periphery.size();j++){
        Point2D pointj=(Point2D)periphery.get(j);
        if (pointi.equals(pointj,0.1f)){
          unique=false;
          break;
        }
      }
      if(unique) cleanedPeriphery.add(pointi);
    }
    periphery.clear();
    periphery.addAll(cleanedPeriphery);
  }

  void sort(){
    for (int i = periphery.size(); --i >= 0; ) {
      for (int j = 0; j < i; j++) {
        PeripheryPoint2D pointj = new PeripheryPoint2D((Point2D)periphery.get(j),centerPoint);        
        PeripheryPoint2D pointjj = new PeripheryPoint2D((Point2D)periphery.get(j+1),centerPoint); 
        if (pointj.angle > pointjj.angle) {
          PeripheryPoint2D temp = new PeripheryPoint2D(pointj);
          periphery.set(j,pointjj.convertToPoint2D());
          periphery.set(j+1,temp.convertToPoint2D());
        }
      }
    }
  }

  void removeCollinearPoints(){
    ArrayList simplePeriphery = new ArrayList();
    for(int i=0;i<periphery.size();i++){
      Point2D pointi=(Point2D)periphery.get(i);
      int j = i-1;
      if(j<0) j=periphery.size()-1;
      Point2D pointj=(Point2D)periphery.get(j);
      int k = i+1;
      if(k==periphery.size()) k=0;
      Point2D pointk=(Point2D)periphery.get(k);
      if (!colinear(pointi,pointj,pointk,0.01f)){
        simplePeriphery.add(pointi);
      }
    }
    periphery.clear();
    periphery.addAll(simplePeriphery);
  }

  void draw(float sc){
    int s=periphery.size();
    pushMatrix();
    float cogx=0f;
       float cogy=0f;
       for(int i=0;i<s;i++){
        Point2D currentPoint= (Point2D)periphery.get(i);
        cogx+=currentPoint.x;
        cogy+=currentPoint.y;         
       }
       cogx/=s;
       cogy/=s;
      translate(cogx,cogy);
      scale(sc);
      translate(-cogx,-cogy);
    beginShape();  
    Iterator itr =periphery.iterator();
    while(itr.hasNext()){
      Point2D currentPoint= map((Point2D)itr.next());
      vertex(currentPoint.x,currentPoint.y);
    }

    endShape(CLOSE);
    popMatrix();
  }


  void drawRounded(float sc){
    int s=periphery.size();
    
   
    float scf=1.0f;
    if(s>2){
      pushMatrix();
       float cogx=0f;
       float cogy=0f;
       for(int i=0;i<s;i++){
        Point2D currentPoint= (Point2D)periphery.get(i);
        cogx+=currentPoint.x;
        cogy+=currentPoint.y;         
       }
       cogx/=s;
       cogy/=s;
      translate(cogx,cogy);
      scale(sc);
      translate(-cogx,-cogy);
      beginShape();  
      Point2D currentPoint= map((Point2D)periphery.get(0));
      Point2D nextPoint= map((Point2D)periphery.get(1));
      Point2D previousPoint= map((Point2D)periphery.get(s-1));
      vertex(0.5f*currentPoint.x+0.5f*previousPoint.x,0.5f*currentPoint.y+0.5f*previousPoint.y);
      bezierVertex(scf*currentPoint.x+(1f-scf)*previousPoint.x,scf*currentPoint.y+(1f-scf)*previousPoint.y,scf*currentPoint.x+(1f-scf)*nextPoint.x,scf*currentPoint.y+(1f-scf)*nextPoint.y,0.5f*currentPoint.x+0.5f*nextPoint.x,0.5f*currentPoint.y+0.5f*nextPoint.y);
      for(int i=1;i<s-1;i++){
        currentPoint= map((Point2D)periphery.get(i));
        nextPoint= map((Point2D)periphery.get(i+1));
        previousPoint= map((Point2D)periphery.get(i-1));
        bezierVertex(scf*currentPoint.x+(1f-scf)*previousPoint.x,scf*currentPoint.y+(1f-scf)*previousPoint.y,scf*currentPoint.x+(1f-scf)*nextPoint.x,scf*currentPoint.y+(1f-scf)*nextPoint.y,0.5f*currentPoint.x+0.5f*nextPoint.x,0.5f*currentPoint.y+0.5f*nextPoint.y);
      }
      currentPoint= map((Point2D)periphery.get(s-1));
        nextPoint= map((Point2D)periphery.get(0));
        previousPoint= map((Point2D)periphery.get(s-2));
        bezierVertex(scf*currentPoint.x+(1f-scf)*previousPoint.x,scf*currentPoint.y+(1f-scf)*previousPoint.y,scf*currentPoint.x+(1f-scf)*nextPoint.x,scf*currentPoint.y+(1f-scf)*nextPoint.y,0.5f*currentPoint.x+0.5f*nextPoint.x,0.5f*currentPoint.y+0.5f*nextPoint.y);

      endShape(CLOSE);
      popMatrix();
    }
  }
  
 


  void draw(int steps, float sc){
    int locsteps=max(1,steps);
    int s=periphery.size();
    pushMatrix();
    float cogx=0f;
       float cogy=0f;
       for(int i=0;i<s;i++){
        Point2D currentPoint= (Point2D)periphery.get(i);
        cogx+=currentPoint.x;
        cogy+=currentPoint.y;         
       }
       cogx/=s;
       cogy/=s;
      translate(cogx,cogy);
      scale(sc);
      translate(-cogx,-cogy);
    beginShape();  
    for(int i=0;i<periphery.size();i++){
      Point2D currentPoint=(Point2D)periphery.get(i);
      int ii=(i==periphery.size()-1)?0:i+1;
      Point2D nextPoint= (Point2D)periphery.get(ii);
      for(int j=0;j<locsteps;j++){
        float f=j/(float)locsteps;
        Point2D intPoint= map(new Point2D(currentPoint.x+f*(nextPoint.x-currentPoint.x),currentPoint.y+f*(nextPoint.y-currentPoint.y)));
        vertex(intPoint.x,intPoint.y);
      }
    }

    endShape(CLOSE);
    popMatrix();
  }
}

float dist(Point2D point1,Point2D point2){
  return dist(point1.x, point1.y,point2.x,point2.y);
}

Point2D segmentIntersectionWithSegment(final Segment2D segment1, final Segment2D segment2){
  Point2D result=null;
  float denominator = (segment2.end.y-segment2.start.y)*(segment1.end.x-segment1.start.x)-(segment2.end.x-segment2.start.x)*(segment1.end.y-segment1.start.y);
  if (denominator==0.0f) return result;
  float ua=((segment2.end.x-segment2.start.x)*(segment1.start.y-segment2.start.y)-(segment2.end.y-segment2.start.y)*(segment1.start.x-segment2.start.x))/denominator;
  float ub=((segment1.end.x-segment1.start.x)*(segment1.start.y-segment2.start.y)-(segment1.end.y-segment1.start.y)*(segment1.start.x-segment2.start.x))/denominator;
  if((ua>1.0f)||(ua<0.0f)||(ub>1.0f)||(ub<0.0f)) return result;
  result=new Point2D(segment1.start.x+ua*(segment1.end.x-segment1.start.x),segment1.start.y+ua*(segment1.end.y-segment1.start.y));
  return result;
}

Point2D segmentIntersectionWithLine(final Segment2D segment1, final Segment2D segment2){
  Point2D result=null;
  float denominator = (segment2.end.y-segment2.start.y)*(segment1.end.x-segment1.start.x)-(segment2.end.x-segment2.start.x)*(segment1.end.y-segment1.start.y);
  if (denominator==0.0f) return result;
  float ua=((segment2.end.x-segment2.start.x)*(segment1.start.y-segment2.start.y)-(segment2.end.y-segment2.start.y)*(segment1.start.x-segment2.start.x))/denominator;
  if((ua>1.0f)||(ua<0.0f)) return result;
  result=new Point2D(segment1.start.x+ua*(segment1.end.x-segment1.start.x),segment1.start.y+ua*(segment1.end.y-segment1.start.y));
  return result;
}

boolean colinear(final Point2D p1,final Point2D p2,final Point2D p3,final float threshold){
  //Three points are considered collinear if p1 lies very close to the line p2-p3.
  float d2=(p3.x-p2.x)*(p3.x-p2.x)+(p3.y-p2.y)*(p3.y-p2.y);
  if(d2<threshold*threshold) return true;
  float u=((p1.x-p2.x)*(p3.x-p2.x)+(p1.y-p2.y)*(p3.y-p2.y))/d2;
  float x=p2.x+u*(p3.x-p2.x);
  float y=p2.y+u*(p3.y-p2.y);  

  return ((p1.x-x)*(p1.x-x)+(p1.y-y)*(p1.y-y))<threshold*threshold;


}

boolean inside(final Point2D point, final ArrayList borders){
  boolean result=false;
  Segment2D testSegment = new Segment2D(point.x,point.y,width+1,point.y);
  int numIntersections=0;
  Iterator borderItr = borders.iterator();
  while(borderItr.hasNext()){
    Segment2D currentBorder =(Segment2D) borderItr.next();
    if(segmentIntersectionWithSegment(testSegment,currentBorder)!=null) numIntersections++;

  }
  if((numIntersections%2==1))  result=true;
  numIntersections=0;
  testSegment = new Segment2D(point.x,point.y,point.x,height+1);
  borderItr = borders.iterator();
  while(borderItr.hasNext()){
    Segment2D currentBorder =(Segment2D) borderItr.next();
    if(segmentIntersectionWithSegment(testSegment,currentBorder)!=null) numIntersections++;

  }
  if((numIntersections%2==1))  result=true;
  return result;

}

Segment2D extendToBorder(final Segment2D segment, final ArrayList borders){
  Point2D startPoint = null ;
  Iterator itr = borders.iterator();
  int border=-1;
  Segment2D currentBorder=new Segment2D();
  while ((itr.hasNext( ))&&(startPoint == null)){
    currentBorder=(Segment2D)itr.next();
    startPoint = segmentIntersectionWithLine(currentBorder,segment);
    border++;
  }
  if(startPoint != null){
    startPoint.onBorder=border;
    currentBorder.add(startPoint);
  }
  Point2D endPoint = null ;
  while ((itr.hasNext( ))&&(endPoint == null)){
    currentBorder=(Segment2D)itr.next();
    endPoint = segmentIntersectionWithLine(currentBorder,segment);
    border++;
  }
  if(endPoint != null){
    endPoint.onBorder=border;
    currentBorder.add(endPoint);

  }

  if((startPoint != null)&&(endPoint != null)) return new Segment2D(startPoint,endPoint);
  return new Segment2D(segment);
}

