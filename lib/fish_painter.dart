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
      if (list[i].isPredator)
        painter.color = Colors.red;
      else
        painter.color = Colors.green;

      canvas.drawRect(list[i].rect, painter);

      painter.color = Colors.black;
      double dx, dy;
      if (list[i].direction == 1 || list[i].direction == 7 || list[i].direction == 6)
        dx = list[i].rect.center.dx - 0.25 * list[i].rect.width;
      else if (list[i].direction == 0 || list[i].direction == 4 || list[i].direction == 5)
        dx = list[i].rect.center.dx + 0.25 * list[i].rect.width;
      else dx = list[i].rect.center.dx - 0.25 * list[i].rect.width;
      dy = list[i].rect.center.dy - 0.25 * list[i].rect.height;
      canvas.drawCircle(Offset(dx, dy), 2, painter);
    }
  }

  @override
  bool shouldRepaint(FishPainter oldDelegate) {
    return true;
  }
}