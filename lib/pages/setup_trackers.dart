import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/setup_vaccines.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

class SetupTrackersPage extends StatefulWidget {
  const SetupTrackersPage({super.key});

  @override
  State<SetupTrackersPage> createState() => _SetupTrackersPageState();
}

class _SetupTrackersPageState extends State<SetupTrackersPage> {
  final height = TextEditingController();
  final width = TextEditingController();

  List<bool> checkedList = List.generate(5, (index) => false);
  List<String> healthConditions = [
    "Influenza",
    "Chickenpox",
    "Asthma",
    "Measles",
    "Pneumonia"
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.yellow.shade50,
      body: SingleChildScrollView(
        child: Column(
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
                  fontFamily: "Mali",
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(height: screenHeight * 0.025),

            const Text(
              "Answer the Following: \n(Trackers)",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Mali", fontSize: 25),
            ),

            SizedBox(height: screenHeight * 0.025),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: const Text(
                  "Growth Tracker:",
                  style: TextStyle(
                      fontFamily: 'Mali',
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
            ),

            // This is for the child information section
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // For Height
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.05,
                        left: screenWidth * 0.05),
                    child: GenerateWidget().createTextField(
                        height, "Height", false, true, false,
                        hintText: "in cm")),

                // For Width
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.05,
                        left: screenWidth * 0.05),
                    child: GenerateWidget().createTextField(
                        width, "Weight", false, true, false,
                        hintText: "in kg")),
              ],
            ),

            SizedBox(height: screenHeight * 0.025),

            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                    itemCount: 5, // Number of CheckboxListTile items to display
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
                )
              ],
            ),

            Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.05, left: screenWidth * 0.05),
                child: GenerateWidget().createTextField(width,
                    "Other Conditions (please specify):", false, true, false)),

            SizedBox(height: screenHeight * 0.02),

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
            )
          ],
        ),
      ),
    );
  }
}
