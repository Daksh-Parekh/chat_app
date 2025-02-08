import 'dart:async';

import 'package:chat_app/controller/login_controller.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/chat_page/chat_page.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF1565C0),
              Color(0XFF0F4888),
            ],
            stops: [0, 100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash/splash.png',
              fit: BoxFit.cover,
              height: 250.sp,
              width: 300.sp,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "E-Chat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.sp,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
