import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaccination_tracker_app/pages/setup_child.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

/**
 * TODO SECTION
 * 
 */

class SetUpProfileGuardianPage extends ConsumerStatefulWidget {
  const SetUpProfileGuardianPage({super.key});

  @override
  ConsumerState<SetUpProfileGuardianPage> createState() =>
      _SetUpProfileGuardianPageState();
}

class _SetUpProfileGuardianPageState
    extends ConsumerState<SetUpProfileGuardianPage> {
  final guardianSurname = TextEditingController();
  final guardianFirstName = TextEditingController();
  final guardianLastName = TextEditingController();
  final guardianMiddleName = TextEditingController();
  final guardianEmail = TextEditingController();
  final guardianNumber = TextEditingController();
  final guardianAge = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final guardianBirthDay = TextEditingController();
  final guardianAddress = TextEditingController();

  bool surnameValidator = true;
  bool firstNameValidator = true;
  bool emailValidator = true;
  bool contactValidator = true;

  final genderList = ["Male", "Female", "Rather Not Say"];
  String? guardianGender = "Male";

  File? selectedImage;

  @override
  void initState() {
    guardianBirthDay.text = "${selectedDate.toLocal()}".split(' ')[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan.shade300,
              Colors.white
            ], // Colors for the gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),

                // This is for the title of the page
                const Text(
                  "Set Up Profile",
                  style: TextStyle(
                      fontFamily: "DMSerif",
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: screenHeight * 0.025),

                const Text(
                  "Answer the Following:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Mali",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "(Guardian's Info)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Mali",
                      fontSize: 20,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: screenHeight * 0.01),

                // This is for the photo of the baby section
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade400,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : null,
                        child: selectedImage == null
                            ? const Icon(
                                Icons.person,
                                size: 90,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.5, // Adjust width as needed
                      child: ListTile(
                        title: const Text(
                          "Upload a photo (optional)",
                          style: TextStyle(fontFamily: "Mali", fontSize: 16),
                        ),
                        subtitle: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              pickGuardianImage();
                            },
                            child: const Text("Upload")),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.01),

                // This is for the Guardian information section
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // For Name
                      Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              right: screenWidth * 0.05,
                              left: screenWidth * 0.05),
                          child: GenerateWidget().createTextField(
                              guardianSurname,
                              "Surname",
                              false,
                              true,
                              false,
                              false,
                              surnameValidator)),

                      Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              right: screenWidth * 0.05,
                              left: screenWidth * 0.05),
                          child: GenerateWidget().createTextField(
                              guardianFirstName,
                              "First Name",
                              false,
                              true,
                              false,
                              false,
                              firstNameValidator)),

                      Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              right: screenWidth * 0.05,
                              left: screenWidth * 0.05),
                          child: GenerateWidget().createTextField(
                              guardianMiddleName,
                              "Middle Name",
                              false,
                              true,
                              false,
                              false,
                              true)),

                      // For Age and Gender
                      Row(
                        children: [
                          // For Age
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                  right: screenWidth * 0.02,
                                  left: screenWidth * 0.05),
                              child: GenerateWidget().createTextField(
                                  guardianAge,
                                  "Age",
                                  false,
                                  true,
                                  false,
                                  true,
                                  true,
                                  maxLength: 2),
                            ),
                          ),

                          // For Gender
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                  right: screenWidth * 0.05,
                                  left: screenWidth * 0.02),
                              child: DropdownButtonFormField(
                                value: guardianGender,
                                items: genderList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    guardianGender = val as String;
                                  });
                                },
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    fontFamily: "DMSerif"),
                                dropdownColor: Colors.white,
                                decoration: InputDecoration(
                                  labelText: "Gender",
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                      fontFamily: "DMSerif"),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.cyan.shade300,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.cyan.shade700,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.cyan.shade400,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // For Address
                      Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              right: screenWidth * 0.05,
                              left: screenWidth * 0.05),
                          child: GenerateWidget().createTextField(
                            guardianAddress,
                            "Address",
                            false,
                            true,
                            false,
                            false,
                            true,
                          )),

                      // For First Name
                      Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              right: screenWidth * 0.05,
                              left: screenWidth * 0.05),
                          child: GenerateWidget().createTextField(
                              guardianEmail,
                              "Email Address",
                              false,
                              true,
                              false,
                              false,
                              emailValidator)),

                      // For Middle Name
                      Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              right: screenWidth * 0.05,
                              left: screenWidth * 0.05),
                          child: GenerateWidget().createTextField(
                              guardianNumber,
                              "Contact Number",
                              false,
                              true,
                              false,
                              true,
                              contactValidator,
                              maxLength: 11)),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(screenWidth * 0.4, screenHeight * 0.05),
                          backgroundColor: Colors.cyan.shade400,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "DMSerif",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.1),
                    ElevatedButton(
                      onPressed: () async {
                        final guardian = ref.read(rpGuardianInfo.notifier);
                        guardian.guardianSurname = guardianSurname.text;
                        guardian.guardianFirstName = guardianFirstName.text;
                        guardian.guardianMiddleName = guardianMiddleName.text;
                        guardian.guardianAge = int.parse(guardianAge.text);
                        guardian.guardianGender = guardianGender!;
                        guardian.guardianAddress = guardianAddress.text;
                        guardian.guardianEmail = guardianEmail.text;
                        guardian.guardianContact = guardianNumber.text;
                        guardian.guardianImage = selectedImage;

                        bool validate = await validateTextFields();
                        if (context.mounted) {
                          if (validate) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) =>
                                    const SetUpProfileChildPage()));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Required fields are empty",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(screenWidth * 0.4, screenHeight * 0.05),
                          backgroundColor: Colors.pink.shade300,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "DMSerif",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> validateTextFields() async {
    if (guardianSurname.text.isEmpty ||
        guardianFirstName.text.isEmpty ||
        guardianEmail.text.isEmpty ||
        guardianNumber.text.isEmpty) {
      if (guardianSurname.text.isEmpty) {
        setState(() {
          surnameValidator = false;
        });
      }

      if (guardianFirstName.text.isEmpty) {
        setState(() {
          firstNameValidator = false;
        });
      }

      if (guardianEmail.text.isEmpty) {
        setState(() {
          emailValidator = false;
        });
      }

      if (guardianNumber.text.isEmpty) {
        setState(() {
          contactValidator = false;
        });
      }
      return false;
    } else {
      surnameValidator = true;
      firstNameValidator = true;
      emailValidator = true;
      contactValidator = true;
      return true;
    }
  }

  Future<void> pickGuardianImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }
}
