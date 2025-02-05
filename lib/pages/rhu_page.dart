import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';
import 'package:vaccination_tracker_app/utils/widget_generate.dart';

class RhuPage extends ConsumerStatefulWidget {
  const RhuPage({super.key});

  @override
  ConsumerState<RhuPage> createState() => _RhuPageState();
}

class _RhuPageState extends ConsumerState<RhuPage> {
  final childHeight = TextEditingController();
  final childWeight = TextEditingController();
  final followUpDate = TextEditingController();

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

  final List<String> vaccineName = [
    'BCG',
    'Hepatitis B',
    'OPV1',
    'OPV2',
    'OPV3',
    'IPV1',
    'IPV2',
    'PCV1',
    'PCV2',
    'PCV3',
    'Pentavalent 1',
    'Pentavalent 2',
    'Pentavalent 3',
    'MMR'
  ];

  final excludedVaccines = {
    'BCG',
    'MMR',
    'Hepatitis B',
    'OPV3',
    'PCV3',
    'IPV2',
    'Pentavalent 3'
  };

  String selectedVaccine = 'BCG';

  List<String> childNames = [];
  String? selectedChild;

  DateTime? selectedFollowUp;

  List<ScheduleModel> scheduleToday = [];

  @override
  void dispose() {
    childHeight.dispose();
    childWeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeColor = ref.watch(themeProvider);

    final schedules = ref.watch(rpChildScheds).childScheds;
    final currentDate = ref.watch(currentDateProvider);

    final childData = ref.watch(rpUserInfo).children;

    childNames
      ..clear()
      ..addAll(childData.map((child) => child.childNickname));

    if (childNames.isNotEmpty) {
      selectedChild = childNames.first;
    }

    scheduleToday
      ..clear()
      ..addAll(
        schedules.where((schedule) =>
            schedule.schedDate.year == currentDate.year &&
            schedule.schedDate.month == currentDate.month &&
            schedule.schedDate.day == currentDate.day &&
            schedule.schedStatus == 'Finished'),
      );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeColor, Colors.white], // Colors for the gradient
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
                          onChanged: null,
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor: WidgetStatePropertyAll(
                              vaccines[index]['checked'] == true
                                  ? Colors.green
                                  : Colors.white),
                          checkColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: DropdownButtonFormField(
                          value: selectedVaccine,
                          items: vaccineName
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedVaccine = val as String;
                            });
                          },
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              fontFamily: "DMSerif"),
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: "Vaccine taken this day",
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: DropdownButtonFormField(
                          value: selectedChild,
                          items: childNames
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedChild = val as String;
                            });
                          },
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              fontFamily: "DMSerif"),
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: "Child",
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        children: [
                          // For Age
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  left: screenWidth * 0.1,
                                  right: screenWidth * 0.01),
                              child: GenerateWidget().createTextField(
                                  childHeight,
                                  "Height",
                                  false,
                                  true,
                                  false,
                                  false,
                                  true),
                            ),
                          ),

                          // For Gender
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  right: screenWidth * 0.1,
                                  left: screenWidth * 0.01),
                              child: GenerateWidget().createTextField(
                                  childWeight,
                                  "Weight",
                                  false,
                                  true,
                                  false,
                                  false,
                                  true),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1),
                          child: GenerateWidget().createTextField(
                              followUpDate,
                              "Follow-up Date",
                              true,
                              excludedVaccines.contains(selectedVaccine)
                                  ? false
                                  : true,
                              false,
                              false,
                              true,
                              function: openDatePicker,
                              suffixIcon: const Icon(Icons.calendar_month))),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(screenWidth * 0.4, screenHeight * 0.05),
                            backgroundColor: Colors.cyan.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Record',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "DMSerif",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ),
                    ],
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
                      "RHU Schedule & Announcements:",
                      style: TextStyles().nextVaccineDate,
                      textAlign: TextAlign.center,
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

  void updateTakenScheduleToday() {
    for (var sched in scheduleToday) {
      switch (sched.vaccineType) {
        case 'BCG':
          vaccines[0]['checked'] = true;
          break;
        case 'Pentavalent 1st Dose':
          vaccines[1]['checked'] = true;
          break;
        case 'Hepatitis B':
          vaccines[2]['checked'] = true;
          break;
        case 'Pentavalent 2nd Dose':
          vaccines[3]['checked'] = true;
          break;
        case 'OPV1':
          vaccines[4]['checked'] = true;
          break;
        case 'Pentavalent 3rd Dose':
          vaccines[5]['checked'] = true;
          break;
        case 'OPV2':
          vaccines[6]['checked'] = true;
          break;
        case 'PCV1':
          vaccines[7]['checked'] = true;
          break;
        case 'OPV3':
          vaccines[8]['checked'] = true;
          break;
        case 'PCV2':
          vaccines[9]['checked'] = true;
          break;
        case 'IPV1':
          vaccines[10]['checked'] = true;
          break;
        case 'PCV3':
          vaccines[11]['checked'] = true;
          break;
        case 'IPV2':
          vaccines[12]['checked'] = true;
          break;
        case 'MMR':
          vaccines[13]['checked'] = true;
          break;
        default:
      }
    }
  }

  void openDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: selectedFollowUp,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));

    if (dateTime != null) {
      setState(() {
        selectedFollowUp = dateTime;
        followUpDate.text = "${selectedFollowUp!.toLocal()}".split(' ')[0];
      });

      setState(() {});
    }
  }
}
