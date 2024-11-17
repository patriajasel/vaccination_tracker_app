import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
        final double screenWidth = MediaQuery.of(context).size.width;


    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.white], // Colors for the gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.yellow.shade50,
            radius: 100,
            child: Icon(
              Icons.alarm,
              size: 100,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: screenHeight * 0.1),
          Text('Reminders',
              textAlign: TextAlign.center, style: TextStyles().introTitle),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              'Get timely reminders for upcoming vaccinations, so you never miss an important date.',
              textAlign: TextAlign.center,
              style: TextStyles().introInfo,
            ),
          )
        ],
      ),
    );
  }
}
