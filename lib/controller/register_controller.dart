import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class RegisterController extends GetxController {
  Future<void> register(
      {required String email, required String password}) async {
    String? msg = await FirebaseAuthService.auth
        .creatUser(email: email, password: password);

    if (msg == "Success") {
      toastification.show(
        title: Text("Success"),
        autoCloseDuration: Duration(seconds: 3),
        description: Text("You register successfully"),
        type: ToastificationType.success,
      );

      Get.back();
    } else {
      toastification.show(
        title: Text("Failed"),
        autoCloseDuration: Duration(seconds: 3),
        description: Text(msg!),
        type: ToastificationType.error,
      );
    }
  }
}
