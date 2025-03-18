import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';

void main() => runApp(
  MaterialApp(
    home: BallPage(),
  ),
);

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text('Ask Me Anything'),
      ),
      body: Ball(),
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      // Create a centered column
      child: Column(
        children: [
          // Add a text to the column and show it
          Text(
              "Click the question mark :)",
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
          // Add button that shows an Icon to the column and show it
          TextButton(
            // When button clicked, it shows an alert with the information about the game
            onPressed: () {
              setState(() {
                Alert(
                  context: context,
                  title: 'Informations about the game',
                  desc: 'Name : 8 Ball Oracle\n'
                      'Goal : Think of a question and click the tha ball, it will give you an anwser.\n'
                      'Have fun :)',
                ).show();
              });
            },
            child: Icon(Icons.question_mark, size: 100,),
          ),
          // Add button that shows an image to the column and show it
          TextButton(
            // When clicked, it shows a random image of the 8 ball oracle game
            onPressed: () {
              setState(() {
                ballNumber = Random().nextInt(5) + 1;
              });
            },
            child: Image.asset('images/ball$ballNumber.png'),
          ),
        ],
      )
    );
  }
}
