//Rakotondrabe Philippe STS1 DEV

import 'package:flutter/material.dart';
import 'dart:math'; //Importation de la biliotheque permettant de générer des nombres aléatoires (pour les balles)

void main() => runApp(
      MaterialApp(
        home:
            BallPage(), //J'ai remplacé null par BallPage qui générère le widget dynamique(celui ou les images changent aléatoirement)
      ),
    );

class BallPage extends StatefulWidget {
  //Widget dynamique ici
  @override
  _BallPageState createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  int ballNumber = 1; // Initialisé à 1 pour correspondre aux images, car 0

  void changeBall() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1; // Génère un nombre entre 1 et 5
      print('ballNumber : $ballNumber'); // Affiche le numéro dans la console
    });
  }

  Color getBackgroundColor() {
    //Ici j'ai fait en sorte qu'en fonction de la réponse le fond change de couleur, si c'est un no soit à 2 il est en rouge etc
    if (ballNumber == 1 || ballNumber == 4) {
      return Colors
          .green; //Ici 1 et 4 ont comme réponse un succès, donc background en vert
    } else if (ballNumber == 5 || ballNumber == 3) {
      return Colors
          .yellow; //5 et 3 sont des réponses indéfinies, donc background en jaune
    } else {
      return Colors
          .red; //Ici le reste soit 2, la réponse est no, donc background en rouge
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          getBackgroundColor(), //Le fond de couleur dynamique qui change en fonction de l'etat de la boule, ou il appelle juste la méthode
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Ask Me Anything',
          style: TextStyle(
              color: Colors
                  .white), //Ajout du texte en blanc pour correspondre à l'exercice
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: changeBall, //Change l'image et la couleur au clic
          child: Image.asset(
              'images/ball$ballNumber.png'), //Utilisation de l’interpolation pour changer dynamiquement les images
        ),
      ),
    );
  }
}
