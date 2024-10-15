import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/setup_guardian.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

class SetUpProfileChildPage extends StatefulWidget {
  const SetUpProfileChildPage({super.key});

  @override
  State<SetUpProfileChildPage> createState() => _SetUpProfileChildPageState();
}

class _SetUpProfileChildPageState extends State<SetUpProfileChildPage> {
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final middleName = TextEditingController();
  final age = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final birthday = TextEditingController();

  final genderList = ["Male", "Female"];
  String? genderSelectedVal = "Male";

  @override
  void initState() {
    birthday.text = "${selectedDate.toLocal()}".split(' ')[0];
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
            "Answer the Following: \n(Child Data)",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Mali", fontSize: 25),
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

          // This is for the child information section
          SizedBox(
            height: screenHeight * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // For Last Name
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.05,
                        left: screenWidth * 0.05),
                    child: GenerateWidget()
                        .createTextField(lastName, "Last Name", false, true, false,)),

                // For First Name
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.05,
                        left: screenWidth * 0.05),
                    child: GenerateWidget()
                        .createTextField(firstName, "First Name", false, true, false,)),

                // For Middle Name
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.05,
                        left: screenWidth * 0.05),
                    child: GenerateWidget().createTextField(
                        middleName, "Middle Name", false, true, false,)),

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
                        child: GenerateWidget()
                            .createTextField(age, "Age", false, true, false,),
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
                        birthday, "Birthday", true, true, false,
                        function: openDatePicker)),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.01),

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
                      builder: (builder) => const SetUpProfileGuardianPage()));
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
        birthday.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }

    setState(() {});
  }
}
