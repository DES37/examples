/* Spencer Mathews
 *
 * Particle class designed from scratch
 * likely not optimized but a learning experience
 *
 * started: 8/2016
 */

class Particle {

  PVector pos;  //position
  PVector prev_pos;

  PVector v;  //velocity

  float dia;  //diameter
  color col;  //color




  Particle(float x, float y) {
    pos = new PVector(x, y);

    v = new PVector(0, 0);

    dia = 10;
    col = color(255);
  }

  void display() {
    stroke(col);
    fill(col);
    ellipse(pos.x, pos.y, dia, dia);
  }

  void update(VectorField vf) {
    prev_pos.set(pos);

    v=vf.velocity(pos.x, pos.y);
    pos.add(v);
    println(v, pos);
  }
}