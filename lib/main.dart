import 'dart:developer';

import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/fcm_service.dart';
import 'package:chat_app/services/local_notification.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // String? token = await FirebaseMessaging.instance.getToken();
  // log("$token");
  FCMService.fcmService.getAccessToken();

  tz.initializeTimeZones();

  await NotificationService.localNortification.initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: ToastificationWrapper(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.pages,
        ),
      ),
    );
  }
}
