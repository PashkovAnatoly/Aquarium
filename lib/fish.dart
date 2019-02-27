import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';

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

class FishManager {

  List<Fish> fishList = new List();
  Random rng  = new Random();

  FishManager() {
    for (var i = 0; i < 10; i++) {
      fishList.add(new Fish());
    }
  }
  List get getFishList {
    return fishList;
  }

  Stream<Rect> _move(int maxWidth, int maxHeight) async*{
    yield* Stream.periodic(
        Duration(milliseconds: 100),
            (int a){
          for(int i = 0; i < fishList.length; i++){
            fishList[i].rect = fishList[i].rect.shift(getOffsetDirection(fishList[i]));
          }
          isOverlaps();
          outBoundary(maxWidth, maxHeight);
        }
    );
  }

  Offset getOffsetDirection(Fish fish){
    switch(fish.direction){
      case 0:
        return Offset(2.0 * fish.speed, 0.0);
      case 1:
        return Offset(-2.0 * fish.speed, 0.0);
      case 2:
        return Offset(0.0, 2.0 * fish.speed);
      case 3:
        return Offset(0.0, -2.0 * fish.speed);
      case 4:
        return Offset(1.41 * fish.speed, 1.41 * fish.speed);
      case 5:
        return Offset(1.41 * fish.speed, -1.41 * fish.speed);
      case 6:
        return Offset(-1.41 * fish.speed, -1.41 * fish.speed);
      case 7:
        return Offset(-1.41 * fish.speed, 1.41 * fish.speed);
      default:
        return null;
    }
  }
  void isOverlaps() async{

    for (int i = 0; i < fishList.length; i++){
      for (int j = 0; j < fishList.length; j++){
        if(i == j) continue;
        if(fishList[i].rect.overlaps(fishList[j].rect) & fishList[i].isPredator &
        ((fishList[i].size >= fishList[j].size) || (!fishList[j].isPredator & (fishList[i].size + 1 >= fishList[j].size)) )){
          fishList.removeAt(j);
          Future<Fish> future = new Future.delayed(const Duration(minutes: 1), () => new Fish());
          future.then((Fish value) => fishList.add(value)).catchError((e) => 777);
        }
      }
    }
  }
  void outBoundary(int maxWidthOffset, int maxHeightOffset){
    for (int i = 0; i < fishList.length; i++){
      if(fishList[i].rect.centerRight.dx > maxWidthOffset) {
        fishList[i].rect = fishList[i].rect.shift(Offset(-10.0, 0.0));
        fishList[i].direction = rng.nextInt(7);
      }
      else if(fishList[i].rect.centerLeft.dx < -maxWidthOffset) {
        fishList[i].rect = fishList[i].rect.shift(Offset(10.0, 0.0));
        fishList[i].direction = rng.nextInt(7);
      }
      else if(fishList[i].rect.topCenter.dy > maxHeightOffset - 70) {
        fishList[i].rect = fishList[i].rect.shift(Offset(0.0, -10.0));
        fishList[i].direction = rng.nextInt(7);
      }
      else if(fishList[i].rect.bottomCenter.dy < -maxHeightOffset + 50) {
        fishList[i].rect = fishList[i].rect.shift(Offset(0.0, 10.0));
        fishList[i].direction = rng.nextInt(7);
      }
    }
  }
}

class MovingFish extends StatelessWidget{

  final FishManager manager = new FishManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: manager._move(MediaQuery.of(context).size.width.toInt() ~/2, MediaQuery.of(context).size.height ~/2),
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
    List list = manager.getFishList;
    for (var i = 0; i < list.length; i++) {
      if (list[i].isPredator){
        _paint.color = Colors.red;
        canvas.drawRect(list[i].rect, _paint);
      }else {
        _paint.color = Colors.green;
        canvas.drawRect(list[i].rect, _paint);
      }
    }
  }

  @override
  bool shouldRepaint(FishPainter oldDelegate) {
    return true;
  }

}