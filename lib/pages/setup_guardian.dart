import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/setup_trackers.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

class SetUpProfileGuardianPage extends StatefulWidget {
  const SetUpProfileGuardianPage({super.key});

  @override
  State<SetUpProfileGuardianPage> createState() =>
      _SetUpProfileGuardianPageState();
}

class _SetUpProfileGuardianPageState extends State<SetUpProfileGuardianPage> {
  final guardianName = TextEditingController();
  final guardianEmail = TextEditingController();
  final guardianNumber = TextEditingController();
  final guardianAge = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final guardianBirthDay = TextEditingController();
  final guardianAddress = TextEditingController();

  final genderList = ["Male", "Female"];
  String? guardianGender = "Male";

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.025),
          // This is for displaying the logo of BSU and College of Nursing
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/logos/bsu_logo.png',
                height: screenHeight * 0.15,
                width: screenWidth * 0.15,
              ),
              const SizedBox(width: 10),
              Image.asset(
                'lib/assets/logos/bsu_con_logo.png',
                height: screenHeight * 0.15,
                width: screenWidth * 0.15,
              )
            ],
          ),

          SizedBox(height: screenHeight * 0.01),

          // This is for the title of the page
          const Text(
            "Set Up Profile",
            style: TextStyle(
                fontFamily: "Mali", fontSize: 40, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: screenHeight * 0.025),

          const Text(
            "Answer the Following: \n(Guardian's Data)",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Mali", fontSize: 25),
          ),

          SizedBox(height: screenHeight * 0.01),

          // This is for the Guardian information section
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // For Name
              Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.01,
                      right: screenWidth * 0.05,
                      left: screenWidth * 0.05),
                  child: GenerateWidget().createTextField(
                    guardianName,
                    "Guardian's Name",
                    false,
                    true,
                    false,
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
                  )),

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
                  )),

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
                      ),
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
                                color: Colors.blue.shade900, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 2.0),
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
                  child: GenerateWidget().createTextField(
                      guardianBirthDay, "Birthday", true, true, false,
                      function: openDatePicker)),

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
                  )),
            ],
          ),

          SizedBox(height: screenHeight * 0.075),

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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const SetupTrackersPage()));
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
          )
        ],
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
        guardianBirthDay.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }

    setState(() {});
  }
}
