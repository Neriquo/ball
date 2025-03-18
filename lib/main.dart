import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: BallPage(),
  ),
);

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
     appBar: AppBar(
       backgroundColor: Colors.indigo,
       title: Text(
           "Ask me anything",
           style: TextStyle(color: Colors.white70)
       ),
     ),
      body: Ball()
    );
  }
}

class Ball extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BallState();
}

class _BallState extends State<Ball> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("./images/ball1.png"));
  }
}