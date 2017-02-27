/* Spencer Mathews, October 2016
 *
 * Work in progress of skeleton to add/select points through mouse
 */

import java.util.Iterator;

ArrayList<Point> points;

void setup() {
  size(500, 500);
  points = new ArrayList<Point>();
}

void draw() {
  background(255);

  for (Point p : points) {
    p.display();
  }
}

void mouseClicked() {
  boolean isOverSome = false;
  // Iterate over all points, must directly use iterator since foreach loops not easy to remove
  //for (Point p : points) {
  for (Iterator<Point> iterator= points.iterator(); iterator.hasNext(); ) {
    Point p = iterator.next();
    // Remove point(s) we are over and set flag so we don't add a new one
    if (p.isOver()) {
      iterator.remove();  // only robust way to remove from a collection while iterating over it
      println(points.size());
      isOverSome = true;
    }
  }
  // If we did not click on existing point then add a new one
  if (!isOverSome) {
    points.add(new Point(mouseX, mouseY));
    println(points.size());
  }
}