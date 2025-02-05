import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/models/user_information.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';

class ScheduleServices {
  Future<void> trackSchedules(WidgetRef ref) async {
    final scheduleToTrack = ref.read(schedulePastToday);
    final currentDate = ref.read(currentDateProvider);
    final nextSched = ref.read(nextSchedule.notifier);

    for (var schedule in scheduleToTrack) {
      int difference = schedule.schedDate.difference(currentDate).inDays;

      final isToday = difference == 0;
      final isTomorrow = difference == 1;
      final isWithinTwo = difference == 2;
      final isWithinThree = difference == 3;

      ref.read(isTodayScheduled.notifier).state = isToday;
      ref.read(isTomorrowScheduled.notifier).state = isTomorrow;
      ref.read(isWithinTwoDays.notifier).state = isWithinTwo;
      ref.read(isWithinThreeDays.notifier).state = isWithinThree;
      nextSched.state = null;

      if (isToday) {
        ref.read(themeProvider.notifier).state = Colors.greenAccent.shade400;
        ref.read(navIndicatorProvider.notifier).state = Colors.greenAccent;
      } else if (isTomorrow || isWithinTwo || isWithinThree) {
        ref.read(themeProvider.notifier).state = Colors.deepOrange.shade300;
        ref.read(navIndicatorProvider.notifier).state =
            Colors.deepOrange.shade400;
      } else {
        ref.read(themeProvider.notifier).state = Colors.cyan.shade300;
        ref.read(navIndicatorProvider.notifier).state = Colors.cyan;
      }
    }

    if (scheduleToTrack.isNotEmpty) {
      final nearestFutureSchedule = scheduleToTrack
          .reduce((a, b) => a.schedDate.isBefore(b.schedDate) ? a : b);
      nextSched.state = nearestFutureSchedule.schedDate;
    }
  }

  Future<void> manageVaccineStatus(WidgetRef ref, List<UserChildren> childData,
      List<ScheduleModel> schedules) async {
    DateTime today = DateTime.now();
    final vaccineTracker = ref.read(vaccineTrackerProvider);

    for (var vaccine in vaccineTracker) {
      String vaccineTitle = vaccine['title'];

      int countYes = childData
          .where(
              (child) => hasChildReceivedVaccine(child.vaccines, vaccineTitle))
          .length;

      bool hasUpcomingSchedule =
          checkForUpcomingSchedule(schedules, vaccineTitle, today);

      if (countYes == childData.length && countYes > 0) {
        vaccine['checked'] = true;
        vaccine['color'] = Colors.green;
      } else if (hasUpcomingSchedule) {
        vaccine['checked'] = true;
        vaccine['color'] = Colors.pink[300];
      } else if (countYes > 0) {
        vaccine['checked'] = true;
        vaccine['color'] = Colors.amber;
      } else {
        vaccine['checked'] = false;
        vaccine['color'] = Colors.white;
      }
    }
  }

  bool hasChildReceivedVaccine(
      ChildVaccines childVaccines, String vaccineTitle) {
    Map<String, String> vaccineMap = {
      "BCG": childVaccines.bcgVaccine,
      "Penta 1": childVaccines.penta1Vaccine,
      "Hepa B": childVaccines.hepaVaccine,
      "Penta 2": childVaccines.penta2Vaccine,
      "OPV 1": childVaccines.opv1Vaccine,
      "Penta 3": childVaccines.penta3Vaccine,
      "OPV2": childVaccines.opv2Vaccine,
      "PCV 1": childVaccines.pcv1Vaccine,
      "OPV 3": childVaccines.opv3Vaccine,
      "PCV 2": childVaccines.pcv2Vaccine,
      "IPV 1": childVaccines.ipv1Vaccine,
      "PCV 3": childVaccines.pcv3Vaccine,
      "IPV 2": childVaccines.ipv2Vaccine,
      "MMR": childVaccines.mmrVaccine,
    };

    return vaccineMap[vaccineTitle] == "Yes";
  }

  bool checkForUpcomingSchedule(
      List<ScheduleModel> schedules, String vaccineTitle, DateTime today) {
    String vaccine = vaccineTitle;
    switch (vaccineTitle) {
      case 'Hepa B':
        vaccine = 'Hepatitis B';
        break;
      case 'IPV 1':
        vaccine = 'IPV1';
        break;
      case 'IPV 2':
        vaccine = 'IPV2';
        break;
      case 'OPV 1':
        vaccine = 'OPV1';
        break;
      case 'OPV 2':
        vaccine = 'OPV2';
        break;
      case 'OPV 3':
        vaccine = 'OPV3';
        break;
      case 'PCV 1':
        vaccine = 'PCV1';
        break;
      case 'PCV 2':
        vaccine = 'PCV2';
        break;
      case 'PCV 3':
        vaccine = 'PCV3';
        break;
      case 'Penta 1':
        vaccine = 'Pentavalent 1st Dose';
        break;
      case 'Penta 2':
        vaccine = 'Pentavalent 2nd Dose';
        break;
      case 'Penta 3':
        vaccine = 'Pentavalent 3rd Dose';
        break;
    }

    return schedules.any((sched) =>
        sched.vaccineType == vaccine &&
        sched.schedDate.isAfter(today.subtract(const Duration(days: 1))));
  }
}
