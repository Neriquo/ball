import 'package:flutter/material.dart'; // Importe les widgets de base de Flutter
import 'dart:math'; // Importe la bibliothèque pour générer des nombres aléatoires

// Point d'entrée de l'application
void main() {
  runApp(const MagicBallApp()); // Lance l'application en utilisant le widget racine
}

// Widget racine de l'application (sans état car ne change pas)
class MagicBallApp extends StatelessWidget {
  const MagicBallApp({Key? key}) : super(key: key); // Constructeur avec paramètre optionnel key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Retire la bannière "Debug" en haut à droite
      title: 'Boule Magique', // Titre de l'application (visible dans le gestionnaire de tâches)
      theme: ThemeData(
        primarySwatch: Colors.blue, // Définit la couleur principale de l'application
      ),
      home: const MagicBallPage(), // Définit la page d'accueil de l'application
    );
  }
}

// Widget de la page principale (avec état car contient des données qui changent)
class MagicBallPage extends StatefulWidget {
  const MagicBallPage({Key? key}) : super(key: key);

  @override
  State<MagicBallPage> createState() => _MagicBallPageState(); // Crée l'état associé à ce widget
}

// Classe d'état pour la page principale
class _MagicBallPageState extends State<MagicBallPage> {
  int _ballNumber = 1; // Indice de la réponse actuelle (commence à 1)

  // Liste de réponses possibles en français
  final List<String> _responses = [
    "Oui",
    "Non",
    "Peut-être",
    "Demande encore",
    "Très probable",
    "Pas maintenant",
    "Sans aucun doute",
    "N'y compte pas",
    "Essaie plus tard",
  ];

  // Méthode pour changer aléatoirement la réponse de la boule
  void _changeBall() {
    setState(() {
      // Génère un nouveau numéro aléatoire entre 0 et 8 (pour les 9 réponses)
      // setState déclenche un rebuild du widget pour afficher les changements
      _ballNumber = Random().nextInt(_responses.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold fournit la structure de base d'une page (appbar, body, etc.)
    return Scaffold(
      backgroundColor: Colors.blue.shade600, // Couleur de fond de l'écran
      appBar: AppBar(
        title: const Text('Boule Magique 🔮'), // Titre de la barre d'application avec emoji
        centerTitle: true, // Centre le titre dans la barre
        backgroundColor: Colors.blue.shade900, // Couleur de fond de la barre plus foncée
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centre verticalement les éléments
          children: [
            // Instructions pour l'utilisateur
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20), // Marge horizontale
              child: Text(
                'Touchez la boule pour découvrir votre avenir...',
                textAlign: TextAlign.center, // Centre le texte
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30), // Espace vertical de 30 pixels

            // Boule magique interactive (détecte les touchers)
            GestureDetector(
              onTap: _changeBall, // Appelle _changeBall quand l'utilisateur touche la boule
              child: _buildBall(), // Utilise la méthode _buildBall pour créer l'apparence de la boule
            ),

            const SizedBox(height: 30), // Autre espace vertical

            // Affichage de la réponse dans un conteneur stylisé
            Container(
              padding: const EdgeInsets.all(16), // Rembourrage interne
              decoration: BoxDecoration(
                color: Colors.blue.shade800, // Fond bleu foncé
                borderRadius: BorderRadius.circular(10), // Coins arrondis
              ),
              child: Text(
                _responses[_ballNumber], // Affiche la réponse actuelle
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold, // Texte en gras
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode qui construit visuellement la boule magique
  Widget _buildBall() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Forme circulaire pour la boule
        color: Colors.black, // Couleur noire pour la boule
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5), // Ombre semi-transparente
            blurRadius: 10, // Flou de l'ombre
            spreadRadius: 2, // Étendue de l'ombre
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // Cercle bleu au centre
            color: Colors.blue,
          ),
          child: const Center(
            child: Text(
              '8', // Le chiffre "8" caractéristique de la boule magique
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}