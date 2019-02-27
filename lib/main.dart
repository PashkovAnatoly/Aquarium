import 'package:flutter/material.dart';
import 'moving_fish.dart';

void main() => runApp(AquariumApp());

class AquariumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AquariumAppPage(),
    );
  }
}

class AquariumAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: MovingFish()
      )
      );
  }
}
