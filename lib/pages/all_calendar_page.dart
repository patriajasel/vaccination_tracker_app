import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';
import 'package:vaccination_tracker_app/utils/show_marked_dates.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class AllCalendarPage extends ConsumerWidget {
  const AllCalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final themeColor = ref.watch(themeProvider);

    DateTime dateToday = DateTime.now();

    // Precompute the first and last days of each month to avoid recalculating in the builder.
    final List<Map<String, DateTime>> months = List.generate(
      12,
      (index) {
        final month = index + 1;
        return {
          'firstDay': DateTime(dateToday.year, month, 1),
          'lastDay': DateTime(dateToday.year, month + 1, 0),
        };
      },
    );

    final currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final schedules = ref.watch(rpChildScheds.notifier).childScheds;

    List<DateTime> scheduleDate =
        schedules.map((schedule) => schedule.schedDate).toList();

    List<ScheduleModel> scheduleToday = [];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("All Schedules"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: "RadioCanada",
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: themeColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: double.infinity,
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
        child: ListView.builder(
          padding: EdgeInsets.only(top: screenHeight * 0.01),
          itemCount: months.length,
          itemBuilder: (context, index) {
            final firstDay = months[index]['firstDay']!;
            final lastDay = months[index]['lastDay']!;

            return Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.025),
              child: TableCalendar(
                calendarFormat: CalendarFormat.month,
                daysOfWeekHeight: screenHeight * 0.04,
                headerStyle: const HeaderStyle(
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontFamily: "RadioCanada",
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyles().daysOfWeek,
                  weekendStyle: TextStyles().daysOfWeek,
                ),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyles().calendarDays,
                  todayTextStyle: TextStyles().calendarDays,
                  todayDecoration: BoxDecoration(
                    color: Colors.cyan.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  weekendTextStyle: TextStyles().calendarDays,
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  scheduleToday
                    ..clear
                    ..addAll(
                      schedules.where((schedule) =>
                          schedule.schedDate.year == selectedDay.year &&
                          schedule.schedDate.month == selectedDay.month &&
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
                    if (scheduleDate
                        .any((selectedDay) => isSameDay(selectedDay, day))) {
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
                focusedDay: firstDay,
                firstDay: firstDay,
                lastDay: lastDay,
              ),
            );
          },
        ),
      ),
    );
  }
}
