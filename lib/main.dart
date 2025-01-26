import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_tracker_app/authentication_check.dart';
import 'package:vaccination_tracker_app/firebase_options.dart';
import 'package:vaccination_tracker_app/pages/change_email_page.dart';
import 'package:vaccination_tracker_app/pages/change_password_page.dart';
import 'package:vaccination_tracker_app/pages/intro_page.dart';
import 'package:vaccination_tracker_app/pages/login_page.dart';
import 'package:vaccination_tracker_app/pages/my_child_page.dart';
import 'package:vaccination_tracker_app/pages/profile_page.dart';
import 'package:vaccination_tracker_app/pages/setup_child.dart';
import 'package:vaccination_tracker_app/pages/setup_guardian.dart';
import 'package:vaccination_tracker_app/pages/setup_password.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';

/** 
 * TODO SECTION
 * 
 * ! Circular page indicator for everything that needs loading functionality
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final List<String> childProfileImage =
      prefs.getStringList('childProfilePicture') ?? [];

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(
      child: VaccinationTrackerApp(
    isFirstTime: isFirstTime,
    childImage: childProfileImage,
  )));
}

class VaccinationTrackerApp extends ConsumerWidget {
  final bool isFirstTime;
  final List<String>? childImage;
  const VaccinationTrackerApp(
      {super.key, required this.isFirstTime, required this.childImage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() {
      if (childImage != null) {
        ref.read(childImageLink.notifier).state = childImage!;
      }
    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            isFirstTime ? const OnBoardingPage() : const AuthenticationCheck());
  }
}
