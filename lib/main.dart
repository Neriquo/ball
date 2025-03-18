import 'package:flutter/material.dart'; // Importation du package Flutter pour les widgets UI
import 'dart:math'; // Importation de la bibliothèque Math pour générer des nombres aléatoires

// Point d'entrée de l'application
void main() => runApp(
      MaterialApp(
        home: BallPage(), // Définit BallPage comme écran principal
      ),
    );

// Widget statique qui définit la structure principale de l'écran
class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Couleur de fond de l'écran
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Couleur de la barre d'application
        title: Text(
          'Ask Me Anything', // Titre de l'application
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Ball(), // Intégration du widget Ball dans le corps de l'écran
    );
  }
}

// Widget dynamique qui gère l'état de la boule magique
class Ball extends StatefulWidget {
  @override
  State<Ball> createState() => _BallState(); // Crée l'état associé au widget Ball
}

// Classe qui gère l'état et la logique du widget Ball
class _BallState extends State<Ball> {
  int ballNumber = 1; // Variable d'état qui détermine quelle image de boule afficher

  // Fonction pour changer aléatoirement l'image de la boule
  void changeBall() {
    setState(() {
      // Génère un nombre aléatoire entre 1 et 5 pour sélectionner une image
      ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          changeBall(); // Appelle la fonction pour changer l'image quand on clique
          print('I got clicked'); // Message de débogage dans la console
          print('Ball number: $ballNumber'); // Affiche le numéro de l'image sélectionnée grâce à $ballNumber
        },
        // Affiche l'image correspondant au numéro actuel grâce à $ballNumber
        child: Image.asset('images/ball$ballNumber.png'),
      ),
    );
  }
}
