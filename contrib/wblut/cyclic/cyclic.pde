//http://www.wblut.com/2008/06/21/cyclic/

/*
// cyclic - a loop of tracking particles
 // 2008 Frederik Vanhoutte
 // http://www.wblut.com
 */

Tracker[] t;
int NUMTRACKERS=1000;

void setup() {
  size(1000, 1000, P3D);
  smooth(8);
  background(255);

  // Create trackers
  // parameters
  // * random initial position
  // * random initial heading
  // * initial speed = 1.0
  // * maximum speed = 10.0
  // * maximum acceleration = 0.1
  // * maximum deceleration = 10.0
  // * random maximum turning angle 
  // * initial target = center of sketch
  t=new Tracker[NUMTRACKERS];
  for (int i=0; i<NUMTRACKERS; i++) {
    t[i] = new Tracker(
      new PVector(random(-200, width+200), random(-200, height+200), 0), 
      randomVector(), 1.0f, 10.0f, 0.1f, 10.0f, PI/(1.0f+random(11.0f)), 
      new PVector(width/2, height/2, 0));
  }
}

void draw() {
  // Update and draw trackers
  // Target of each tracher is position of previous tracker.
  // Target of first tracher is position of last tracker to complete cycle.

  for (int r=0; r<50; r++) {
    t[0].update(t[NUMTRACKERS-1].currentState.position);

    for (int i=1; i<NUMTRACKERS; i++) {
      t[i].update(t[i-1].currentState.position);
    } 

    for (int i=1; i<NUMTRACKERS; i++) {
      t[i].draw(); 
      // Optionally: chance of resetting individual trackers to keep sketch dynamic
      if (random(1.0f)<-1)  t[i] = new Tracker(
        new PVector(random(-200, width+200), random(-200, height+200), 0), 
        randomVector(), 1.0f, 10.0f, 0.1f, 10.0f, PI/(1.0f+random(11.0f)), 
        new PVector(width/2, height/2, 0));
    }
  }
}

void mousePressed() {
  // Reset on mouseclick
  background(255);
  for (int i=0; i<NUMTRACKERS; i++) {
    t[i] = new Tracker(
      new PVector(random(-200, width+200), random(-200, height+200), 0), 
      randomVector(), 1.0f, 10.0f, 0.1f, 10.0f, PI/(1.0f+random(11.0f)), 
      new PVector(width/2, height/2, 0));
  }
}

PVector randomVector() {
  float t = random(TWO_PI);
  return new PVector(cos(t), sin(t), 0);
}

class State {
  // Utility class 
  // Velocity is separated in heading (direction) and speed (magnitude).
  // This makes it easier to work with static particles, a 0-vector has no direction :-(

  PVector position;
  PVector heading;
  float speed;

  State(PVector pos, PVector hdg, float spd) {
    position = pos.copy();
    heading = hdg.copy();
    heading.normalize();
    speed = spd;
  }

  State copy() {
    return new State(position, heading, speed);
  }
}


class Tracker {
  State currentState;
  State previousState;
  State targetState;
  // targetState contains the current target position, heading to the target
  // and speed particle is trying to maintain.

  float maxSpeed; // maximum speed when lined up with target
  float maxTurnSpeed; // maximum speed while turning
  float maxAcc; // maximum increase of speed per update
  float maxDec; // maximum decrease of speed per update
  float maxTurn; // maxim change of heading per update


  Tracker(PVector pos, PVector hdg, float spd, float maxSpd, float maxA, float maxD, float maxTrn, PVector tgt) {
    currentState = new State(pos, hdg, spd);
    previousState = currentState.copy();
    maxSpeed = maxSpd;
    maxTurnSpeed = maxSpd*0.5f;
    maxAcc = maxA;
    maxDec = maxD;
    maxTurn=maxTrn;

    // Initial heading is determined by target, if identical to initial position, use a random heading instead
    PVector tmpHdg;

    if (PVector.sub(tgt, pos).magSq()<=0.000001) {
      tmpHdg=randomVector();
    } else {
      tmpHdg =PVector.sub(tgt, pos);
      tmpHdg.normalize();
    }
    targetState = new State(tgt, tmpHdg, maxSpd);
  }

  void update(PVector tgt) {

    previousState = currentState.copy();         

    // Determine new heading
    PVector tmpHdg = PVector.sub(tgt, currentState.position);

    // Reduce maximum speed if close to target otherwise high speeds result in
    // orbiting particles never reaching the target
    float distanceFactor = min(tmpHdg.magSq()/(maxSpeed*maxSpeed), 1f);

    // If target is reached keep current heading
    if (tmpHdg.magSq()<0.000001) {
      tmpHdg= targetState.heading.copy();
    } else {
      tmpHdg.normalize();
    }

    targetState.position = tgt.copy();
    targetState.heading = tmpHdg.copy();
    targetState.speed = maxSpeed*distanceFactor;


    // Turn heading towards target
    float angle = PVector.angleBetween(currentState.heading, targetState.heading);
    if (angle<maxTurn) {
      // Target heading reached
      currentState.heading = targetState.heading.copy();
    } else {
      PVector axis = currentState.heading.cross(targetState.heading);
      axis.normalize();
      currentState.heading = currentState.heading.rotate(maxTurn);
      currentState.heading.normalize();
      targetState.speed = targetState.speed*0.5f;
    }


    // Adjust speed, if too fast, brake, if too slow, accelerate
    if (currentState.speed > targetState.speed) {
      if (currentState.speed > targetState.speed + maxDec) {
        currentState.speed-=maxDec;
      } else {
        currentState.speed = targetState.speed;
      }
    } else {
      if (currentState.speed < targetState.speed - maxAcc) {
        currentState.speed+=maxAcc;
      } else {
        currentState.speed = targetState.speed;
      }
    }

    // update position, velocity = speed * heading
    currentState.position.add(currentState.heading.mult(currentState.speed));
  }


  void draw() {
    // Embossed lines for 3D illusion
    stroke(255, 10);
    line(currentState.position.x, currentState.position.y-1, 0, 
      previousState.position.x, previousState.position.y-1, 0);   
    stroke(220, 170, 124, 10);
    line(currentState.position.x+1, currentState.position.y+1, 0, 
      previousState.position.x+1, previousState.position.y+1, 0);
    stroke(0, 10);
    line(currentState.position.x, currentState.position.y, 0, 
      previousState.position.x, previousState.position.y, 0);
  }
}