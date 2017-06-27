# The Nature of Code / 2. Forces

## 2.1

Force is a vector that causes objects with mass to accelerate.

Newton's First Law

equilibrium

Newton's Third Law

$$F=ma$$

## 2.2

Newton's Second Law

We desire `mover.applyForce()` method to update acceleration.

This naive implementation only considers a single force.

    void applyForce(PVector force) {
      acceleration = force;
    }

## 2.3

In order to accumulate force, i.e. *net force* we need to add all forces together before dividing by mass.

    void applyForce(PVector force) {
      acceleration.add(force);
    }

Note acceleration has no memory. One was is clearing at end of update():

    acceleration.mult(0);

## 2.4

Add in mass, which has been previously ignored. Note that we need to make sure division does not affect the force vector.

Either make a copy (with `get()`):

    void applyForce(PVector force) {
      PVector f = force.get();
      f.div(mass);
      acceleration.add(f);
    }

or use static methods:

    void applyForce(PVector force) {
      PVector f = PVector.div(force, mass);
      acceleration.add(f);
    }

## 2.5

Example 2.1

Example 2.2

## 2.6

Example 2.3

## 2.7

Example 2.4

## 2.8

Example 2.5

## 2.9

Example 2.6

Example 2.7

## 2.10

Example 2.8
