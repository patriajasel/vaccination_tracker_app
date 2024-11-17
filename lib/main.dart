import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/pages/intro_page.dart';

void main() => runApp(const ProviderScope(child: VaccinationTrackerApp()));

class VaccinationTrackerApp extends StatelessWidget {
  const VaccinationTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: OnBoardingPage());
  }
}
