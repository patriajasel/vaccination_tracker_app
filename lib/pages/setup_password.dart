import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_tracker_app/pages/login_page.dart';
import 'package:vaccination_tracker_app/pages/privacy_policy_page.dart';
import 'package:vaccination_tracker_app/pages/terms_and_conditions.dart';
import 'package:vaccination_tracker_app/services/firebase_auth_services.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

/**
 * TODO SECTION
 * 
 * 
 */

class SetupPassword extends ConsumerStatefulWidget {
  final String email;
  const SetupPassword({super.key, required this.email});

  @override
  ConsumerState<SetupPassword> createState() => _SetupPasswordState();
}

class _SetupPasswordState extends ConsumerState<SetupPassword> {
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool isTermsAccepted = false;

  bool obscureTextPass = true;
  bool obscureTextConfirm = true;

  @override
  void dispose() {
    super.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Image.asset(
              'lib/assets/logos/otp_logo.png',
              scale: 2.5,
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Text(
                'Set up a password to you account.',
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
                child: GenerateWidget().createTextField(password, "Password",
                    false, true, obscureTextPass, false, true,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: obscureTextPass == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    function: showPassword)),

            Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    right: screenWidth * 0.1,
                    left: screenWidth * 0.1),
                child: GenerateWidget().createTextField(
                    confirmPassword,
                    "Confirm Password",
                    false,
                    true,
                    obscureTextConfirm,
                    false,
                    true,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: obscureTextConfirm == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    function: showConfirmPass)),

            SizedBox(height: screenHeight * 0.05),

            Center(
              child: CheckboxListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.125),
                  isError: !isTermsAccepted,
                  activeColor: Colors.cyan,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Mali",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: "I agree to the ",
                        ),
                        TextSpan(
                          text: "Terms of Use",
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsAndConditionsPage()));
                            },
                        ),
                        const TextSpan(
                          text: " & ",
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicyPage()));
                            },
                        ),
                      ],
                    ),
                  ),
                  value: isTermsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      isTermsAccepted = value!;
                    });
                  }),
            ),

            SizedBox(height: screenHeight * 0.05),

            // This is for verifying the mobile number
            ElevatedButton(
              onPressed: () async {
                if (!isTermsAccepted) {
                  Fluttertoast.showToast(
                      msg: "Please accept the Terms of User & Privacy Policy",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 14.0);
                } else {
                  final email = widget.email;

                  if (password.text == confirmPassword.text) {
                    await FirebaseAuthServices().signUpViaEmail(
                        email, confirmPassword.text, ref, context);

                    resetModels();

                    await FirebaseAuth.instance.signOut();

                    Fluttertoast.showToast(
                        msg:
                            "A verification email was sent to your email address.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 14.0);

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Password does not match",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 14.0);
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
                'Finish',
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

  void resetModels() {
    ref.read(rpGuardianInfo).reset();
    ref.read(rpChildInfo).reset();
  }

  void showPassword() {
    setState(() {
      obscureTextPass = !obscureTextPass;
    });
  }

  void showConfirmPass() {
    setState(() {
      obscureTextConfirm = !obscureTextConfirm;
    });
  }
}
