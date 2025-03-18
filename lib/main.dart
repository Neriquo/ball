import 'package:flutter/material.dart';
import 'dart:math'; // Importation de la bibliothèque pour générer des nombres aléatoires.

void main() => runApp(
  MaterialApp(
    home: BallPage(), // Définition de la page d'accueil de l'application.
  ),
);

/// Widget sans état qui définit la structure principale de l'application.
class BallPage extends StatelessWidget {
  const BallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Couleur de fond de la page en bleu.
      appBar: AppBar(
        title: Text('Ask Me Anything'), // Titre de la barre d'application.
        backgroundColor: Colors.blue[900], // Couleur de l'AppBar en bleu foncé.
      ),
      body: Ball(), // Affichage du widget Ball qui contient l'image interactive.
    );
  }
}

/// Widget avec état qui gère l'affichage et l'interaction de la boule magique.
class Ball extends StatefulWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1; // Numéro de l'image affichée (entre 1 et 5).

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          print('I got clicked'); // Affiche un message dans la console lors du clic.

          setState(() {
            ballNumber = Random().nextInt(5) + 1; // Génère un nombre entre 1 et 5.
            print(ballNumber); // Affiche le numéro généré dans la console.
          });
        },
        child: Image.asset('images/ball$ballNumber.png'), // Affiche l'image correspondante.
      ),
    );
  }
}
