import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
  home: BallPage(),
));

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Ask Me Anything'),
        backgroundColor: Colors.blue[900],
      ),
      body: Ball(),
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;

  void changeBallImage() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1; // Génère un nombre entre 1 et 5
      print('Ball number: $ballNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          print('I got clicked');
          changeBallImage();
        },
        child: Image.asset('images/ball$ballNumber.png'),
      ),
    );
  }
}
