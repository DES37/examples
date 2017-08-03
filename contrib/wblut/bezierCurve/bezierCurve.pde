//http://www.wblut.com/tutorials/processing/bezier-curve-editor/

ArrayList<PVector> anchorPoints; //store the anchor points
ArrayList<PVector> controlPoints; //store the control points
boolean DRAWING; // Am I drawing?
int pointCounter; //how many anchor points are there so far?
int selectedControlPoint; //What control point, if any, is the mouse on? If none, give me -1, otherwise the index of the control point in the arraylist
int selectedAnchorPoint; //What anchor point, if any, is the mouse on? If none, give me -1, otherwise the index of the anchor point in the arraylist
boolean controlLocked; //Lock the controlpoints preceding and following each anchor point together?

void setup() {
  size(800, 800);
  smooth();
  anchorPoints=new ArrayList<PVector>();
  pointCounter=0;
  controlPoints=new ArrayList<PVector>();
  DRAWING=false;
  selectedControlPoint=-1;
  selectedAnchorPoint=-1;
  controlLocked=true;
  textAlign(CENTER);
  textSize(12);
}

void draw() {
  background(255);
  stroke(0);
  noFill();
  //draw the current Bezier curve, see Processing reference on bezierVertex();
  if (anchorPoints.size()>0) {
    beginShape();
    vertex(anchorPoints.get(0).x, anchorPoints.get(0).y);
    for (int i=0; i<anchorPoints.size ()-1; i++) {
      bezierVertex(controlPoints.get(2*i).x, controlPoints.get(2*i).y, controlPoints.get(2*i+1).x, controlPoints.get(2*i+1).y, anchorPoints.get(i+1).x, anchorPoints.get(i+1).y);
    }  
    endShape(); 
  } 
  
  //draw the points
  for (PVector p : anchorPoints) {
    if (mouseOver(p,4)) {//mouse within 4 pixels of point?
      ellipse(p.x, p.y, 6, 6);
    } else {
      ellipse(p.x, p.y, 3, 3);
    }
  }
  stroke(255, 0, 0);
  for (PVector p : controlPoints) {
    if (mouseOver(p,4)) {//mouse within 4 pixels of point?
      ellipse(p.x, p.y, 6, 6);
    } else {
      ellipse(p.x, p.y, 3, 3);
    }
  }
  
  //draw the connections between control points and anchor points
  for (int i=0;i<controlPoints.size();i++) {
     //find the associated anchor point: control point 0-> anchor 0, control points 1 and 2 -> anchor point 1, etc
     // integer division: 1/2=0, 2/2=1,3/2=1, etc
    PVector anchor=anchorPoints.get((i+1)/2);
    line(anchor.x, anchor.y,controlPoints.get(i).x,controlPoints.get(i).y);
  }
  HUD();
  
}

void HUD(){
  pushStyle();
  fill(0);
  noStroke();
  text("Left-click to start adding anchor points. Existing curve will be cleared", width/2,height-100);
  text("Right-click to stop adding anchor points.", width/2,height-80);
  text("Left-click and drag anchor or control point to move.", width/2,height-60);
  text("Press spacebar to toggle lock mode. If enabled, control points move together.", width/2,height-40);
  popStyle();
}

void addControlPoints(){
 
  PVector currentAnchorPoint=anchorPoints.get(pointCounter);
  PVector previousAnchorPoint=anchorPoints.get(pointCounter-1);
  if(!controlLocked || pointCounter<2){
     //if not locked together, create two new control points along new segment
     PVector control1st =PVector.lerp(previousAnchorPoint, currentAnchorPoint, 1.0/3.0);
     PVector control2nd =PVector.lerp(previousAnchorPoint, currentAnchorPoint, 2.0/3.0);
     controlPoints.add(control1st);
     controlPoints.add(control2nd);
  }else{
     //if locked together, vector from previous control point to anchor point is same as vector from anchor point to next control point
    PVector previousControlPoint=controlPoints.get(controlPoints.size()-1);
    PVector fromPreviousControlToAnchor=PVector.sub(previousAnchorPoint,previousControlPoint);
    PVector control1st =PVector.add(previousAnchorPoint, fromPreviousControlToAnchor);
    controlPoints.add(control1st);
    PVector control2nd =PVector.lerp(previousAnchorPoint, currentAnchorPoint, 2.0/3.0);
    controlPoints.add(control2nd);
  }
}



//INTERFACE

void keyPressed(){
  if(key==' '){
 controlLocked=!controlLocked; 
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    leftMouse();
  } else if (mouseButton == RIGHT) {
    rightMouse();
  }
}

void leftMouse() {
  //Did I click on a control point? If yes, do nothing and let mouseDragged() handle it.
  selectedControlPoint=checkMouseOverControl(16.0);
  //Or did I click on an anchor point? If yes, do nothing and let mouseDragged() handle it.
  selectedAnchorPoint=checkMouseOverAnchor(16.0);
  
  //I guess not, add a new anchor point, and two new control points
  if (selectedControlPoint==-1 && selectedAnchorPoint==-1) {
    if (DRAWING==false) {
      println("Starting curve.");
      DRAWING=true;
      controlPoints.clear();
      anchorPoints.clear();
      println("Adding first anchor point.");
      anchorPoints.add(new PVector(mouseX, mouseY));
      selectedAnchorPoint=0;
      pointCounter=1;
    } else {
      println("Adding next anchor point.");
      anchorPoints.add(new PVector(mouseX, mouseY));
      addControlPoints();
      selectedAnchorPoint=pointCounter;
      pointCounter++;
    }
  }
}

void rightMouse() {
  if (DRAWING==true) {
    println("Ending curve.");
    DRAWING=false ;
  }
}

void mouseDragged() 
{
  //if the mousclick that started drag was on a control point, move the control point
  if (selectedControlPoint>-1) {
    //move the control point;
    controlPoints.get(selectedControlPoint).set(mouseX, mouseY);
    //if the control points are locked move the associated control point
    if(controlLocked && selectedControlPoint>0 && selectedControlPoint<controlPoints.size()-1){
       //find the other control point, not possibel if first or last control point in curve
       int otherControlPoint=(selectedControlPoint%2==0)?selectedControlPoint-1:selectedControlPoint+1;
       //find the associated anchor point: control point 0-> anchor 0, control points 1 and 2 -> anchor point 1, etc
       int anchorPoint=(selectedControlPoint+1)/2;//integer division: 1/2=0, 2/2=1, 3/2=1, 4/2=2, etc...
        //if locked together, vector from previous control point to anchor point is same as vector from anchor point to next control point
       PVector fromSelectedControlToAnchor=PVector.sub(anchorPoints.get(anchorPoint),controlPoints.get(selectedControlPoint));
       controlPoints.get(otherControlPoint).set(PVector.add(anchorPoints.get(anchorPoint), fromSelectedControlToAnchor));
    }  
  }else if(selectedAnchorPoint>-1){
    //If moving an anchor point, keep its control points at the same relative position 
    
    PVector fromAnchorToPreviousControl;
    PVector fromAnchorToNextControl;
    int last=anchorPoints.size()-1;
    
    PVector anchor=anchorPoints.get(selectedAnchorPoint);
    PVector previousControl;
    PVector nextControl;
    
    //Handle first anchor point (only next control point)
    if(selectedAnchorPoint==0){
      //Check if any control points exist (not the case if only one anchor point has been drawn)
      if(controlPoints.size()>0){
        nextControl=controlPoints.get(0);
        fromAnchorToNextControl=PVector.sub(nextControl,anchor);
        anchor.set(mouseX, mouseY);
        nextControl.set(PVector.add(anchor, fromAnchorToNextControl));
      }else{
        anchor.set(mouseX, mouseY);
      }
    }
    //Handle lastst anchor point (only previous control point)
    else if(selectedAnchorPoint==last){
       previousControl=controlPoints.get(controlPoints.size()-1);
       fromAnchorToPreviousControl=PVector.sub(previousControl,anchor);
       anchor.set(mouseX, mouseY);
       previousControl.set(PVector.add(anchor, fromAnchorToPreviousControl)); 
    }
    //All other anchorpoints ahve two control points
    else{
       //A0-C0-C1-A1-C2-C3-A2-C4-C5-A3 : previous control = 2*anchor-1, next control = 2*anchor
       nextControl=controlPoints.get(2*selectedAnchorPoint);
       previousControl=controlPoints.get(2*selectedAnchorPoint-1);
       fromAnchorToPreviousControl=PVector.sub(previousControl,anchor);
       fromAnchorToNextControl=PVector.sub(nextControl,anchor);
       anchor.set(mouseX, mouseY);
       nextControl.set(PVector.add(anchor, fromAnchorToNextControl)); 
       previousControl.set(PVector.add(anchor, fromAnchorToPreviousControl)); 
      
    }
  }
}

//Is mouse pointer within a certain distance of a control point? Check all points and return the first one found.
int checkMouseOverControl(float distance) {
  float squareRadius=distance*distance;
  for (int i=0; i<controlPoints.size (); i++) {
    if (mouseOver(controlPoints.get(i), squareRadius)) {
      return i;
    }
  }
  //no control point on mouse
  return -1;
}

//Is mouse pointer within a certain distance of an anchor point? Check all points and return the first one found.
int checkMouseOverAnchor(float distance) {
  float squareRadius=distance*distance;
  for (int i=0; i<anchorPoints.size (); i++) {
    if (mouseOver(anchorPoints.get(i), squareRadius)) {
      return i;
    }
  }
  //no anchor point on mouse
  return -1;
}

//Is mouse pointer within a certain distance of PVector? The cutoff distance is given as a squared distance.
//Squared distances between poinst are cheap to calculate (no square root).
boolean mouseOver(PVector p, float squareRadius) {
  return ((mouseX-p.x)*(mouseX-p.x)+(mouseY-p.y)*(mouseY-p.y))<squareRadius;
}