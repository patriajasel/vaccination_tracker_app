/**
 * TODO 
 *  
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_tracker_app/services/firebase_auth_services.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

class ChangeEmailPage extends ConsumerStatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  ConsumerState<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends ConsumerState<ChangeEmailPage> {
  final newEmail = TextEditingController();
  final confirmPassword = TextEditingController();

  bool obscureTextConfirm = true;

  bool newEmailValidator = true;
  bool confirmPasswordValidator = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.black), // Back button
          onPressed: () {
            Navigator.pop(context); // Action to go back
          },
        ),
      ),
      extendBodyBehindAppBar: true,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Image.asset(
              'lib/assets/logos/change_email_logo.png',
              scale: 2.5,
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                'To proceed updating your email address, please provide a valid email and enter current password of your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, fontFamily: "DMSerif", letterSpacing: 2),
              ),
            ),
            SizedBox(height: screenHeight * 0.1),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(
                  newEmail,
                  "New Email",
                  false,
                  true,
                  false,
                  false,
                  newEmailValidator,
                  prefixIcon: const Icon(Icons.alternate_email),
                )),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(
                    confirmPassword,
                    "Confirm your Password",
                    false,
                    true,
                    obscureTextConfirm,
                    false,
                    confirmPasswordValidator,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: obscureTextConfirm == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    function: showConfirmPass)),

            SizedBox(height: screenHeight * 0.05),

            // This is for verifying the mobile number
            ElevatedButton(
              onPressed: () async {
                bool isValidated = await validateTextFields();
                if (!isValidated) {
                  Fluttertoast.showToast(
                      msg: "Required Fields are empty",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 14.0);
                } else {
                  String email = FirebaseAuth.instance.currentUser!.email!;

                  await FirebaseAuthServices().updateUserEmail(
                      email,
                      newEmail.text,
                      confirmPassword.text,
                      FirebaseAuth.instance.currentUser!);

                  await FirebaseAuth.instance.signOut();

                  if (context.mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.5, screenHeight * 0.06),
                  backgroundColor: Colors.cyan.shade300,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'Update Email',
                style: TextStyle(
                    fontSize: 18,
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
    if (newEmail.text.isEmpty || confirmPassword.text.isEmpty) {
      if (newEmail.text.isEmpty) {
        setState(() {
          newEmailValidator = false;
        });
      }

      if (confirmPassword.text.isEmpty) {
        setState(() {
          confirmPasswordValidator = false;
        });
      }

      return false;
    } else {
      newEmailValidator = true;
      confirmPasswordValidator = true;

      return true;
    }
  }

  void showConfirmPass() {
    setState(() {
      obscureTextConfirm = !obscureTextConfirm;
    });
  }
}
