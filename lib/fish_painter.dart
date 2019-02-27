import 'package:flutter/material.dart';
import 'fish_manager.dart';

class FishPainter extends CustomPainter{
  Paint painter;
  FishManager manager;

  FishPainter(FishManager fishManager) {
    painter = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    manager = fishManager;
  }

  @override
  void paint(Canvas canvas, Size size) {
    List list = manager.getFishList;
    for (var i = 0; i < list.length; i++) {
      if (list[i].isPredator) {
        painter.color = Colors.red;
        canvas.drawRect(list[i].rect, painter);
      }else {
        painter.color = Colors.green;
        canvas.drawRect(list[i].rect, painter);
      }
    }
  }

  @override
  bool shouldRepaint(FishPainter oldDelegate) {
    return true;
  }
}