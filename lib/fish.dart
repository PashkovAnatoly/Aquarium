import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';

class Fish {
  Rect rect;
  bool isPredator;
  int size;
  int speed;

  Fish(this.rect, this.isPredator, this.size){
    this.speed = 6 - this.size;
  }
  Stream<Rect> _move() async*{
    yield* Stream.periodic(
        Duration(seconds: 1),
            (int a){
          this.rect = this.rect.shift(Offset(2.0, 0.0));
        }
    );
  }
}

class FishManager {

  List<Fish> fishList = new List();

  FishManager() {
    for (var i = 0; i < 10; i++) {
      var rng = new Random();
      int size = rng.nextInt(4) + 1;
      var tmpRect = Offset(
          rng.nextBool() ? rng.nextInt(180).toDouble() : rng.nextInt(180) *
              (-1.0),
          rng.nextBool() ? rng.nextInt(250).toDouble() : rng.nextInt(250) *
              (-1.0))
      & Size(20.0 * size, 10.0 * size);
      fishList.add(new Fish(tmpRect, false, size));
    }
  }
  List get getFishList {
    return fishList;
  }
}

class MovingFish extends StatelessWidget{

  final FishManager manager = new FishManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: manager.getFishList.first._move(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Center(
          child: CustomPaint(
            painter: FishPainter(manager),
          )
        );
      },
    );
  }
}


class FishPainter extends CustomPainter{
  Paint _paint;
  FishManager manager;

  FishPainter(FishManager fishManager) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    manager = fishManager;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("paint");

    List list = manager.getFishList;
    for (var i = 0; i < list.length; i++) {
      canvas.drawRect(list[i].rect, _paint);
    }
  }

  @override
  bool shouldRepaint(FishPainter oldDelegate) {
    // TODO: implement shouldRepaint
    print("repaint");
    //manager.move(manager.getFishList.first);
    return true;
  }

}