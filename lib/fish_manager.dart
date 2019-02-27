import 'package:flutter/material.dart';
import 'dart:math';

import 'fish.dart';

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

  Stream<Rect> moveFish(int maxWidth, int maxHeight) async*{
    yield* Stream.periodic(
        Duration(milliseconds: 100),
            (int a){
          for(int i = 0; i < fishList.length; i++){
            fishList[i].rect = fishList[i].rect.shift(getDirection(fishList[i]));
          }
          checkOverlaps();
          checkBorders(maxWidth, maxHeight);
        }
    );
  }

  Offset getDirection(Fish fish){
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
        throw new Exception(["getDirection(Fish fish): Illegal fish direction"]);
    }
  }
  void checkOverlaps() async{

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
  void checkBorders(int maxWidthOffset, int maxHeightOffset){
    for (int i = 0; i < fishList.length; i++){
      if(fishList[i].rect.centerRight.dx > maxWidthOffset) {
        fishList[i].rect = fishList[i].rect.shift(Offset(-10.0, 0.0));
        fishList[i].direction = rng.nextInt(7);
      }
      else if(fishList[i].rect.centerLeft.dx < -maxWidthOffset) {
        fishList[i].rect = fishList[i].rect.shift(Offset(10.0, 0.0));
        fishList[i].direction = rng.nextInt(7);
      }
      else if(fishList[i].rect.topCenter.dy > maxHeightOffset) {
        fishList[i].rect = fishList[i].rect.shift(Offset(0.0, -10.0));
        fishList[i].direction = rng.nextInt(7);
      }
      else if(fishList[i].rect.bottomCenter.dy < -maxHeightOffset) {
        fishList[i].rect = fishList[i].rect.shift(Offset(0.0, 10.0));
        fishList[i].direction = rng.nextInt(7);
      }
    }
  }
}