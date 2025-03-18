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
      body: Container(

      ),
    );
  }
}