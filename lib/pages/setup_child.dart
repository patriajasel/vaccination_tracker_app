import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaccination_tracker_app/models/child_information.dart';
import 'package:vaccination_tracker_app/models/vaccines_information.dart';
import 'package:vaccination_tracker_app/pages/setup_password.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

/**
 * TODO SECTION
 * ! Add a button for adding another child
 * ! Add functionality for multiple child
 * ! Health Conditions, Address, Birthday and vaccine info did not reset
 */

class SetUpProfileChildPage extends ConsumerStatefulWidget {
  const SetUpProfileChildPage({super.key});

  @override
  ConsumerState<SetUpProfileChildPage> createState() =>
      _SetUpProfileChildPageState();
}

class _SetUpProfileChildPageState extends ConsumerState<SetUpProfileChildPage> {
  final cNickname = TextEditingController();
  final cFacilityNumber = TextEditingController();
  final cAge = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final cBirthday = TextEditingController();
  final cBirthPlace = TextEditingController();

  final cAddress = TextEditingController();

  final cHeight = TextEditingController();
  final cWeight = TextEditingController();
  final cOthers = TextEditingController();

  bool nicknameValidator = true;
  bool ageValidator = true;

  List<bool> checkedList = List.generate(5, (index) => false);
  List<String> healthConditions = [
    "Clubfoot",
    "Chickenpox",
    "Asthma",
    "Measles",
    "Pneumonia"
  ];

  final genderList = ["Male", "Female"];
  String? genderSelectedVal = "Male";

  File? selectedImage;

  String bcgOption = 'No';
  String hepatitisBOption = 'No';
  String opv1Option = 'No';
  String opv2Option = 'No';
  String opv3Option = 'No';
  String ipv1Option = 'No';
  String ipv2Option = 'No';
  String pcv1Option = 'No';
  String pcv2Option = 'No';
  String pcv3Option = 'No';
  String pentavalent1stDoseOption = 'No';
  String pentavalent2ndDoseOption = 'No';
  String pentavalent3rdDoseOption = 'No';
  String mmrOption = 'No';

  final TextEditingController bcgVaccineDate = TextEditingController();
  final TextEditingController hepatitisBVaccineDate = TextEditingController();
  final TextEditingController opv1VaccineDate = TextEditingController();
  final TextEditingController opv2VaccineDate = TextEditingController();
  final TextEditingController opv3VaccineDate = TextEditingController();
  final TextEditingController ipv1VaccineDate = TextEditingController();
  final TextEditingController ipv2VaccineDate = TextEditingController();
  final TextEditingController pcv1VaccineDate = TextEditingController();
  final TextEditingController pcv2VaccineDate = TextEditingController();
  final TextEditingController pcv3VaccineDate = TextEditingController();

  final TextEditingController pentavalent1stDoseVaccineDate =
      TextEditingController();
  final TextEditingController pentavalent2ndDoseVaccineDate =
      TextEditingController();
  final TextEditingController pentavalent3rdDoseVaccineDate =
      TextEditingController();
  final TextEditingController mmrVaccineDate = TextEditingController();

  @override
  void initState() {
    cBirthday.text = "${selectedDate.toLocal()}".split(' ')[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              "(Child's Info)",
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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                          pickChildImage();
                        },
                        child: const Text("Upload")),
                  ),
                ),
              ],
            ),

            // This is for the child information section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.01),

                    // For Last Name
                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(
                            cNickname,
                            "Nickname",
                            false,
                            true,
                            false,
                            false,
                            nicknameValidator)),

                    // For First Name
                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(
                            cFacilityNumber,
                            "Facility Number (optional)",
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
                            child: GenerateWidget().createTextField(cAge, "Age",
                                false, true, false, false, ageValidator),
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
                              value: genderSelectedVal,
                              items: genderList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  genderSelectedVal = val as String;
                                });
                              },
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
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
                                      color: Colors.cyan.shade400, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.cyan.shade700, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.cyan.shade400, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // For Birthday
                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(cBirthday,
                            "Birthday", true, true, false, false, true,
                            function: openDatePicker,
                            suffixIcon: const Icon(Icons.calendar_month))),

                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(
                          cBirthPlace,
                          "Place of Birth",
                          false,
                          true,
                          false,
                          false,
                          true,
                        )),

                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(cAddress,
                            "Address", false, true, false, false, true)),

                    SizedBox(height: screenHeight * 0.01),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: const Text(
                          "Growth Tracker:",
                          style: TextStyle(
                              fontFamily: 'Mali',
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(cHeight,
                            "Height (cm)", false, true, false, true, true,
                            maxLength: 3, hintText: "in cm")),

                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(cWeight,
                            "Weight (kg)", false, true, false, true, true,
                            maxLength: 2, hintText: "in kg")),

                    SizedBox(height: screenHeight * 0.01),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: const Text(
                          "Health Conditions:",
                          style: TextStyle(
                              fontFamily: 'Mali',
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.2,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Number of items per row (adjust based on your preference)
                          mainAxisSpacing: 5.0, // Spacing between rows
                          crossAxisSpacing: 5.0, // Spacing between columns
                          childAspectRatio:
                              4, // Adjust this to control the height of the tiles
                        ),
                        itemCount:
                            5, // Number of CheckboxListTile items to display
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            activeColor: Colors.pink.shade300,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                            visualDensity: VisualDensity
                                .compact, // Reduce padding between tiles
                            value: checkedList[index],
                            onChanged: (value) {
                              setState(() {
                                checkedList[index] = value ?? false;
                              });
                            },
                            title: Text(
                              healthConditions[index],
                              style: const TextStyle(
                                  fontFamily: "DMSerif", letterSpacing: 1.5),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(
                            cOthers,
                            "Other Conditions (please specify):",
                            false,
                            true,
                            false,
                            false,
                            true)),

                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: const Divider(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken BCG vaccine at birth?",
                        groupValue: bcgOption,
                        onChanged: (value) => _handleOptionChange(value, 'BCG'),
                        controller: bcgVaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, bcgVaccineDate),
                        isDateEnabled: bcgOption == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question:
                            "Has the child taken Hepatitis B vaccine at birth?",
                        groupValue: hepatitisBOption,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'Hepatitis'),
                        controller: hepatitisBVaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, hepatitisBVaccineDate),
                        isDateEnabled: hepatitisBOption == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken OPV 1 vaccine?",
                        groupValue: opv1Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'OPV1'),
                        controller: opv1VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, opv1VaccineDate),
                        isDateEnabled: opv1Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken OPV 2 vaccine?",
                        groupValue: opv2Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'OPV2'),
                        controller: opv2VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, opv2VaccineDate),
                        isDateEnabled: opv2Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken OPV 3 vaccine?",
                        groupValue: opv3Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'OPV3'),
                        controller: opv3VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, opv3VaccineDate),
                        isDateEnabled: opv3Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken IPV 1 vaccine?",
                        groupValue: ipv1Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'IPV1'),
                        controller: ipv1VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, ipv1VaccineDate),
                        isDateEnabled: ipv1Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken IPV 2 vaccine?",
                        groupValue: ipv2Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'IPV2'),
                        controller: ipv2VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, ipv2VaccineDate),
                        isDateEnabled: ipv2Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken PCV 1 vaccine?",
                        groupValue: pcv1Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'PCV1'),
                        controller: pcv1VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, pcv1VaccineDate),
                        isDateEnabled: pcv1Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken PCV 2 vaccine?",
                        groupValue: pcv2Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'PCV2'),
                        controller: pcv2VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, pcv2VaccineDate),
                        isDateEnabled: pcv2Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question: "Has the child taken PCV 3 vaccine?",
                        groupValue: pcv3Option,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'PCV3'),
                        controller: pcv3VaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, pcv3VaccineDate),
                        isDateEnabled: pcv3Option == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question:
                            "Has the child taken the 1st dose of Pentavalent vaccine?",
                        groupValue: pentavalent1stDoseOption,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'Pentavalent1stDose'),
                        controller: pentavalent1stDoseVaccineDate,
                        onDatePickerTap: () => _openDatePicker(
                            context, pentavalent1stDoseVaccineDate),
                        isDateEnabled: pentavalent1stDoseOption == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.01),
                    buildVaccineQuestion(
                        question:
                            "Has the child taken the 2nd dose of Pentavalent vaccine?",
                        groupValue: pentavalent2ndDoseOption,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'Pentavalent2ndDose'),
                        controller: pentavalent2ndDoseVaccineDate,
                        onDatePickerTap: () => _openDatePicker(
                            context, pentavalent2ndDoseVaccineDate),
                        isDateEnabled: pentavalent2ndDoseOption == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.05),
                    buildVaccineQuestion(
                        question:
                            "Has the child taken the 3rd dose of Pentavalent vaccine?",
                        groupValue: pentavalent3rdDoseOption,
                        onChanged: (value) =>
                            _handleOptionChange(value, 'Pentavalent3rdDose'),
                        controller: pentavalent3rdDoseVaccineDate,
                        onDatePickerTap: () => _openDatePicker(
                            context, pentavalent3rdDoseVaccineDate),
                        isDateEnabled: pentavalent3rdDoseOption == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.05),
                    buildVaccineQuestion(
                        question: "Has the child taken MMR vaccine?",
                        groupValue: mmrOption,
                        onChanged: (value) => _handleOptionChange(value, 'MMR'),
                        controller: mmrVaccineDate,
                        onDatePickerTap: () =>
                            _openDatePicker(context, mmrVaccineDate),
                        isDateEnabled: mmrOption == "Yes",
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.4, screenHeight * 0.05),
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
                    bool validate = await validateTextFields();

                    if (validate) {
                      if (context.mounted) {
                        showConfirmationDialog(context);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Required fields are empty",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.4, screenHeight * 0.05),
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
            ),

            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
    );
  }

  void openDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));

    if (dateTime != null) {
      setState(() {
        selectedDate = dateTime;
        cBirthday.text = "${selectedDate.toLocal()}".split(' ')[0];
      });

      setState(() {});
    }
  }

  Future<bool> validateTextFields() async {
    if (cNickname.text.isEmpty || cAge.text.isEmpty) {
      if (cNickname.text.isEmpty) {
        setState(() {
          nicknameValidator = false;
        });
      }

      if (cAge.text.isEmpty) {
        setState(() {
          ageValidator = false;
        });
      }

      return false;
    }

    return true;
  }

  Future<void> pickChildImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void _handleOptionChange(String? value, String vaccine) {
    setState(() {
      switch (vaccine) {
        case 'BCG':
          bcgOption = value!;
          break;
        case 'Hepatitis':
          hepatitisBOption = value!;
          break;
        case 'OPV1':
          opv1Option = value!;
          break;
        case 'OPV2':
          opv2Option = value!;
          break;
        case 'OPV3':
          opv3Option = value!;
          break;
        case 'IPV1':
          ipv1Option = value!;
          break;
        case 'IPV2':
          ipv2Option = value!;
          break;
        case 'PCV1':
          pcv1Option = value!;
          break;
        case 'PCV2':
          pcv2Option = value!;
          break;
        case 'PCV3':
          pcv3Option = value!;
          break;
        case 'Pentavalent1stDose':
          pentavalent1stDoseOption = value!;
          break;
        case 'Pentavalent2ndDose':
          pentavalent2ndDoseOption = value!;
          break;
        case 'Pentavalent3rdDose':
          pentavalent3rdDoseOption = value!;
          break;
        case 'MMR':
          mmrOption = value!;
          break;
      }
    });
  }

  Future<void> _openDatePicker(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget buildVaccineQuestion({
    required String question,
    required String groupValue,
    required void Function(String?) onChanged,
    required TextEditingController controller,
    required VoidCallback onDatePickerTap,
    required double screenWidth,
    required double screenHeight,
    bool isDateEnabled = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: "DMSerif",
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Radio<String>(
                  value: 'Yes',
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
                const Text('Yes'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'No',
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
                const Text('No'),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: TextField(
            controller: controller,
            readOnly: true,
            enabled: isDateEnabled,
            decoration: const InputDecoration(
              labelText: "Date Taken",
              border: OutlineInputBorder(),
            ),
            onTap: onDatePickerTap,
          ),
        ),
      ],
    );
  }

  void resetControllers() {
    cNickname.clear();
    cFacilityNumber.clear();
    cAge.clear();
    genderSelectedVal = "Male";
    cBirthday.clear();
    cBirthPlace.clear();
    cHeight.clear();
    cWeight.clear();
    cOthers.clear();
    cAddress.clear();
    for (int i = 0; i < checkedList.length; i++) {
      checkedList[i] = false;
    }
    selectedImage = null;

    bcgOption = "No";
    hepatitisBOption = "No";
    opv1Option = "No";
    opv2Option = "No";
    opv3Option = "No";
    ipv1Option = "No";
    ipv2Option = "No";
    pcv1Option = "No";
    pcv2Option = "No";
    pcv3Option = "No";
    pentavalent1stDoseOption = "No";
    pentavalent2ndDoseOption = "No";
    pentavalent3rdDoseOption = "No";
    mmrOption = "No";

    bcgVaccineDate.clear();
    hepatitisBVaccineDate.clear();
    opv1VaccineDate.clear();
    opv2VaccineDate.clear();
    opv3VaccineDate.clear();
    ipv1VaccineDate.clear();
    ipv2VaccineDate.clear();
    pcv1VaccineDate.clear();
    pcv2VaccineDate.clear();
    pcv3VaccineDate.clear();
    pentavalent1stDoseVaccineDate.clear();
    pentavalent2ndDoseVaccineDate.clear();
    pentavalent3rdDoseVaccineDate.clear();
    mmrVaccineDate.clear();
    setState(() {});
  }

  Future<void> storeDataToRiverpod() async {
    final children = ref.read(rpChildInfo.notifier).children;

    List<String> childConditions = [];

    for (int i = 0; i < checkedList.length; i++) {
      if (checkedList[i] == true) {
        childConditions.add(healthConditions[i]);
      }
    }

    if (cOthers.text != "") {
      childConditions.add(cOthers.text);
    }

    children.add(ChildInformation(
        cNickname.text,
        cFacilityNumber.text,
        cAge.text,
        genderSelectedVal!,
        DateTime.parse(cBirthday.text),
        cBirthPlace.text,
        int.parse(cHeight.text),
        int.parse(cWeight.text),
        childConditions,
        selectedImage,
        VaccinesInformation(
            bcgOption,
            hepatitisBOption,
            opv1Option,
            opv2Option,
            opv3Option,
            ipv1Option,
            ipv2Option,
            pcv1Option,
            pcv2Option,
            pcv3Option,
            pentavalent1stDoseOption,
            pentavalent2ndDoseOption,
            pentavalent3rdDoseOption,
            mmrOption,
            bcgDate:
                bcgOption == "No" ? null : DateTime.parse(bcgVaccineDate.text),
            hepatitisBDate: hepatitisBOption == "No"
                ? null
                : DateTime.parse(hepatitisBVaccineDate.text),
            ipv1Date: ipv1Option == "No"
                ? null
                : DateTime.parse(ipv1VaccineDate.text),
            ipv2Date: ipv2Option == "No"
                ? null
                : DateTime.parse(ipv2VaccineDate.text),
            mmrDate:
                mmrOption == "No" ? null : DateTime.parse(mmrVaccineDate.text),
            opv1Date: opv1Option == "No"
                ? null
                : DateTime.parse(opv1VaccineDate.text),
            opv2Date: opv2Option == "No"
                ? null
                : DateTime.parse(opv2VaccineDate.text),
            opv3Date: opv3Option == "No"
                ? null
                : DateTime.parse(opv3VaccineDate.text),
            pcv1Date: pcv1Option == "No"
                ? null
                : DateTime.parse(pcv1VaccineDate.text),
            pcv2Date: pcv2Option == "No"
                ? null
                : DateTime.parse(pcv2VaccineDate.text),
            pcv3Date: pcv3Option == "No"
                ? null
                : DateTime.parse(pcv3VaccineDate.text),
            pentavalent1stDate: pentavalent1stDoseOption == "No" ? null : DateTime.parse(pentavalent1stDoseVaccineDate.text),
            pentavalent2ndDate: pentavalent2ndDoseOption == "No" ? null : DateTime.parse(pentavalent2ndDoseVaccineDate.text),
            pentavalent3rdDate: pentavalent3rdDoseOption == "No" ? null : DateTime.parse(pentavalent3rdDoseVaccineDate.text))));
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('What would you like to do?'),
          content: const Text(
              'Would you like to proceed with setting up your account or register another child?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await storeDataToRiverpod();

                resetControllers();

                print(
                    "Children Length: ${ref.watch(rpChildInfo).children.length}");

                if (context.mounted) {
                  final userEmail = ref.watch(rpGuardianInfo).guardianEmail;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SetupPassword(email: userEmail)));
                }
              },
              child: const Text('Proceed to Setup'),
            ),
            TextButton(
              onPressed: () async {
                await storeDataToRiverpod();

                resetControllers();

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Register Another Child'),
            ),
          ],
        );
      },
    );
  }
}
