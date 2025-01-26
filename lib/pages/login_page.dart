import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_tracker_app/pages/app_navigation.dart';
import 'package:vaccination_tracker_app/services/firebase_auth_services.dart';
import 'package:vaccination_tracker_app/services/firebase_firestore_services.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

/**
 * TODO SECTION
 * 
 * ! Redirect to start page is back button is clicked
 */

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool emailValidator = true;
  bool passwordValidator = true;

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
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
                  email,
                  "Email Address",
                  false,
                  true,
                  false,
                  false,
                  emailValidator,
                  prefixIcon: const Icon(Icons.person),
                )),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(password, "Password",
                    false, true, obscureText, false, passwordValidator,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: obscureText == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    function: showPassword)),

            SizedBox(height: screenHeight * 0.02),

            // This is for the Login and Create account Buttons
            ElevatedButton(
              onPressed: () async {
                bool validate = await validateTextFields();

                if (validate) {
                  if (context.mounted) {
                    await FirebaseAuthServices()
                        .loginViaEmail(email.text, password.text, context);

                    String userID = FirebaseAuth.instance.currentUser!.uid;

                    bool checkUser =
                        await FirebaseAuthServices().checkUserRole(userID);

                    if (checkUser) {
                      await FirebaseFirestoreServices()
                          .obtainUserData(userID, ref);
                      if (context.mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AppNavigation()));
                      }
                    } else {
                      await FirebaseAuth.instance.signOut();

                      Fluttertoast.showToast(
                          msg: "Invalid email or password",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    }
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "Invalid email or password",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 14.0);
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                  backgroundColor: Colors.cyan.shade300,
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

  Future<bool> validateTextFields() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      if (email.text.isEmpty) {
        setState(() {
          emailValidator = false;
        });
      }

      if (password.text.isEmpty) {
        setState(() {
          passwordValidator = false;
        });
      }

      return false;
    } else {
      emailValidator = true;
      passwordValidator = true;
      return true;
    }
  }

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
