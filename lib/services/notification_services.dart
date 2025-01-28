import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

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
}
