import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/pages/login_page.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

class SetupVaccinesPage extends StatefulWidget {
  const SetupVaccinesPage({super.key});

  @override
  State<SetupVaccinesPage> createState() => _SetupVaccinesPageState();
}

class _SetupVaccinesPageState extends State<SetupVaccinesPage> {
  String? bcgOption = "No";
  String? hepatitisOption = "No";
  final bcgVaccineDate = TextEditingController();
  final hepaVaccineDate = TextEditingController();
  DateTime? bcgSelectedDate = DateTime.now();
  DateTime? hepaSelectedDate = DateTime.now();

  @override
  void initState() {
    bcgVaccineDate.text = "${bcgSelectedDate!.toLocal()}".split(' ')[0];
    hepaVaccineDate.text = "${hepaSelectedDate!.toLocal()}".split(' ')[0];
    super.initState();
  }

  void _handleBcgOptionChange(String? value) {
    setState(() {
      bcgOption = value; // Update selected option
    });
  }

  void _handleHepatitisOptionChange(String? value) {
    setState(() {
      hepatitisOption = value; // Update selected option
    });
  }

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
              "Answer the Following: \n(Vaccines)",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Mali", fontSize: 25),
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
                      fontSize: 24),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.025),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Has the child taken BCG vaccine at birth?',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "DMSerif",
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                    height: screenHeight *
                        0.01), // Add some space between the question and the buttons
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the buttons
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Yes',
                          groupValue: bcgOption,
                          onChanged: _handleBcgOptionChange,
                        ),
                        const Text('Yes'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'No',
                          groupValue: bcgOption,
                          onChanged: _handleBcgOptionChange,
                        ),
                        const Text('No'),
                      ],
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.05,
                        left: screenWidth * 0.05),
                    child: GenerateWidget().createTextField(
                        bcgVaccineDate,
                        "Date Taken",
                        true,
                        bcgOption == "Yes" ? true : false,
                        false,
                        function: bcgOpenDatePicker)),
              ],
            ),

            SizedBox(height: screenHeight * 0.025),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Has the child taken Hepatitis B vaccine at birth?',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "DMSerif",
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                    height: screenHeight *
                        0.01), // Add some space between the question and the buttons
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the buttons
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Yes',
                          groupValue: hepatitisOption,
                          onChanged: _handleHepatitisOptionChange,
                        ),
                        const Text('Yes'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'No',
                          groupValue: hepatitisOption,
                          onChanged: _handleHepatitisOptionChange,
                        ),
                        const Text('No'),
                      ],
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.05,
                        left: screenWidth * 0.05),
                    child: GenerateWidget().createTextField(
                        hepaVaccineDate,
                        "Date Taken",
                        true,
                        hepatitisOption == "Yes" ? true : false,
                        false,
                        function: hepaOpenDatePicker)),
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
                        builder: (builder) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.4, screenHeight * 0.05),
                      backgroundColor: Colors.pink.shade300,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Finish',
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

  void bcgOpenDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: bcgSelectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));

    if (dateTime != null) {
      setState(() {
        bcgSelectedDate = dateTime;
        bcgVaccineDate.text = "${bcgSelectedDate!.toLocal()}".split(' ')[0];
      });
    }

    setState(() {});
  }

  void hepaOpenDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: hepaSelectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));

    if (dateTime != null) {
      setState(() {
        hepaSelectedDate = dateTime;
        hepaVaccineDate.text = "${hepaSelectedDate!.toLocal()}".split(' ')[0];
      });
    }

    setState(() {});
  }
}
