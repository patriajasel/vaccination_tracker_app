import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
              Icons.vaccines,
              size: 90,
              color: Colors.cyan.shade300,
            ),
          ),
          SizedBox(height: screenHeight * 0.1),
          Text('Facts About Vaccines',
              textAlign: TextAlign.center, style: TextStyles().introTitle),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              'Learn about the importance of vaccines, common side effects, and answers to frequently asked questions–all within the app.',
              textAlign: TextAlign.center,
              style: TextStyles().introInfo,
            ),
          )
        ],
      ),
    );
  }
}
