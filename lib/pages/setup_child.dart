import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/setup_vaccines.dart';
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

  final height = TextEditingController();
  final width = TextEditingController();

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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // For Last Name
                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(
                          lastName,
                          "Nickname",
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
                          firstName,
                          "Facility Number (optional)",
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
                              age,
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

                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(
                          firstName,
                          "Address",
                          false,
                          true,
                          false,
                        )),

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
                        child: GenerateWidget().createTextField(
                            height, "Height (cm)", false, true, false,
                            hintText: "in cm")),

                    Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.01,
                            right: screenWidth * 0.05,
                            left: screenWidth * 0.05),
                        child: GenerateWidget().createTextField(
                            width, "Weight (kg)", false, true, false,
                            hintText: "in kg")),

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
                            width,
                            "Other Conditions (please specify):",
                            false,
                            true,
                            false)),

                    SizedBox(height: screenHeight * 0.02),
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
                        builder: (builder) => const SetupVaccinesPage()));
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
        birthday.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }

    setState(() {});
  }
}
