import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';

void main() => runApp(MaterialApp(
  home: BallPage(),
));

class BallPage extends StatefulWidget {
  @override
  _BallPageState createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> with SingleTickerProviderStateMixin {
  int ballNumber = 1;
  int positiveCount = 0;
  int negativeCount = 0;
  List<String> positiveResponses = [
    "Oui !", "Certainement !", "Bonne idée !", "Vas-y !", "Chanceux !"
  ];
  List<String> negativeResponses = [
    "Non...", "Pas sûr", "Mauvaise idée", "Évite ça", "Pas aujourd'hui"
  ];
  String message = "Pose ta question...";

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi * 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void spinRoulette() {
    setState(() {
      _controller.forward(from: 0);
      ballNumber = Random().nextInt(5) + 1;
      bool isPositive = Random().nextBool();
      if (isPositive) {
        message = positiveResponses[Random().nextInt(positiveResponses.length)];
        positiveCount++;
      } else {
        message = negativeResponses[Random().nextInt(negativeResponses.length)];
        negativeCount++;
      }
    });
  }

  String getKarmaAdvice() {
    if (negativeCount > positiveCount + 2) {
      return "Conseil : Change ton état d'esprit ! Reste positif.";
    } else if (positiveCount > negativeCount + 2) {
      return "Bravo ! Ton karma est excellent aujourd'hui !";
    }
    return "Ton karma est équilibré.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Roulette des Destins"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: spinRoulette,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: Image.asset('images/ball$ballNumber.png'),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            getKarmaAdvice(),
            style: TextStyle(fontSize: 18, color: Colors.yellowAccent),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}