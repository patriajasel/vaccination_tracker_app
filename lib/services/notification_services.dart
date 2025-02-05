import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:vaccination_tracker_app/models/child_schedules.dart';
import 'package:vaccination_tracker_app/services/riverpod_services.dart';

class NotificationServices {
  final notificationPlugins = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialization

  Future<void> initializeNotification() async {
    if (_isInitialized) return;

    if (await Permission.notification.isDenied ||
        await Permission.notification.isPermanentlyDenied) {
      await Permission.notification.request();
    }

    if (await Permission.systemAlertWindow.isDenied ||
        await Permission.systemAlertWindow.isPermanentlyDenied) {
      await Permission.systemAlertWindow.request();
    }

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const initializeSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializeSettings =
        InitializationSettings(android: initializeSettingsAndroid);

    await notificationPlugins.initialize(initializeSettings);

    _isInitialized = true;
  }

  // Notification details

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'vaccine_schedule_id', 'Vaccination Schedule',
            channelDescription: 'Vaccine Schedule Notification Channel',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'ic_launcher'));
  }

  // Showing the Notification

  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    return notificationPlugins.show(id, title, body, notificationDetails());
  }

  // Scheduling the Notification

  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime dateTime,
      required int hour,
      required int minute}) async {
    var scheduledDate = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      hour,
      minute,
    );

    await notificationPlugins.zonedSchedule(
        id, title, body, scheduledDate, notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future<void> cancelNotifications(int notifID) async {
    print("Cancelling notification ID: $notifID");
    await notificationPlugins.cancel(notifID);
  }

  Future<void> cancelAllNotifications() async {
    await notificationPlugins.cancelAll();
  }

  Future<bool> checkIfNotificationExists(int id) async {
    final List<PendingNotificationRequest> pendingNotifications =
        await notificationPlugins.pendingNotificationRequests();
    return pendingNotifications.any((notification) => notification.id == id);
  }

  Future<void> createScheduledNotification(
      List<ScheduleModel> schedules) async {
    const notificationTimes = [
      {'hour': 7, 'suffix': '8'},
      {'hour': 12, 'suffix': '12'},
      {'hour': 15, 'suffix': '15'}
    ];

    final now = DateTime.now();

    if (schedules.isNotEmpty) {
      for (var schedule in schedules) {
        for (var time in notificationTimes) {
          if (now.hour < (time['hour'] as int)) {
            int schedID =
                int.parse("${schedule.schedID.substring(4)}${time['suffix']}");

            print("Creating a scheduled notification");

            if (await NotificationServices()
                .checkIfNotificationExists(schedID)) {
              print(
                  'Notification with ID $schedID already exists. Skipping...');
              continue;
            }

            NotificationServices().scheduleNotification(
              id: schedID,
              dateTime: schedule.schedDate,
              title: 'VacCalendar',
              body:
                  'Today is your Schedule of ${schedule.vaccineType} vaccine! for ${schedule.childName}. Don\'t miss it!',
              hour: time['hour'] as int,
              minute: 0,
            );

            print(
                "Notification is created: SchedID: $schedID, Schedule: ${schedule.schedDate}");
          }
        }
      }
    } else {
      print("No schedule to be created.");
    }
  }

  Future<void> manageScheduledNotifications(WidgetRef ref) async {
    final allSchedule = ref.read(rpChildScheds).childScheds;
    final currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    List<ScheduleModel> schedToNotify = [];

    schedToNotify
      ..clear()
      ..addAll(allSchedule.where((schedule) =>
          schedule.schedStatus == 'Pending' &&
              schedule.schedDate.isAtSameMomentAs(currentDate) ||
          schedule.schedDate.isAfter(currentDate)));

    ref.read(schedulePastToday.notifier).state = schedToNotify;

    if (schedToNotify.isNotEmpty) {
      await createScheduledNotification(schedToNotify);
    } else {
      print("No schedules to manage");
    }
  }
}
