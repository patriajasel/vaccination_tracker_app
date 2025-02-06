import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/models/child_information.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/models/guardian_information.dart';
import 'package:vaccination_tracker_app/models/rhu_schedule_model.dart';
import 'package:vaccination_tracker_app/models/user_information.dart';
import 'package:vaccination_tracker_app/models/vaccine_data.dart';

/** 
 * TODO SECTION
 * 
 * ! Circular page indicator for everything that needs loading functionality
 * 
 */

final rpGuardianInfo = ChangeNotifierProvider<GuardianInformation>((ref) {
  return GuardianInformation("", "", "", 0, "", "", "", "");
});

final rpChildInfo = ChangeNotifierProvider<Children>((ref) {
  return Children([]);
});

final rpUserInfo = ChangeNotifierProvider<UserInformation>((ref) {
  ref.keepAlive();
  return UserInformation([]);
});

final rhuScheduleProvider =
    ChangeNotifierProvider<RhuSchedules>((ref) => RhuSchedules([]));

final childImageLink = StateProvider<List<String>>((ref) => []);

final rpChildScheds = ChangeNotifierProvider<ChildSchedules>(
  (ref) {
    return ChildSchedules([]);
  },
);

final rpVaccineData = StateProvider<List<VaccineData>>((ref) => []);

final currentDateProvider = StateProvider<DateTime>((ref) =>
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

final schedulePastToday = StateProvider<List<ScheduleModel>>((ref) => []);

final vaccineTrackerProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => [
    {'title': 'BCG', 'checked': false, 'color': Colors.white},
    {'title': 'Penta 1', 'checked': false, 'color': Colors.white},
    {'title': 'Hepa B', 'checked': false, 'color': Colors.white},
    {'title': 'Penta 2', 'checked': false, 'color': Colors.white},
    {'title': 'OPV 1', 'checked': false, 'color': Colors.white},
    {'title': 'Penta 3', 'checked': false, 'color': Colors.white},
    {'title': 'OPV 2', 'checked': false, 'color': Colors.white},
    {'title': 'PCV 1', 'checked': false, 'color': Colors.white},
    {'title': 'OPV 3', 'checked': false, 'color': Colors.white},
    {'title': 'PCV 2', 'checked': false, 'color': Colors.white},
    {'title': 'IPV 1', 'checked': false, 'color': Colors.white},
    {'title': 'PCV 3', 'checked': false, 'color': Colors.white},
    {'title': 'IPV 2', 'checked': false, 'color': Colors.white},
    {'title': 'MMR', 'checked': false, 'color': Colors.white},
  ],
);

final isTodayScheduled = StateProvider<bool>((ref) => false);
final isTomorrowScheduled = StateProvider<bool>((ref) => false);
final isWithinTwoDays = StateProvider<bool>((ref) => false);
final isWithinThreeDays = StateProvider<bool>((ref) => false);
final nextSchedule = StateProvider<DateTime?>((ref) => null);

final themeProvider = StateProvider<Color>(
  (ref) => Colors.cyan.shade300,
);

final navIndicatorProvider = StateProvider<Color>(
  (ref) => Colors.cyan,
);

final isLoadingProvider = StateProvider<bool>((ref) => false);
