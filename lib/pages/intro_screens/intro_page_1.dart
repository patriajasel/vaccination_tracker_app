import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.white], // Colors for the gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'lib/assets/logos/VacCalendar_Logo.png',
            scale: 1.5,
          ),
          const Text(
            'Stronger and healthy future for your children',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'DMSerif',
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
