import 'dart:async';

import 'package:chat_app/controller/login_controller.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () => FirebaseAuthService.auth.checkUserStatus != null
          ? Get.offNamed(AppRoutes.home)
          : Get.offNamed(AppRoutes.login),
    );
    return Scaffold(
      body: FlutterLogo(),
    );
  }
}
