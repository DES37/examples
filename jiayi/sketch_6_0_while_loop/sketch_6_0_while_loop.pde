//REVEIW EXAMPLE: USING THE IF STATEMENT TO MOVE A BALL TO THE RIGHT.
float x=0;

void setup() {
 size (600, 400);
}

void draw() {
 background (0);
 fill(255);
 noStroke();

 if (x<width) {
   ellipse (x, 100, 25, 25);
   x=x+1;
 }
}
/*in this example, each time it draws a circle, it comes out of the if statement
and goes to line 9 to set the background to 0 and goes down the code inside draw again.
*/

////EXAMPLE 1 TO SEE HOW WHILE LOOP WORKS. I AM COPYING THE EXACT SAME CODE AS ABOVE, BUT CHANGE IF TO WHILE.
//float x=0;

//void setup() {
// size (600, 400);
// background (0);            //in order to avoid the wipeout effect, let's define the background in setup.
//}

//void draw() {
// //background (0);            //wipe out all the circles.
// fill(255);
// noStroke();
// println(x);

// while (x<width) {          //it would draw all these circles, but then background = 0 wipes out everything, when it gets out of the loop.
//   //println(x);

//   ellipse (x, 100, 25, 25);
//   //x=x+1; //too many circles!
//   x=x+100; //ah, better!
// }
//}


////EXAMPLE 2: SYMMETRICALLY FIT FIVE CIRCLES ALONG THE X AXIS, STARTING AT x=100, WHAT IS THE SPACING BETWEEN EACH CIRCLE?
//float x=100;

//void setup () {
// size (600, 400);
// background(0);
//}

//void draw () {

// noFill();
// stroke(255);

// while (x<width) {          //as long as x<width is met, it stays within the while loop, and draws the circle over and over until x is no longer < width.
//   ellipse(x, 150, 25, 25);
//   x=x+100; //(width-2*padding)/(number of circles desired-1). (600-200)/4=100. background does not clear in between each draw.
// }
//}

/*DANGER!! LOOP STUCK, even though all syntax is correct! 
 x will forever go to the left and never get out of the loop! 
 Loops must have an exist plan!
 */
//x=0;
//while (x<width){
//  x=x-1;
//  ellipse(x, 100, 20, 20);
//}