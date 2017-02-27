/* Spencer Mathews, 10/2016
 *
 * Plot iterates of the logistic map across a range of r values.
 *
 * The drawLogistic function is overloaded.
 *   drawLogistic() - continues to iterate as sketch is run
 *   drawLogistic(float) - specify number of iterations
 */

/* simulation variables */
int ignoredIterates = 100;

/* shared plotting variables */
float dr = 0.001;  // consider choosing number of bins instead of dr
float rMin = 3.4;  // 2.4, 3.4
float rMax = 4.0;
float scaleX;
float scaleY;

/* continuous mode variables */
float[] rValues;
float[] timeSeries;  // store current x value for each r

void setup() {
  size(800, 800, FX2D);  // FX2D is noticeable faster than default renderer
  background(0);

  /* set shared globals */
  scaleX = width/(rMax-rMin);
  scaleY = height;

  /* set up arrays for continuous mode */
  int bins = round((rMax-rMin)/dr) + 1;  // must use round to avoid floating point problems

  rValues = new float[bins];

  // note: depending on dr the final bin may or may not include rMax
  for (int i=0; i<rValues.length; i++) {
    rValues[i] = rMin + i*dr;
  }

  timeSeries = new float[bins];

  // set initial x values
  for (int i=0; i<timeSeries.length; i++) {
    timeSeries[i] = random(0, 1);  // randomize x0, some may be degenerate
  }
  // ignore initial iterates
  for (int i=0; i<timeSeries.length; i++) {
    for (int j=0; j<ignoredIterates; j++) {
      timeSeries[i] = logisticMap(rValues[i], timeSeries[i]);
    }
  }
}

void draw() {
  drawLogistic(1000);
  
  surface.setTitle(int(frameRate) + " fps");
  
  if (frameCount % 60 == 0) {
    print('.');
  }
}

/* Draw logistic map in continous mode
 *
 * - mouseY determines transparency, but note that drawing is additive
 *
 * uses shared global vabiables: rMin, rMax, dr, scaleX, scaleY, ignoreIterates
 * uses global arrays: rValues, timeSeries (handle ignored iterates in setup)
 */
void drawLogistic() {

  translate(-rMin*scaleX, height);

  stroke(255, map(mouseY, 0, height, 255, 0));

  // iterate across all r values
  for (int i=0; i<timeSeries.length; i++) {
    point(rValues[i]*scaleX, -timeSeries[i]*scaleY);

    timeSeries[i] = logisticMap(rValues[i], timeSeries[i]);
  }
}

/* Draw logistic map with fixed number of iterations
 *
 * - take number of time steps as paramter
 * - mouseY determines transparency (up=high, down=low)
 *
 * uses global vabiables: rMin, rMax, dr, scaleX, scaleY, ignoreIterates
 */
void drawLogistic(float timeSteps) {

  float x;

  background(0);
  translate(-rMin*scaleX, height);  // set origin at lower left to rMin, 0

  stroke(255, map(mouseY, 0, height, 255, 0));

  // loop through all desired values of r parameter
  for (float r = rMin; r<rMax; r+=dr) {

    x = random(0, 1);  // randomize x0, some may be degenerate

    for (int i=0; i<ignoredIterates; i++) {
      x = logisticMap(r, x);
    }

    for (int i=0; i<timeSteps; i++) {
      point(r*scaleX, -x*scaleY);
      x = logisticMap(r, x);
    }
  }
}

/* Iterate logistic map
 *
 */
float logisticMap(float r, float x) {
  return r*x*(1-x);
}