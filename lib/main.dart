import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Montserrat',
      ),
      home: BallPage(),
    ),
  );
}

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade800,
        title: Text(
          'BOULE MAGIQUE 8',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.amber.shade200,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade800, Colors.indigo.shade900, Colors.black],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Ball(),
        ),
      ),
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> with SingleTickerProviderStateMixin {
  int ballNumber = 1;
  bool isPressed = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateBallNumber() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1;
      isPressed = true;
    });

    _controller.reset();
    _controller.forward();

    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          isPressed = false;
        });
      }
    });

    print('Cliqué !');
    print('Numéro : $ballNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.indigo.shade700.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              'Pensez à une question et touchez la boule',
              style: TextStyle(
                color: Colors.amber.shade100,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 60.0),
          GestureDetector(
            onTap: updateBallNumber,
            child: RotationTransition(
              turns: _animation,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: isPressed
                    ? (Matrix4.identity()..scale(0.9))
                    : Matrix4.identity(),
                child: Container(
                  width: 240.0,
                  height: 240.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset('images/ball$ballNumber.png'),
                ),
              ),
            ),
          ),
          SizedBox(height: 60.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade800.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.amber.shade200.withOpacity(0.3), width: 1),
            ),
            child: Text(
              'Le destin attend votre question !',
              style: TextStyle(
                color: Colors.amber.shade200,
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}