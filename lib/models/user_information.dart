import 'package:flutter/material.dart';

class UserInformation extends ChangeNotifier {
  String name;
  String email;
  String? profileImage;
  List<UserChildren> children;

  UserInformation(
    this.children, {
    this.name = '',
    this.email = '',
    this.profileImage,
  });

  void reset() {
    name = '';
    email = '';
    profileImage = null;
    children.clear();
    for (var child in children) {
      child.reset();
    }
    notifyListeners();
  }

  void updateProfileImage(String newImageLink) {
    profileImage = newImageLink;
    notifyListeners();
  }

  void addChild(UserChildren child) {
    children.add(child);
    notifyListeners();
  }

  void removeChild(String childID) {
    children.removeWhere((child) => child.childID == childID);
    notifyListeners();
  }
}

class UserChildren extends ChangeNotifier {
  String childID;
  String childNickname;
  String facilityNumber;
  String? childImage;
  String birthdate;
  String birthplace;
  String gender;
  int height;
  int weight;
  ChildVaccines vaccines;

  UserChildren({
    this.childID = '',
    this.childNickname = '',
    this.facilityNumber = '',
    this.birthdate = '',
    this.birthplace = '',
    this.gender = '',
    this.height = 0,
    this.weight = 0,
    ChildVaccines? vaccines,
    this.childImage,
  }) : vaccines = vaccines ?? ChildVaccines();

  void reset() {
    childID = '';
    childNickname = '';
    facilityNumber = '';
    birthdate = '';
    birthplace = '';
    gender = '';
    height = 0;
    weight = 0;
    childImage = null;
    vaccines.reset();
    notifyListeners();
  }

  void updateChildProfileImage(String newImageLink) {
    childImage = newImageLink;
    notifyListeners();
  }
}

class ChildVaccines extends ChangeNotifier {
  String bcgVaccine;
  String hepaVaccine;
  String opv1Vaccine;
  String opv2Vaccine;
  String opv3Vaccine;
  String ipv1Vaccine;
  String ipv2Vaccine;
  String penta1Vaccine;
  String penta2Vaccine;
  String penta3Vaccine;
  String pcv1Vaccine;
  String pcv2Vaccine;
  String pcv3Vaccine;
  String mmrVaccine;

  String? bcgDate;
  String? hepaDate;
  String? opv1Date;
  String? opv2Date;
  String? opv3Date;
  String? ipv1Date;
  String? ipv2Date;
  String? penta1Date;
  String? penta2Date;
  String? penta3Date;
  String? pcv1Date;
  String? pcv2Date;
  String? pcv3Date;
  String? mmrDate;

  ChildVaccines({
    this.bcgVaccine = '',
    this.hepaVaccine = '',
    this.opv1Vaccine = '',
    this.opv2Vaccine = '',
    this.opv3Vaccine = '',
    this.ipv1Vaccine = '',
    this.ipv2Vaccine = '',
    this.penta1Vaccine = '',
    this.penta2Vaccine = '',
    this.penta3Vaccine = '',
    this.pcv1Vaccine = '',
    this.pcv2Vaccine = '',
    this.pcv3Vaccine = '',
    this.mmrVaccine = '',
    this.bcgDate = '',
    this.hepaDate = '',
    this.opv1Date = '',
    this.opv2Date = '',
    this.opv3Date = '',
    this.ipv1Date = '',
    this.ipv2Date = '',
    this.penta1Date = '',
    this.penta2Date = '',
    this.penta3Date = '',
    this.pcv1Date = '',
    this.pcv2Date = '',
    this.pcv3Date = '',
    this.mmrDate = '',
  });

  void reset() {
    bcgVaccine = '';
    hepaVaccine = '';
    opv1Vaccine = '';
    opv2Vaccine = '';
    opv3Vaccine = '';
    ipv1Vaccine = '';
    ipv2Vaccine = '';
    penta1Vaccine = '';
    penta2Vaccine = '';
    penta3Vaccine = '';
    pcv1Vaccine = '';
    pcv2Vaccine = '';
    pcv3Vaccine = '';
    mmrVaccine = '';
    notifyListeners();
  }
}
