import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/services/notification_services.dart';

class MarkedDayDialog extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final List<ScheduleModel>? schedToday;
  final DateTime currentDate;

  const MarkedDayDialog({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.schedToday,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.cyan.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This Day's Schedule",
            style: TextStyle(
                fontFamily: 'DMSerif',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
          )
        ],
      ),
      content: SizedBox(
        width: screenWidth * 0.7,
        height: screenHeight * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: schedToday != null && schedToday!.isNotEmpty
                  ? ListView.builder(
                      itemCount: schedToday!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Schedule #${index + 1}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RadioCanada',
                                      fontSize: 18),
                                ),
                                const Spacer(),
                                if (schedToday![index]
                                        .schedDate
                                        .isAtSameMomentAs(currentDate) ||
                                    schedToday![index]
                                        .schedDate
                                        .isAfter(currentDate))
                                  NotificationToggleButton(
                                      schedules: schedToday!),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  _buildTextSpan("Schedule ID: ",
                                      schedToday![index].schedID),
                                  _buildTextSpan(
                                      "Date: ",
                                      DateFormat('MMMM dd, yyyy').format(
                                          schedToday![index].schedDate)),
                                  _buildTextSpan(
                                      "Child: ", schedToday![index].childName),
                                  _buildTextSpan("Vaccine: ",
                                      "${schedToday![index].vaccineType} vaccine"),
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No Schedule for this day",
                        style: TextStyle(fontFamily: 'Mali'),
                      ),
                    ),
            ),
            if (schedToday != null && schedToday!.isNotEmpty)
              const Text(
                "Please be advised to go to your health center to proceed with the vaccination. Thank you!",
                style: TextStyle(
                    fontFamily: 'RadioCanada', fontWeight: FontWeight.bold),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            SizedBox(height: screenHeight * 0.01)
          ],
        ),
      ),
    );
  }

  TextSpan _buildTextSpan(String label, String value) {
    return TextSpan(
      children: [
        TextSpan(
          text: label,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'RadioCanada',
              fontSize: 14),
        ),
        TextSpan(
          text: "$value\n",
          style: const TextStyle(fontFamily: 'RadioCanada', fontSize: 14),
        ),
      ],
    );
  }
}

class NotificationToggleButton extends StatefulWidget {
  final List<ScheduleModel> schedules;

  const NotificationToggleButton({super.key, required this.schedules});

  @override
  NotificationToggleButtonState createState() =>
      NotificationToggleButtonState();
}

class NotificationToggleButtonState extends State<NotificationToggleButton> {
  bool isNotificationEnabled = true;

  void _toggleNotification() async {
    List<int> time = [8, 12, 15];
    setState(() {
      isNotificationEnabled = !isNotificationEnabled;
    });

    if (!isNotificationEnabled) {
      for (var schedule in widget.schedules) {
        for (var t in time) {
          final notificationId =
              int.parse("${schedule.schedID.substring(4)}$t");
          await NotificationServices().cancelNotifications(notificationId);
        }
      }
    } else {
      await NotificationServices()
          .createScheduledNotification(widget.schedules);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleNotification,
      icon: Icon(
        isNotificationEnabled ? Icons.notifications : Icons.notifications_off,
        color: Colors.cyan,
      ),
    );
  }
}
