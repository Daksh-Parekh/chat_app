import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService._();
  static NotificationService localNortification = NotificationService._();

  FlutterLocalNotificationsPlugin plugins = FlutterLocalNotificationsPlugin();

  Future<void> permissionRequest() async {
    log("Called");

    PermissionStatus status = await Permission.notification.request();
    PermissionStatus notificationSound =
        await Permission.scheduleExactAlarm.request();

    log("Called Succesfully: ${status}");
    if (status.isDenied && notificationSound.isDenied) {
      permissionRequest();
    }
  }

  Future<void> initNotification() async {
    await permissionRequest();

    log("Permission done");
    AndroidInitializationSettings androidSetting =
        AndroidInitializationSettings("mipmap/ic_launcher");

    DarwinInitializationSettings iOSSetting = DarwinInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: androidSetting,
      iOS: iOSSetting,
    );

    plugins
        .initialize(settings)
        .then(
          (value) => log("Notification initialization successfully...."),
        )
        .onError(
          (error, _) => log("$error"),
        );
  }

  Future<void> showSimpleNotification(
      {required String id, required String body}) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      '01',
      'chat_app',
      priority: Priority.high,
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('sound2'),
    );
    NotificationDetails details = NotificationDetails(android: androidDetails);

    await plugins.show(DateTime.now().microsecond, id, body, details);
  }
}
