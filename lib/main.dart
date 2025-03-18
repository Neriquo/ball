import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: BallPage(),
  ),
);

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
     appBar: AppBar(
       backgroundColor: Colors.indigo,
       title: Text(
           "Ask me anything",
           style: TextStyle(color: Colors.white70)
       ),
     ),
      body: Ball()
    );
  }
}

class Ball extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () { setState(() {
          ballNumber = Random().nextInt(5) + 1;
        });; },
        child: Center(child: Image.asset("./images/ball${ballNumber}.png"))
    );
  }
}