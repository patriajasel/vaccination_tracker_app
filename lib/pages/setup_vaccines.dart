import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/login_page.dart';

class SetupVaccinesPage extends StatefulWidget {
  const SetupVaccinesPage({super.key});

  @override
  State<SetupVaccinesPage> createState() => _SetupVaccinesPageState();
}

class _SetupVaccinesPageState extends State<SetupVaccinesPage> {
  String bcgOption = 'No';
  String hepatitisBOption = 'No';
  String opv1Option = 'No';
  String opv2Option = 'No';
  String pcv1Option = 'No';
  String pcv2Option = 'No';
  String pentavalent1stDoseOption = 'No';
  String pentavalent2ndDoseOption = 'No';

  final TextEditingController bcgVaccineDate = TextEditingController();
  final TextEditingController hepatitisBVaccineDate = TextEditingController();
  final TextEditingController opv1VaccineDate = TextEditingController();
  final TextEditingController opv2VaccineDate = TextEditingController();
  final TextEditingController pcv1VaccineDate = TextEditingController();
  final TextEditingController pcv2VaccineDate = TextEditingController();
  final TextEditingController pentavalent1stDoseVaccineDate =
      TextEditingController();
  final TextEditingController pentavalent2ndDoseVaccineDate =
      TextEditingController();

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
        case 'PCV1':
          pcv1Option = value!;
          break;
        case 'PCV2':
          pcv2Option = value!;
          break;
        case 'Pentavalent1stDose':
          pentavalent1stDoseOption = value!;
          break;
        case 'Pentavalent2ndDose':
          pentavalent2ndDoseOption = value!;
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            const Text(
              "Set Up Profile",
              style: TextStyle(
                fontFamily: "DMSerif",
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            const Text(
              "Answer the Following:",
              style: TextStyle(
                fontFamily: "Mali",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "(Child's Info)",
              style: TextStyle(
                fontFamily: "Mali",
                fontSize: 20,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: const Text(
                  "Vaccines Taken:",
                  style: TextStyle(
                    fontFamily: 'Mali',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
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
                ],
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.4, screenHeight * 0.05),
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "DMSerif",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.4, screenHeight * 0.05),
                    backgroundColor: Colors.pink.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "DMSerif",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
