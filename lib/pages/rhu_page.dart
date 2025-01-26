import 'package:flutter/material.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class RhuPage extends StatefulWidget {
  const RhuPage({super.key});

  @override
  State<RhuPage> createState() => _RhuPageState();
}

class _RhuPageState extends State<RhuPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> vaccines = [
      {'title': 'BCG', 'checked': false},
      {'title': 'Penta 1', 'checked': false},
      {'title': 'Hepa B', 'checked': false},
      {'title': 'Penta 2', 'checked': false},
      {'title': 'OPV 1', 'checked': false},
      {'title': 'Penta 3', 'checked': false},
      {'title': 'OPV 2', 'checked': false},
      {'title': 'PCV 1', 'checked': false},
      {'title': 'OPV 3', 'checked': false},
      {'title': 'PCV 2', 'checked': false},
      {'title': 'IPV 1', 'checked': false},
      {'title': 'PCV 3', 'checked': false},
      {'title': 'IPV 2', 'checked': false},
      {'title': 'MMR', 'checked': false},
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: screenHeight * 0.0525),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.025,
                        right: screenWidth * 0.1,
                        left: screenWidth * 0.1),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Taken Vaccines this day:",
                      style: TextStyles().nextVaccineDate,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.3,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 6,
                      ),
                      itemCount: vaccines.length,
                      shrinkWrap:
                          true, // Ensures GridView doesn't take infinite space
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                            vaccines[index]['title'],
                            style: TextStyles().vaccineNames,
                          ),
                          value: vaccines[index]['checked'],
                          onChanged: (bool? value) {
                            setState(() {
                              vaccines[index]['checked'] = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor: const WidgetStatePropertyAll(Colors.white),
                          checkColor: Colors.black,
                          side: const BorderSide(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.025,
                        right: screenWidth * 0.1,
                        left: screenWidth * 0.1),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "RHU Schedule:",
                      style: TextStyles().nextVaccineDate,
                    ),
                  ),
                  SizedBox(
                      height: screenHeight * 0.5,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: screenHeight * 0.01,
                                right: screenWidth * 0.05,
                                left: screenWidth * 0.05),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "24",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text("FEB", style: TextStyle(fontSize: 12)),
                                    Text("10:00 AM, ",
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                  child: VerticalDivider(
                                    width: 20,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                Text("10:00 AM"),
                              ],
                            ),
                          );
                        },
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
