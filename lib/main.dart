// Importation des packages Flutter pour l'interface et Math pour les nombres aléatoires
import 'package:flutter/material.dart';
import 'dart:math';

// Point d'entrée de l'application qui initialise le widget racine MaterialApp
void main() => runApp(
      MaterialApp(
        home: BallPage(),
      ),
    );

// Page principale avec un thème bleu et une barre de navigation
class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Ask Me Anything'),
      ),
      body: Ball(),
    );
  }
}

// Widget de la boule magique qui peut changer d'état
class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

// Gestion de l'état de la boule magique et de son interaction
class _BallState extends State<Ball> {
  // Variable qui stocke le numéro de l'image actuelle (de 1 à 5)
  int ballNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        // Fonction exécutée quand l'utilisateur touche la boule
        onPressed: () {
          setState(() {
            // Génère un nombre aléatoire entre 1 et 5 pour changer l'image
            ballNumber = Random().nextInt(5) + 1;
            print('Ball number: $ballNumber');
          });
        },
        // Charge et affiche l'image de la boule correspondant au numéro actuel
        child: Image.asset('images/ball$ballNumber.png'),
      ),
    );
  }
}
