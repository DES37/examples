/* Using millis() to time animations
 *
 * Two effectively equivalent ways to implement a timer
 *
 * ref: Processing Handbook 23-06, 23-07, 23-08, and 29-04
 *
 * author: Spencer Mathews
 * status: complete
 * tags: #time #animation
 */


int timer = 500;   // sets timer frequency
int lastTime = 0;  // stores time of last event (method 1)
int nextTime = 0;  // stores time that next event should run (method 2)

void setup() {
  size(500, 500);
}

void draw() {

  // method 1: record time of last event and calculate elapsed time in condition
  int pastTime = millis() - lastTime;  // Shiffman uses this extra variable, Reas puts subtraction in if statement
  if (pastTime > timer) {
    background(random(255));
    lastTime = millis();
  }

  // method 2: calculate the time the next event should run
  // an equivalent way of implmementing timer
  if (millis() > nextTime) {
    println(brightness(g.backgroundColor));
    nextTime = millis() + timer;
  }
}