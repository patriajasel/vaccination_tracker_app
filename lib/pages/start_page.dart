import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/login_page.dart';
import 'package:vaccination_tracker_app/pages/setup_child.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.025),
          // This is for displaying the logo of BSU and College of Nursing
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/logos/bsu_logo.png',
                height: screenHeight * 0.15,
                width: screenWidth * 0.15,
              ),
              const SizedBox(width: 10),
              Image.asset(
                'lib/assets/logos/bsu_con_logo.png',
                height: screenHeight * 0.15,
                width: screenWidth * 0.15,
              )
            ],
          ),

          SizedBox(height: screenHeight * 0.05),

          // This is for the catch phrase of the application
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: const Text(
              'Maging alerto sa bakuna ni baby mo! chareng!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: "DMSerif",
                  letterSpacing: 2),
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: const Text(
              'Isang application kung saan makekeme mo ang vaccine ni baby.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontFamily: "Mali"),
            ),
          ),

          SizedBox(height: screenHeight * 0.1),

          // This is for the Login and Create account Buttons
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (route) => const LoginPage()));
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.8, screenHeight * 0.075),
                backgroundColor: Colors.blue.shade900,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text(
              'Log In',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "DMSerif",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (route) => const SetUpProfileChildPage()));
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.8, screenHeight * 0.075),
                backgroundColor: Colors.pink.shade300,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text('Create Account',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "DMSerif",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2)),
          ),

          SizedBox(height: screenHeight * 0.06),

          // This is for the settings
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.transparent,
                    elevation: 0),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      size: 35,
                    ),
                    Text('Settings',
                        style: TextStyle(
                            fontSize: 26, fontFamily: "Mali", letterSpacing: 2))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
