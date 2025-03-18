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
        title: Text('Pose une question à la boule magique ! ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 5.0,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Clique sur la boule magique pour obtenir une réponse',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              print('Bien cliqué');
              changeBallImage();
            },
            child: Image.asset('images/ball$ballNumber.png', width: 250, height: 250),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Appuie pour révéler ta destinée !',
          style: TextStyle(fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
