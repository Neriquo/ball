import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MagicBallApp());
}

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BallPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Ask Me Anything'),
      ),
      body: const Ball(), // Step 3 : Use the Stateful widget instead of Container
    );
  }
}

class Ball extends StatefulWidget {
  const Ball({super.key});

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1; // Step 5 : variable to hold the current ball number

  void changeBall() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1; // Step 6 : Random number from 1 to 5
    });
    print('I got clicked');
    print('ballNumber: $ballNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: changeBall,
        child: Image.asset('images/ball$ballNumber.png'), // Step 6 : String interpolation
      ),
    );
  }
}
