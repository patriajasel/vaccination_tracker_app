import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/pages/all_about_vaccines_page.dart';
import 'package:vaccination_tracker_app/pages/all_calendar_page.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/show_marked_dates.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

/**
 * TODO SECTION
 * 
 * ! All About vaccines section
 * ! Sync Vaccines taken with firebase database data
 * ! Schedule functionality
 * ! Prevent returning back to login if user just logged in
 */

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<String> vaccineImages = [
    'lib/assets/images/vaccines/bcg_vaccine.jpg',
    'lib/assets/images/vaccines/hepatitis_b_vaccine.jpg',
    'lib/assets/images/vaccines/opv_vaccine.jpg',
    'lib/assets/images/vaccines/ipv_vaccine.jpg',
    'lib/assets/images/vaccines/pcv_vaccine.jpg',
    'lib/assets/images/vaccines/mmr_vaccine.jpg',
    'lib/assets/images/vaccines/pentavalent_vaccine.jpg',
  ];

  final List<String> vaccineNames = [
    'BCG',
    'Hepatitis B',
    'OPV',
    'IPV',
    'PCV',
    'MMR',
    'Pentavalent',
  ];

  List<DateTime> scheduleDate = [];
  List<ScheduleModel> scheduleToday = [];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final schedules = ref.watch(rpChildScheds.notifier).childScheds;

    final currentDate = ref.watch(currentDateProvider);

    final isToday = ref.watch(isTodayScheduled);
    final isTomorrow = ref.watch(isTomorrowScheduled);
    final isWithinTwo = ref.watch(isWithinTwoDays);
    final isWithinThree = ref.watch(isWithinThreeDays);
    final nextSched = ref.watch(nextSchedule);

    final vaccineTracker = ref.watch(vaccineTrackerProvider);

    final themeColor = ref.watch(themeProvider);

    scheduleDate = schedules.map((schedule) => schedule.schedDate).toList();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColor,
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
                  Stack(
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
                              canMarkersOverflow: false,
                              todayTextStyle: TextStyles().calendarDays,
                              todayDecoration: BoxDecoration(
                                  color: Colors.cyan.shade50,
                                  borderRadius: BorderRadius.circular(20)),
                              weekendTextStyle: TextStyles().calendarDays),
                          onDaySelected: (selectedDay, focusedDay) {
                            scheduleToday
                              ..clear()
                              ..addAll(
                                schedules.where((schedule) =>
                                    schedule.schedDate.year ==
                                        selectedDay.year &&
                                    schedule.schedDate.month ==
                                        selectedDay.month &&
                                    schedule.schedDate.day == selectedDay.day),
                              );

                            showDialog(
                                context: context,
                                builder: (context) => MarkedDayDialog(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                    currentDate: currentDate,
                                    schedToday: scheduleToday));
                          },
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, day, events) {
                              if (scheduleDate.any((selectedDay) =>
                                  isSameDay(selectedDay, day))) {
                                return Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                          focusedDay: currentDate,
                          firstDay: DateTime.utc(2020, 01, 01),
                          lastDay: DateTime.utc(2040, 12, 31)),
                      Positioned(
                          top: screenHeight * 0.01,
                          right: screenWidth * 0.15,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllCalendarPage()));
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: Text(
                      isToday
                          ? 'TODAY is the day!'
                          : isTomorrow
                              ? "Tomorrow is the day!"
                              : isWithinTwo
                                  ? "IN 2 DAYS!"
                                  : isWithinThree
                                      ? "IN 3 DAYS!"
                                      : nextSched != null
                                          ? DateFormat('MMMM dd, yyyy')
                                              .format(nextSched)
                                          : "",
                      style: TextStyles().nextVaccineDate,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Center(
                    child: Text(
                      isToday || isTomorrow || isWithinTwo || isWithinThree
                          ? 'Get your child vaccinated!'
                          : nextSched != null
                              ? "NEXT VACCINATION!"
                              : "No Vaccination Schedule",
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
                      itemCount: vaccineTracker.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                            vaccineTracker[index]['title'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'RadioCanada',
                                fontWeight: FontWeight.bold),
                          ),
                          value: vaccineTracker[index]['checked'],
                          onChanged: null,
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor: WidgetStatePropertyAll(
                              vaccineTracker[index]['color']),
                          checkColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: null,
                              checkColor: Colors.white,
                              fillColor: WidgetStatePropertyAll(Colors.green),
                            ),
                            Text("Taken")
                          ],
                        )),
                        const Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: null,
                              checkColor: Colors.white,
                              fillColor: WidgetStatePropertyAll(Colors.amber),
                            ),
                            Text("Partial")
                          ],
                        )),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: null,
                              checkColor: Colors.white,
                              fillColor:
                                  WidgetStatePropertyAll(Colors.pink[300]),
                            ),
                            const Text("Upcoming")
                          ],
                        )),
                      ],
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
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => AllAboutVaccinesPage(
                                        index: index,
                                      )))),
                          child: Column(
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
