# The Nature of Code / 1. Vectors

Introduction to Euclidean vectors.

## 1.1

location and speed

Example 1.1

## 1.2

use PVectors for location and velocity

## 1.3

use vector addition so we can do

    location.add(velocity);

Example 1.2

can refer to componenents using `.x`, `.y`.

## 1.4

PVector methods: `sub()`, `mult()`

Example 1.3
Example 1.4

## 1.5

PVector method: `mag()`

Example 1.5

## 1.6

PVector methods: `normalize()`

Example 1.6

## 1.7

Begin velocity and `Mover` class with location and velocity PVector fields and update, display, and checkEdges methods.

Example 1.7: velocity

## 1.8

Add `accceleration` to Mover class and limit velocity.

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);

Show constant acceleration (#1) and random acceleration (#2).

Example 1.8: constant acceleration

Example 1.9: random acceleration

## 1.9

Introduce *static* methods for `add()`, ``sub()`, `mult()`, and `div()` so operations create new PVectors.

## 1.10

Show acceleration towards the mouse (#3).

    PVector dir = PVector.sub(mouse,location);
    dir.normalize();
    dir.mult(0.5);
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);

Example 1.10: acceleration toward mouse

Example 1.11: same but with many Movers
