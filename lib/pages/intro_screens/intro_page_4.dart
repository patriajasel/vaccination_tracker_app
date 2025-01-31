import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.yellow.shade50,
            radius: 90,
            child: Icon(
              Icons.money_off,
              size: 90,
              color: Colors.cyan.shade300,
            ),
          ),
          SizedBox(height: screenHeight * 0.1),
          Text('Free To Use',
              textAlign: TextAlign.center, style: TextStyles().introTitle),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              'The app is 100% free with no hidden charges or in-app purchases. It will only use minimal internet data for a smooth experience!',
              textAlign: TextAlign.center,
              style: TextStyles().introInfo,
            ),
          )
        ],
      ),
    );
  }
}
