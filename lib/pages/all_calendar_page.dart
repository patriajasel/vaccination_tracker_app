import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class AllCalendarPage extends StatelessWidget {
  const AllCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    DateTime dateToday = DateTime.now();

    // List of months to display
    final List<int> months = List.generate(12, (index) => index + 1);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("All Schedules"),
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: "RadioCanada",
            fontSize: 24.0,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade300,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan.shade300,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.01),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: months.length,
              itemBuilder: (context, index) {
                final month = months[index];
                final firstDayOfMonth = DateTime(dateToday.year, month, 1);
                final lastDayOfMonth = DateTime(dateToday.year, month + 1, 0);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                        focusedDay:
                            firstDayOfMonth, // Set focus for the first day of the month
                        firstDay: firstDayOfMonth, // First day of the month
                        lastDay: lastDayOfMonth, // Last day of the month
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
