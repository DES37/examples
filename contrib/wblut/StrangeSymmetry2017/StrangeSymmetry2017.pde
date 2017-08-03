//http://www.wblut.com/2017/05/28/old-code-strange-symmetry/
// first version http://www.wblut.com/2008/03/27/strange-symmetry/

// Strange Symmetry 2

 // Licensed under Creative Commons,  W:Blut 2008, Vanhoutte Frederik <www wblut com>
 // http://creativecommons.org/licenses/by/2.0/be/deed.en
 //
 // Disclaimer: the software
 //
 // This Processing sketch is free code and provided without any warranty.
 // It is free for any use. It represents some amateur coding by the author.
 // It is not intended to have any instructional value nor does it represent good coding practice. 
 //
 // Disclaimer: the maths
 //
 // The formulae used are not necessarily attractors, strange, chaotic or otherwise. These terms have a well-defined
 // mathematical definition. The only intent of this code is the generation of interesting looking images using a similar
 // methodology.
 //
 //
 // Concept
 // 
 // 2D points (particles) are iterated through some functions: x=f(x,y), y=f(x,y). At each step the position is recorded.
 // For certain functions, the random paths of thousands of particles reveal remarkable structure. Search on phrases like "chaotic attractor",
 // "strange attractor" or the somewhat similar "iterated function system" (IFS).
 //
 // Structural outline
 //
 // A 'map' is essentially two functions in one object, representing the x and y iterating functions. An array of particles ('Particle')
 // is collected together with a randomly generated map into an 'AttractorSystem'. The AttractorSystem object is responsible for generating
 // new particles, tracking them through the functions and killing them when expired. The coordinates used by the particles are the real function
 // values.
 //
 // The 'AccumulationGrid' stores information about particle hits in a discrete 2D array. It stores a hit count and potentially, also several channels (hue,
 // saturation and alpha). The accumulation grid defines the resolution and the visible portion of the function space,
 // what information to assign to each channel and how to process each hit. The coordinates used in the grid are again the real function values.
 //
 // An 'AttractorDisplay' couples an AttractorSystem to an AccumulationGrid and handles the display of an accumulation grid, converting it to an
 // arbitrarily sized image. The coordinates of an AttractorDisplay are in pixels. All functions for visualizing the accumulation grid are
 // handled here, turning the grid counts and channels into color information.
 //
 // The interface is handled by a 'AttractorDisplayArray'. To avoid excessive memory requirements it is actually an array of Map, not of
 // AttractorDisplay. Unfortunately this does imply that changes to the AttractorSystem and Grid are lost when returning to the explorer...
 //


// Main display
AttractorDisplayArray attractorDisplayArray;
Colorbar briBar,hueBar, satBar;

// GUI library by Andreas Schlegel. For more info: http://www.sojamo.de/libraries/controlP5/
import controlP5.*;
ControlP5 controlP5;
int controlWidth=295;

void setup(){
  size(1295,1000);  
  background(30);
  // color and other values are most easily handled if constrained between 0 and 1. This way you don't have to handle
  // rescaling when using powers or roots. (This is convenient for gamma correction etc.).  
  colorMode(HSB,1.0f);
  attractorDisplayArray = new AttractorDisplayArray(5,5,0,0,width-controlWidth,height,0,0,width-controlWidth,height);
  setupGUI();
}

void draw(){
  attractorDisplayArray.update();
  updateGUI();
}

void mousePressed(){ 
  attractorDisplayArray.mousePressed();  
}
void mouseReleased(){  
  attractorDisplayArray.mouseReleased();  
}
void keyPressed(){  
  attractorDisplayArray.keyPressed();
}
void keyReleased(){
  attractorDisplayArray.keyReleased(); 
}