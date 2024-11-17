import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/setup_child.dart';
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              Colors.white
            ], // Colors for the gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  "Upload a photo(optional)",
                  style: TextStyle(fontFamily: "Mali", fontSize: 18),
                )
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
                        guardianName,
                        "Surname",
                        false,
                        true,
                        false,
                      )),

                  Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          right: screenWidth * 0.05,
                          left: screenWidth * 0.05),
                      child: GenerateWidget().createTextField(
                        guardianName,
                        "First Name",
                        false,
                        true,
                        false,
                      )),

                  Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          right: screenWidth * 0.05,
                          left: screenWidth * 0.05),
                      child: GenerateWidget().createTextField(
                        guardianName,
                        "Middle Name",
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
                        builder: (builder) => const SetUpProfileChildPage()));
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
      ),
    );
  }
}
