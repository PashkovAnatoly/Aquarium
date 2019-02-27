import 'package:flutter/material.dart';
import 'fish.dart';

void main() => runApp(AquariumApp());

class AquariumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aquarium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AquariumAppPage(),
    );
  }
}

class AquariumAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Aquarium"),
//      ),
      backgroundColor: Colors.cyan,
      body: Center(
        child: MovingFish()
      )
      );
  }
}
