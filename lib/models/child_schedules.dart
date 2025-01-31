import 'package:flutter/foundation.dart';

class ChildSchedules extends ChangeNotifier {
  List<ScheduleModel> childScheds;

  ChildSchedules(this.childScheds);

  void addSchedules(ScheduleModel scheds) {
    childScheds.add(scheds);
    notifyListeners();
  }

  void reset() {
    childScheds.clear();
    notifyListeners();
  }
}

class ScheduleModel {
  final String schedID;
  final String childID;
  final String childName;
  final String parent;
  final String schedStatus;
  final DateTime schedDate;
  final String vaccineType;

  ScheduleModel(
      {required this.schedID,
      required this.childID,
      required this.childName,
      required this.parent,
      required this.schedStatus,
      required this.schedDate,
      required this.vaccineType});
}
