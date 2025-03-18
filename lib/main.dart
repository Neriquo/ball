import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
          style: TextStyle(color: Colors.white),
        ),
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
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      changeBall();
    setState(() {_isLoading = false;});});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
    });
  }

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              _speechToText.isListening
                  ? 'Listening...'
                  : _speechEnabled
                  ? 'Tap the microphone to start listening...'
                  : 'Speech not available',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _wordsSpoken,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Container(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        changeBall();
                      },
                      child: Image.asset(
                        'images/ball$ballNumber.png',
                      ),
                    ),
          ),
          Padding(


            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
              tooltip: 'Listen',
              child: Icon(
                _speechToText.isNotListening
                    ? Icons.mic_off
                    : Icons.mic
              ),
            ),

          ),
        ],
      ),
    );
  }
}