import 'package:flutter/material.dart';
import 'dart:math';

class Fish {
  int size;
  Rect rect;
  int direction;
  bool isPredator;
  int speed;

  Random rng = new Random();

  Fish(){
    this.size = rng.nextInt(4) + 1;
    this.rect = Offset(
        rng.nextBool() ? rng.nextInt(180).toDouble() : rng.nextInt(180) *
            (-1.0),
        rng.nextBool() ? rng.nextInt(250).toDouble() : rng.nextInt(250) *
            (-1.0))
    & Size(20.0 * size, 10.0 * size);
    this.direction = rng.nextInt(7);
    this.isPredator = rng.nextBool();
    this.speed = 6 - this.size;
  }
}