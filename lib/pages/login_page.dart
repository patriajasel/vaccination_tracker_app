import 'package:flutter/material.dart';
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

          SizedBox(height: screenHeight * 0.025),

          // This is for the catch phrase of the application
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: const Text(
              'Vaccination Tracker',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Mali",
                  letterSpacing: 2),
            ),
          ),

          SizedBox(height: screenHeight * 0.025),

          Image.asset(
            'lib/assets/logos/app_logo.png',
            height: screenHeight * 0.25,
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                backgroundColor: Colors.pink.shade300,
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
