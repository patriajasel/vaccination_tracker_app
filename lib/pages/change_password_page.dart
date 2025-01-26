/**
 * TODO 
 *  
 * ! Create the page design
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_tracker_app/services/firebase_auth_services.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

/**
 * TODO SECTION
 * 
 * 
 */

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  bool obscureTextOldPass = true;
  bool obscureTextNewPass = true;
  bool obscureTextConfirmNewPass = true;

  bool oldPassValidator = true;
  bool newPassValidator = true;
  bool confirmNewPassValidator = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade300, Colors.white],
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
              'lib/assets/logos/change_password_logo.png',
              scale: 2.5,
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                'To update your password, please provide the following:',
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
                    oldPassword,
                    "Old Password",
                    false,
                    true,
                    obscureTextOldPass,
                    false,
                    oldPassValidator,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: obscureTextOldPass == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    function: showOldPassword)),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(
                    newPassword,
                    "New Password",
                    false,
                    true,
                    obscureTextNewPass,
                    false,
                    newPassValidator,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: obscureTextNewPass == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    function: showNewPassword)),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(
                    confirmNewPassword,
                    "Confirm New Password",
                    false,
                    true,
                    obscureTextConfirmNewPass,
                    false,
                    confirmNewPassValidator,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: obscureTextConfirmNewPass == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    function: showConfirmNewPass)),

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
                  if (newPassword.text == confirmNewPassword.text) {
                    String email = FirebaseAuth.instance.currentUser!.email!;

                    await FirebaseAuthServices().updateUserPassword(
                        email,
                        oldPassword.text,
                        confirmNewPassword.text,
                        FirebaseAuth.instance.currentUser!);

                    await FirebaseAuth.instance.signOut();

                    if (context.mounted) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
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
                'Update Password',
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
    if (oldPassword.text.isEmpty ||
        newPassword.text.isEmpty ||
        confirmNewPassword.text.isEmpty) {
      if (oldPassword.text.isEmpty) {
        setState(() {
          oldPassValidator = false;
        });
      }

      if (newPassword.text.isEmpty) {
        setState(() {
          newPassValidator = false;
        });
      }

      if (confirmNewPassword.text.isEmpty) {
        setState(() {
          confirmNewPassValidator = false;
        });
      }

      return false;
    } else {
      oldPassValidator = true;
      newPassValidator = true;
      confirmNewPassValidator = true;

      return true;
    }
  }

  void showOldPassword() {
    setState(() {
      obscureTextOldPass = !obscureTextOldPass;
    });
  }

  void showNewPassword() {
    setState(() {
      obscureTextNewPass = !obscureTextNewPass;
    });
  }

  void showConfirmNewPass() {
    setState(() {
      obscureTextConfirmNewPass = !obscureTextConfirmNewPass;
    });
  }
}
