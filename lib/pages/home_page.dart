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
              height: screenHeight,
              padding: EdgeInsets.only(top: screenHeight * 0.1),
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
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 6,
                      ),
                      itemCount: vaccines.length,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
