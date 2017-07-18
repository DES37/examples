/* Control animation speed with millis()
 *
 * author: Spencer Mathews, derived from Jiayi Young "millis"
 * date: 5/2017
 * tags: #conditionals #animation #techniques
 */

int interval = 1000;  // interval in milliseconds
int lastTime;  // records last time event occured

void setup() {
  size(300, 300);
}

void draw() {
  background(0);
  
  int currentTime = millis();
  
  if (currentTime - lastTime > interval) {
    fill(random(255), random(255), random(255));
    lastTime = millis(); //record time when fill happened
  }

  rect(75, 75, 150, 150);
}