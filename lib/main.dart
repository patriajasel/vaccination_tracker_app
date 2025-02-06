import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccination_tracker_app/authentication_check.dart';
import 'package:vaccination_tracker_app/firebase_options.dart';
import 'package:vaccination_tracker_app/models/vaccine_data.dart';
import 'package:vaccination_tracker_app/pages/intro_page.dart';
import 'package:vaccination_tracker_app/services/json_services.dart';
import 'package:vaccination_tracker_app/services/notification_services.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';

/** 
 * TODO SECTION
 * 
 * ! Circular page indicator for everything that needs loading functionality
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationServices().initializeNotification();

  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final List<String> childProfileImage =
      prefs.getStringList('childProfilePicture') ?? [];

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  List<VaccineData> vaccineData = await JsonServices().loadVaccineData();

  runApp(ProviderScope(
      child: VaccinationTrackerApp(
    isFirstTime: isFirstTime,
    childImage: childProfileImage,
    vaccineData: vaccineData,
  )));
}

class VaccinationTrackerApp extends ConsumerWidget {
  final bool isFirstTime;
  final List<String>? childImage;
  final List<VaccineData> vaccineData;
  const VaccinationTrackerApp(
      {super.key,
      required this.isFirstTime,
      required this.childImage,
      required this.vaccineData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() async {
      if (childImage != null) {
        ref.read(childImageLink.notifier).state = childImage!;
        ref.read(rpVaccineData.notifier).state = vaccineData;
      }
    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            isFirstTime ? const OnBoardingPage() : const AuthenticationCheck());
  }
}
