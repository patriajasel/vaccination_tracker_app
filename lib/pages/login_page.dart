import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/app_navigation.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailOrNumber = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
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
            SizedBox(height: screenHeight * 0.025),

            Image.asset(
              'lib/assets/logos/VacCalendar_Logo.png',
              scale: 1.5,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                'VacCalendar App',
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

            SizedBox(height: screenHeight * 0.02),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(
                  emailOrNumber,
                  "Email or Mobile",
                  false,
                  true,
                  false,
                  prefixIcon: const Icon(Icons.person),
                )),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(
                  password,
                  "Password",
                  false,
                  true,
                  true,
                  prefixIcon: const Icon(Icons.lock),
                )),

            SizedBox(height: screenHeight * 0.02),

            // This is for the Login and Create account Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const AppNavigation()));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'Log In',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "DMSerif",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
