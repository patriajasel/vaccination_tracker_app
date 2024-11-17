import 'package:flutter/material.dart';

class MyChildPage extends StatelessWidget {
  const MyChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade700,
            Colors.white
          ], // Colors for the gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Text('My Child Page'),
      ),
    );
  }
}