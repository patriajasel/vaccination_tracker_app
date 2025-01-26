import 'dart:io';

import 'package:flutter/material.dart';

class GuardianInformation extends ChangeNotifier {
  // For Guardian's Information
  String guardianSurname;
  String guardianFirstName;
  String guardianMiddleName;
  int guardianAge;
  String guardianGender;
  String guardianAddress;
  String guardianEmail;
  String guardianContact;
  File? guardianImage;

  GuardianInformation(
    this.guardianSurname,
    this.guardianFirstName,
    this.guardianMiddleName,
    this.guardianAge,
    this.guardianGender,
    this.guardianAddress,
    this.guardianEmail,
    this.guardianContact,
  );

  // Resetting model

  void reset() {
    guardianSurname = "";
    guardianFirstName = "";
    guardianMiddleName = "";
    guardianAge = 0;
    guardianGender = "";
    guardianAddress = "";
    guardianEmail = "";
    guardianContact = "";
    guardianImage = null;

    notifyListeners();
  }
}
