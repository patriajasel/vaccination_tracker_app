import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/models/vaccines_information.dart';

/**
  * TODO SECTION 
  * ! For adding multiple childs in the register
  */

class Children extends ChangeNotifier {
  List<ChildInformation> children;

  Children(this.children);

  void reset() {
    for (var child in children) {
      child.reset();
    }
  }
}

class ChildInformation extends ChangeNotifier {
  // For Child's Information
  String childName;
  String? facilityNumber;
  int childAge;
  String childGender;
  DateTime childBirthDate;
  String childBirthPlace;

  // For Child's Growth Tracking

  int childHeight;
  int childWeight;
  List<String> hConditions;

  File? childImage;

  late VaccinesInformation childVaccines;

  ChildInformation(
      this.childName,
      this.facilityNumber,
      this.childAge,
      this.childGender,
      this.childBirthDate,
      this.childBirthPlace,
      this.childHeight,
      this.childWeight,
      this.hConditions,
      this.childImage,
      this.childVaccines);

  // Resetting model

  void reset() {
    childName = "";
    facilityNumber = "";
    childAge = 0;
    childGender = "";
    childBirthDate = DateTime.now();
    childBirthPlace = "";
    childHeight = 0;
    childWeight = 0;
    hConditions.clear();
    childImage = null;
    childVaccines.reset();

    notifyListeners();
  }
}
