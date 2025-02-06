import 'package:flutter/material.dart';

class RhuSchedules extends ChangeNotifier {
  List<RhuScheduleModel> rhuSchedules;

  RhuSchedules(this.rhuSchedules);

  void addRhuSchedule(RhuScheduleModel sched) {
    rhuSchedules.add(sched);
    notifyListeners();
  }

  void reset() {
    rhuSchedules.clear();
    notifyListeners();
  }
}

class RhuScheduleModel {
  String title;
  DateTime date;
  String startTime;
  String endTime;

  RhuScheduleModel(this.title, this.date, this.startTime, this.endTime);
}
