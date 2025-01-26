import 'package:flutter/material.dart';

/** 
 * TODO SECTION
 * ! Edit Image Scales
 */

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyan.shade300,
            Colors.white
          ], // Colors for the gradient
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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1, vertical: screenHeight * 0.1),
            child: const Text(
              'Stronger and healthy future for your children',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'DMSerif',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
