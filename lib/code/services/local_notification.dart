import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin notifPlugin =
      FlutterLocalNotificationsPlugin();

  void initService() async {
    AndroidInitializationSettings settings =
        const AndroidInitializationSettings("notif_icon");
    var initialisationSettings = InitializationSettings(android: settings);
    notifPlugin.initialize(initialisationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails("chanelId3", "channelName859",
            playSound: true,
            sound: RawResourceAndroidNotificationSound("alarm"),
            importance: Importance.high,
            enableVibration: true,
            priority: Priority.max));
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notifPlugin.show(id, title, body, await notificationDetails());
  }
}
