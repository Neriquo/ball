import 'package:flutter/material.dart';
import 'dart:math'; // Pour générer des nombres aléatoires.

void main() => runApp(
  MaterialApp(
    home: BallPage(), // Page principale de l'application.
  ),
);

/// Widget sans état qui définit la structure de la page principale.
class BallPage extends StatelessWidget {
  const BallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Fond de la page en bleu.
      appBar: AppBar(
        title: Text('Ask Me Anything'),
        backgroundColor: Colors.blue[900], // Couleur de l'AppBar en bleu foncé.
      ),
      body: Ball(), // Intègre le widget interactif Ball.
    );
  }
}

/// Widget avec état qui gère l'image de la boule et la réponse textuelle.
class Ball extends StatefulWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1; // Numéro de l'image affichée (entre 1 et 5).

  // Liste des réponses textuelles associées à chaque image.
  final List<String> responses = [
    "Oui",
    "Non",
    "Peut-être",
    "Demande encore",
    "Réessaye"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Bouton cliquable pour changer l'image de la boule.
          TextButton(
            onPressed: () {
              print('I got clicked'); // Message dans la console lors du clic.
              setState(() {
                // Génère un nombre aléatoire entre 1 et 5.
                ballNumber = Random().nextInt(5) + 1;
                print(ballNumber); // Affiche le nouveau numéro dans la console.
              });
            },
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300), // Durée de la transition.
              child: Image.asset(
                'images/ball$ballNumber.png', // Affiche l'image correspondant au numéro.
                key: ValueKey<int>(ballNumber), // Clé unique pour déclencher l'animation.
              ),
            ),
          ),
          SizedBox(height: 20), // Espacement entre l'image et le texte.
          // Affichage de la réponse textuelle correspondant à l'image.
          Text(
            responses[ballNumber - 1],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
