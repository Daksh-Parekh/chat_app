import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class LoginController extends GetxController {
  //Login user with email&password
  Future<void> loginUser(
      {required String email, required String password}) async {
    String msg = await FirebaseAuthService.auth
        .loginUser(email: email, password: password);
    if (msg == "Success") {
      Get.offNamed(AppRoutes.home);
      toastification.show(
        title: Text("Success"),
        description: Text("Login successfull"),
        autoCloseDuration: Duration(seconds: 3),
        type: ToastificationType.success,
      );
    } else {
      toastification.show(
        title: Text("Failed"),
        description: Text("Login unsuccessfull"),
        autoCloseDuration: Duration(seconds: 3),
        type: ToastificationType.error,
      );
    }
  }
}
