import processing.video.*;
Movie myMovie;
int startVideo = 0; 

void setup() {
  size(640, 360);
  myMovie = new Movie(this, "transit.mov");
  myMovie.loop();
}

void draw() {
  stroke(0);
  noFill();
  ellipse(width/2, height/2, 200,200);
  text( "Click here to start video!", width/2-80, height/2);
  if (startVideo == 1){
    image(myMovie, 0, 0);
  }
}


  void mouseClicked() {
    if (dist(mouseX, mouseY,width/2, height/2) <200) {
    startVideo=1-startVideo;
    }
  }


// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

