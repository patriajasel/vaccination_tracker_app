import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/services/firebase_auth_services.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

/**
 * TODO SECTION
 * 
 * 
 */

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final email = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
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
                        'lib/assets/logos/otp_logo.png',
                        scale: 2.5,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: const Text(
                          'A password reset email will be sent in the email address that you\'ve entered.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "DMSerif",
                              letterSpacing: 2),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
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
                          true,
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        onPressed: () async {
                          ref.read(isLoadingProvider.notifier).state = true;
                          await FirebaseAuthServices()
                              .resetPassword(email.text);
                          if (context.mounted) {
                            ref.read(isLoadingProvider.notifier).state = false;
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(screenWidth * 0.5, screenHeight * 0.06),
                            backgroundColor: Colors.cyan.shade300,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Reset Password',
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
        ],
      ),
    );
  }
}
