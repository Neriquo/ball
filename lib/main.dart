import 'dart:math'; // Importation de la bibliothèque pour générer des nombres aléatoires
import 'package:flutter/material.dart'; // Importation des widgets de Flutter

// Point d'entrée principal de l'application
void main() {
  runApp(const MagicBallApp()); // Exécution de l'application
}

// Définition de l'application principale, un widget sans état
class MagicBallApp extends StatelessWidget {
  const MagicBallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Désactive le badge "Debug" dans l'interface
      home: const BallPage(), // Définit la page d'accueil comme BallPage
    );
  }
}

class BallPage extends StatelessWidget {
  const BallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Couleur d'arrière-plan de l'AppBar
        title: const Text('Demande-moi quelque chose'), // Texte dans l'AppBar
      ),
      body: Stack(
        // Utilisation de Stack pour empiler les widgets
        children: [
          Row(
            // Construction du drapeau français avec 3 colonnes
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue, // Bande bleue
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white, // Bande blanche
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.red, // Bande rouge
                ),
              ),
            ],
          ),
          const Center(
            child: Ball(), // Widget de la balle placé au centre
          ),
        ],
      ),
    );
  }
}

// Définition d'un widget avec état (Stateful Widget)
class Ball extends StatefulWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  State<Ball> createState() => _BallState(); // Création de l'état pour ce widget
}

// Classe gérant l'état du widget "Ball"
class _BallState extends State<Ball> {
  int ballNumber = 1; // Variable pour stocker le numéro d'image de la balle (par défaut 1)

  // Fonction pour mettre à jour le numéro d'image aléatoirement
  void updateBall() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1; // Génère un nombre entre 1 et 5
    });
    print('Numéro de la balle : $ballNumber'); // Affiche le numéro dans la console
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Centre le contenu à l'écran
      child: TextButton(
        // Widget bouton cliquable contenant l'image
        onPressed: () {
          updateBall(); // Met à jour la balle aléatoirement
          print('J’ai été cliqué'); // Affiche un message dans la console
        },
        child: Image.asset('images/ball$ballNumber.png'), // Charge l'image correspondant au numéro
      ),
    );
  }
}
