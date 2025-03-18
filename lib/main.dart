import 'dart:math';

import 'package:flutter/material.dart';

//Point d'entrée de l'application
void main() => runApp(
      MaterialApp(
        home: BallPage(),
      ),
    );

//Class principal de la page, gère la structure de l'application
//hérite de StatelessWidget car son contenu ne change pas
class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text(
            'Ask Me Anything',
            style: TextStyle(color: Colors.white),),
          backgroundColor: const Color(0xFF00008B),
        ),
        body: Ball(),
    );
  }
}

//Class qui gère l'image de la boule
class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

//Class d'état de la boule, hérite de State
//permet de changer l'état de la boule
//c'est la ou on change l'image de la boule
class _BallState extends State<Ball> {
  int ballNumber = 1;

  // fonction qui change l'image de la boule
  // à chaque clic et de facon aléatoire
  void changeBall() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: TextButton(
          onPressed: () {
            changeBall();
          },
          child: Image.asset(
            'images/ball$ballNumber.png',
          ),
        ),
      ),
    );
  }
}