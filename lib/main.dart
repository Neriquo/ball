import 'dart:math';           // Importation pour la génération de nombres aléatoires
import 'package:flutter/material.dart';  // Importation du framework Flutter UI

// ====================================================
// APPLICATION MAGIC 8 BALL
// ====================================================
// Cette application simule une boule magique "Magic 8 Ball" qui répond aux questions
// avec des prédictions aléatoires, comme le jouet classique. L'utilisateur peut
// toucher la boule pour obtenir une réponse aléatoire à sa question.
// ====================================================

// Point d'entrée de l'application - c'est ici que tout commence
void main() {
  runApp(const MagicBallApp());  // Lance l'application avec le widget racine MagicBallApp
}

// Widget principal de l'application (stateless car ne change pas d'état)
// Définit le thème global et la configuration de l'application
class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});  // Constructeur avec la clé parente

  @override
  Widget build(BuildContext context) {
    // MaterialApp est le widget racine qui fournit de nombreuses fonctionnalités de Material Design
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Supprime la bannière "Debug" en haut à droite
      title: 'Magic 8 Ball',            // Titre de l'application (utilisé par les OS)
      theme: ThemeData(                 // Configuration du thème global
        useMaterial3: true,             // Utilise Material Design 3 (plus récent)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E), // Couleur principale (bleu indigo foncé)
          brightness: Brightness.dark,         // Mode sombre pour toute l'application
        ),
      ),
      home: const BallPage(),           // Écran principal de l'application
    );
  }
}

// Écran principal avec la boule magique (stateful car l'état change)
// Ce widget gère l'interface utilisateur principale et l'interaction
class BallPage extends StatefulWidget {
  const BallPage({super.key});  // Constructeur avec la clé parente

  @override
  // Crée l'état associé à ce widget
  State<BallPage> createState() => _BallPageState();
}

// État associé à BallPage - contient toutes les données qui peuvent changer
class _BallPageState extends State<BallPage> {
  // Variables d'état - ces valeurs peuvent changer et provoquer un re-rendu de l'interface
  int _ballNumber = 1;              // Numéro de l'image (1-5) - détermine quelle image de boule afficher
  String _currentAnswer = "Posez votre question, puis touchez la boule";  // Message initial

  // Liste des réponses possibles retournées par la boule magique
  // Ces réponses sont similaires à celles du vrai jouet Magic 8 Ball
  final List<String> _answers = [
    "C'est certain",              // Réponse positive
    "Sans aucun doute",           // Réponse positive
    "Oui, définitivement",        // Réponse positive
    "Réponse floue, essayez à nouveau",  // Réponse neutre
    "Redemandez plus tard",       // Réponse neutre
    "N'y comptez pas",            // Réponse négative
    "Ma réponse est non",         // Réponse négative
    "Très douteux"                // Réponse négative
  ];

  // Méthode pour générer une réponse aléatoire quand l'utilisateur touche la boule
  // Cette méthode est appelée lors de l'interaction avec la boule
  void _shakeBall() {
    // setState informe Flutter que l'état a changé et qu'il faut reconstruire l'interface
    setState(() {
      // Random().nextInt(5) génère un nombre aléatoire entre 0 et 4, puis on ajoute 1 pour avoir 1-5
      _ballNumber = Random().nextInt(5) + 1;

      // Sélectionne une réponse aléatoire dans la liste des réponses possibles
      _currentAnswer = _answers[Random().nextInt(_answers.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold fournit la structure de base d'une page Material Design
    return Scaffold(
      // Barre d'application en haut de l'écran
      appBar: AppBar(
        title: const Text('Magic 8 Ball'),  // Titre affiché dans la barre
        backgroundColor: const Color(0xFF1A237E),  // Couleur de fond de la barre (bleu foncé)
      ),

      // Corps principal de l'application avec un fond dégradé
      body: Container(
        // Décoration pour créer un fond dégradé du haut vers le bas
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,    // Le dégradé commence en haut
            end: Alignment.bottomCenter,   // Et se termine en bas
            colors: [
              Color(0xFF1A237E),           // Bleu indigo foncé en haut
              Color(0xFF3949AB),           // Bleu indigo plus clair en bas
            ],
          ),
        ),

        // Disposition en colonne pour organiser les widgets verticalement
        child: Column(
          children: [
            const SizedBox(height: 20),    // Espace de 20px en haut

            // Instructions textuelles pour l'utilisateur
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),  // Marge horizontale de 30px
              child: Text(
                'Pensez à une question, puis touchez la boule magique',
                textAlign: TextAlign.center,    // Texte centré
                style: TextStyle(
                  color: Colors.white,          // Texte blanc
                  fontSize: 16,                 // Taille de police de 16px
                ),
              ),
            ),

            // Zone extensible contenant la boule magique (prend tout l'espace disponible)
            Expanded(
              // GestureDetector détecte les interactions tactiles sur la boule
              child: GestureDetector(
                onTap: _shakeBall,  // Appelle _shakeBall() quand l'utilisateur touche la boule

                // Centre la boule dans l'espace disponible
                child: Center(
                  // Conteneur pour la boule avec ombre portée
                  child: Container(
                    width: 200,     // Largeur fixe de 200px
                    height: 200,    // Hauteur fixe de 200px

                    // Décoration pour l'ombre portée (effet 3D)
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,   // Forme circulaire
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),  // Ombre noire semi-transparente
                          blurRadius: 15,                        // Flou de 15px
                          offset: const Offset(0, 5),            // Décalage de l'ombre (effet 3D)
                        ),
                      ],
                    ),

                    // Image de la boule magique qui change selon _ballNumber
                    child: Image.asset(
                      'images/ball$_ballNumber.png',   // Utilise le numéro de boule actuel
                      fit: BoxFit.contain,           // Ajuste l'image pour qu'elle tienne dans le conteneur
                    ),
                  ),
                ),
              ),
            ),

            // Conteneur pour afficher la réponse actuelle
            Container(
              margin: const EdgeInsets.all(20),    // Marge externe de 20px
              padding: const EdgeInsets.all(15),   // Marge interne de 15px

              // Décoration du conteneur de réponse (effet "glassmorphism" léger)
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),  // Blanc semi-transparent
                borderRadius: BorderRadius.circular(10),  // Coins arrondis de 10px
              ),

              // Texte de la réponse actuelle
              child: Text(
                _currentAnswer,              // Texte de réponse dynamique
                textAlign: TextAlign.center, // Centré horizontalement
                style: const TextStyle(
                  color: Colors.white,       // Texte blanc
                  fontSize: 18,              // Taille de police de 18px
                  fontWeight: FontWeight.w500,  // Épaisseur de police moyenne
                ),
              ),
            ),

            // Bouton en bas pour générer une nouvelle réponse
            Padding(
              padding: const EdgeInsets.only(bottom: 20),  // Marge inférieure de 20px

              // Bouton d'action surélevé (style Material)
              child: ElevatedButton(
                onPressed: _shakeBall,  // Même fonction que pour la boule

                // Style personnalisé pour le bouton
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),  // Fond blanc semi-transparent
                  foregroundColor: Colors.white,                   // Texte blanc
                ),

                // Texte du bouton
                child: const Text('Nouvelle réponse'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
