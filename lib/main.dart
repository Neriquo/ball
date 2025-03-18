// Import necessary packages
import 'dart:math'; // For generating random numbers
import 'package:flutter/material.dart'; // Flutter material design package

// Main function - entry point of the application
void main() => runApp(
      MaterialApp(
        home: BallPage(), // Set the home page to BallPage
      ),
    );

// StatelessWidget that serves as the main page of the app
class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color to blue
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900, // Darker blue for app bar
        title: Text(
          'Ask Me Anything',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
      ),
      body: Ball(), // Display the Ball widget in the body
    );
  }
}

// StatefulWidget for the magic 8-ball that can change state
class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

// State class for the Ball widget
class _BallState extends State<Ball> {
  int ballNumber = 1; // Initial ball image number

  // Function to change the ball image randomly
  void changeBallFace() {
    setState(() {
      // Generate a random number between 1 and 5
      ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          changeBallFace(); // Call function to change the ball image
        },
        child: Image.asset(
          'images/ball$ballNumber.png', // Display the ball image based on ballNumber
        ),
      ),
    );
  }
}
