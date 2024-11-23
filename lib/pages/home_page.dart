import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  final List<String> vaccineImages = [
    'lib/assets/images/vaccines/bcg_vaccine.jpg',
    'lib/assets/images/vaccines/hepatitis_b_vaccine.jpg',
    'lib/assets/images/vaccines/dtap_vaccine.jpg',
    'lib/assets/images/vaccines/opv_vaccine.jpg',
    'lib/assets/images/vaccines/ipv_vaccine.jpg',
    'lib/assets/images/vaccines/pcv_vaccine.jpg',
    'lib/assets/images/vaccines/mmr_vaccine.jpg',
    'lib/assets/images/vaccines/pentavalent_vaccine.jpg',
  ];

  final List<String> vaccineNames = [
    'BCG',
    'Hepatitis B',
    'DTAP',
    'OPV',
    'IPV',
    'PCV',
    'MMR',
    'Pentavalent',
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    DateTime dateToday = DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade700,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Scrollable Content
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: screenHeight * 0.0525),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TableCalendar(
                      calendarFormat: CalendarFormat.week,
                      daysOfWeekHeight: screenHeight * 0.04,
                      headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                              fontFamily: "RadioCanada",
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold)),
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyles().daysOfWeek,
                          weekendStyle: TextStyles().daysOfWeek),
                      calendarStyle: CalendarStyle(
                          defaultTextStyle: TextStyles().calendarDays,
                          todayTextStyle: TextStyles().calendarDays,
                          todayDecoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20)),
                          weekendTextStyle: TextStyles().calendarDays),
                      focusedDay: dateToday,
                      firstDay: DateTime.utc(2020, 01, 01),
                      lastDay: DateTime.utc(2040, 12, 31)),
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: Text(
                      "October 23, 2024",
                      style: TextStyles().nextVaccineDate,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Center(
                    child: Text(
                      "NEXT VACCINATION",
                      style: TextStyles().nextVaccineDate,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: const Divider(
                      thickness: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Center(
                    child: Text(
                      "Upcoming Vaccines & Taken Vaccines",
                      style: TextStyles().sectionTitle,
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
                          title: Text(vaccines[index]['title']),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Text(
                        "All About Vaccines...",
                        style: TextStyles().sectionTitle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: vaccineImages.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2)),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(vaccineImages[index],
                                      height: screenHeight * 0.2,
                                      width: screenWidth * 0.3,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Text(
                              vaccineNames[index],
                              style: TextStyles().vaccineNames,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: screenHeight * 0.06,
              right: screenWidth * 0.15,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
