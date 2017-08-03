class Voronoi{

  int NUMPOINTS;
  int order;
  ArrayList initialPoints;
  ArrayList initialSegments;
  ArrayList bisectors;
  ArrayList borders;
  ArrayList bisectorIntersections;
  ArrayList cells;
  color fillColor;
  color strokeColor;


  Voronoi(final ArrayList points, final ArrayList borders, final int o, final color fc,final color sc){
    order=o;
    NUMPOINTS=points.size();
    initializeLists();
    this.borders=borders;
    initialPoints=points;
    generateInitialSegments();
    generateBisectors(); 
    generateBisectorIntersections();
    generateVoronoiSegments();
    fillColor=fc;
    strokeColor=sc;
    clearConstruction();
  }

  void draw(float sc){
    Iterator cellItr =cells.iterator();
    while(cellItr.hasNext()){
      ((Cell)cellItr.next()).draw(sc);   
    }       
  }
  
    void draw(int steps,float sc){
    Iterator cellItr =cells.iterator();
    while(cellItr.hasNext()){
      ((Cell)cellItr.next()).draw(steps,sc);   
    }       
  }

   void drawRounded(float sc){
    Iterator cellItr =cells.iterator();
    while(cellItr.hasNext()){
      ((Cell)cellItr.next()).drawRounded(sc);   
    }       
  }


  void initializeLists(){
    initialPoints = new ArrayList();
    initialSegments = new ArrayList();
    bisectors = new ArrayList();
    bisectorIntersections = new ArrayList();
    cells = new ArrayList();
  }
  
  void clearConstruction(){
    initialSegments.clear();
    bisectors.clear();
    bisectorIntersections.clear();    
  }

  

  

  void generateInitialSegments(){
    for(int i=0;i<NUMPOINTS;i++){
      SegmentPoint2D pointi=(SegmentPoint2D)initialPoints.get(i);
      for(int j=i+1;j<NUMPOINTS;j++){
         SegmentPoint2D pointj=(SegmentPoint2D)initialPoints.get(j);
        Segment2D segmentij = new Segment2D(pointi.convertToPoint2D(),pointj.convertToPoint2D());
        initialSegments.add(segmentij);
        pointi.add(segmentij);
        pointj.add(segmentij);
      }
    }  
  }


  void generateBisectors(){ 
    Iterator itr = initialSegments.iterator();
    while (itr.hasNext( )) {
      Segment2D currentSegment=(Segment2D)itr.next();
      Point2D midPoint = new Point2D(0.5f*currentSegment.start.x+0.5f*currentSegment.end.x, 0.5f*currentSegment.start.y+0.5f*currentSegment.end.y);
      Point2D relPoint =new Point2D(currentSegment.start.y-currentSegment.end.y, currentSegment.end.x-currentSegment.start.x);
      Point2D startPoint=new Point2D(midPoint.x-relPoint.x,midPoint.y-relPoint.y);
      Point2D endPoint=new Point2D(midPoint.x+relPoint.x,midPoint.y+relPoint.y);
      Segment2D bisector = new Segment2D(extendToBorder(new Segment2D(startPoint,endPoint), borders));
      bisectors.add(bisector);
      currentSegment.bisector = bisector;
    } 
  }  

  void  generateBisectorIntersections(){
    for(int i=0;i<bisectors.size();i++){
      Segment2D bisectori = (Segment2D)bisectors.get(i);
      for(int j=i+1;j<bisectors.size();j++){
        Segment2D bisectorj = (Segment2D)bisectors.get(j);
        Point2D result = segmentIntersectionWithSegment(bisectori, bisectorj);
        if (result!=null) {
          bisectorIntersections.add(result);
          bisectori.points.add(result);
          bisectorj.points.add(result);
        }
      }
    }
  }

  void  generateVoronoiSegments(){
    Iterator centerPointItr = initialPoints.iterator();
    while(centerPointItr.hasNext()){
      SegmentPoint2D currentCenterPoint = (SegmentPoint2D)centerPointItr.next();
      ArrayList periphery = new ArrayList();      
      Iterator segmentItr = currentCenterPoint.belongsToSegment.iterator();  
      while(segmentItr.hasNext()){
        Segment2D currentSegment = (Segment2D)segmentItr.next();
        Segment2D currentBisector = currentSegment.bisector;
        Iterator sweepPointItr = currentBisector.points.iterator();
        while(sweepPointItr.hasNext()){
          Point2D currentSweepPoint = (Point2D)sweepPointItr.next();
          Segment2D currentSweepRay = new Segment2D(currentCenterPoint,currentSweepPoint);
          Iterator sweepSegmentItr = currentCenterPoint.belongsToSegment.iterator();
          boolean intersect = false;
          while(sweepSegmentItr.hasNext()){
            Segment2D currentSweepSegment =(Segment2D)sweepSegmentItr.next();
            Segment2D currentSweepBisector=currentSweepSegment.bisector;
            Point2D sweepIntersection = segmentIntersectionWithSegment(currentSweepRay, currentSweepBisector);
            if ((sweepIntersection!=null)&&(dist(sweepIntersection,currentSweepPoint)>0.1f)){
              intersect = true;
              break;
            }
          }
          if(!intersect){
            Point2D peripheryPoint = new Point2D(currentSweepPoint);
            periphery.add(peripheryPoint);
          }
        }
      }
      
      segmentItr = borders.iterator();      
      while(segmentItr.hasNext()){
        Segment2D currentSegment = (Segment2D)segmentItr.next();
        Iterator sweepPointItr = currentSegment.points.iterator();
        while(sweepPointItr.hasNext()){
          Point2D currentSweepPoint = (Point2D)sweepPointItr.next();
          Segment2D currentSweepRay = new Segment2D(currentCenterPoint,currentSweepPoint);
          Iterator sweepSegmentItr = currentCenterPoint.belongsToSegment.iterator();
          boolean intersect = false;
          while(sweepSegmentItr.hasNext()){
            Segment2D currentSweepSegment =(Segment2D)sweepSegmentItr.next();
            Segment2D currentSweepBisector=currentSweepSegment.bisector;
            Point2D sweepIntersection = segmentIntersectionWithSegment(currentSweepRay, currentSweepBisector);
            if ((sweepIntersection!=null)&&(dist(sweepIntersection,currentSweepPoint)>0.1f)){
              intersect = true;
              break;
            }
          }
          if(!intersect){
            Point2D peripheryPoint = new Point2D(currentSweepPoint);
            periphery.add(peripheryPoint);

          }
        }
      }            
      Cell cell = new Cell(currentCenterPoint.convertToPoint2D());
      cell.periphery.addAll(periphery);
      cell.update();
      cells.add(cell);
    }
  }

}
