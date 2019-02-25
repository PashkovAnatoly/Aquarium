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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _move(Offset(0.0, 0.0) & Size(60.0, 30.0)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Center(
          child: Text(
              snapshot.data.bottomCenter.toString()
          )
        );
      },
    );
  }
}
Stream<Rect> _move(Rect rect) async*{
  yield* Stream.periodic(
      Duration(seconds: 1),
          (int a){
        return rect.shift(Offset(a.toDouble(), 0.0));
      }
  );
}

class FishPainter extends CustomPainter{
  Paint _paint;
  FishManager manager;

  FishPainter() {
    _paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    manager = new FishManager();
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