import 'package:flutter/material.dart';
import 'dart:math'; // Import de la bibliothèque dart:math pour générer des nombres aléatoires

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BallPage(),
    );
  }
}

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          'Ask Me Anything',
          style: TextStyle(color: Colors.white),
        ),
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
  int ballNumber =
      1; // Initialisation à 1, car les balles commencent à ball1.png

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            ballNumber =
                Random().nextInt(5) + 1; // génère un nombre entre 1 et 5
          });
          print(
              'Ball Number: $ballNumber'); // Affiche le numéro de la balle dans la console
        },
        child: Image.asset('images/ball$ballNumber.png'),
      ),
    );
  }
}
