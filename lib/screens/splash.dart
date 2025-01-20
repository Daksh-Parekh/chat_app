import 'dart:async';

import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
        Get.offNamed(AppRoutes.login);
      },
    );
    return Scaffold(
      body: FlutterLogo(),
    );
  }
}
