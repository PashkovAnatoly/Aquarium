import 'package:flutter/material.dart';
import 'dart:math';

class Fish {
  Rect rect;
  bool isPredator;
  int size;
  int speed;

  Fish(this.rect, this.isPredator, this.size){
    this.speed = 6 - this.size;
  }
}

class FishManager {

  List<Fish> fishList = new List();

  FishManager() {
    for (var i = 0; i < 10; i++) {
      var rng = new Random();
      int size = rng.nextInt(5);
      var tmpRect = Offset(
          rng.nextBool() ? rng.nextInt(180).toDouble() : rng.nextInt(180) *
              (-1.0),
          rng.nextBool() ? rng.nextInt(250).toDouble() : rng.nextInt(250) *
              (-1.0))
      & Size(20.0 * size, 10.0 * size);
      fishList.add(new Fish(tmpRect, false, size));
    }
  }
}

class FishPainter extends CustomPainter{
  Paint _paint;

  FishPainter() {
    _paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
  }

  @override
  void paint(Canvas canvas, Size size) {

  FishManager manager = new FishManager();
  List list = manager.fishList;
    for (var i = 0; i < list.length; i++) {
      canvas.drawRect(list[i].rect, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}