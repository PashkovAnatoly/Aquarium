import 'package:flutter/material.dart';

import 'fish_manager.dart';
import 'fish_painter.dart';

class MovingFish extends StatelessWidget{

  final FishManager manager = new FishManager();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: manager.moveFish(MediaQuery.of(context).size.width.toInt() ~/2, MediaQuery.of(context).size.height.toInt() ~/2),
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