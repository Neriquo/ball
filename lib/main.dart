import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MagicBallApp());
}

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BallPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Ask Me Anything'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.black,
            ],
          ),
        ),
        child: const Center(
          child: Ball(),
        ),
      ),
    );
  }
}

class Ball extends StatefulWidget {
  const Ball({super.key});

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;
  bool isAnimating = false;

  void changeBall() {
    setState(() {
      isAnimating = true;
      ballNumber = Random().nextInt(5) + 1;
    });

    Future.delayed(500.ms, () {
      setState(() {
        isAnimating = false;
      });
    });

    print('I got clicked');
    print('ballNumber: $ballNumber');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeBall,
      child: AnimatedContainer(
        duration: 500.ms,
        curve: Curves.easeInOut,
        transform: isAnimating ? Matrix4.rotationZ(pi) : Matrix4.rotationZ(0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade800,
                Colors.blue.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Image.asset(
            'images/ball$ballNumber.png',
            fit: BoxFit.cover,
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat()).shimmer(
        duration: 1000.ms,
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }
}