import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/login_page.dart';
import 'package:vaccination_tracker_app/pages/setup_guardian.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logos/VacCalendar_Logo.png',
              scale: 1.5,
            ),
            // This is for the catch phrase of the application
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                'BakunaDo! App',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(0, 2))
                    ],
                    fontWeight: FontWeight.bold,
                    fontFamily: "DMSerif",
                    letterSpacing: 2),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                'VacCalendar is a free, easy-to-use mobile app designed to help parents and caregivers manage their child\'s vaccination schedules. With features like personalized reminders, health education on vaccines, and an offline mode, the app makes staying on top of your baby’s vaccination needs simple and stress-free.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontFamily: "Mali"),
              ),
            ),

            SizedBox(height: screenHeight * 0.05),

            // This is for the Login and Create account Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (route) => const LoginPage()));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.6, screenHeight * 0.05),
                  backgroundColor: Colors.cyan.shade300,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'Log In',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "DMSerif",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (route) =>
                        const SetUpProfileGuardianPage() //SetUpProfileGuardianPage()
                    ));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.6, screenHeight * 0.05),
                  backgroundColor: Colors.cyan.shade300,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Create Account',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "DMSerif",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2)),
            ),
          ],
        ),
      ),
    );
  }
}
