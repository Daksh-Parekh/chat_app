import 'dart:async';
import 'dart:developer';

import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_firestore_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  //Anonymously Login
  Future<void> anonymouslyLogin() async {
    User? user = await FirebaseAuthService.auth.anonymouslyLogin();
    if (user != null) {
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

  //Google login
  Future<void> googleLogin() async {
    User? user = await FirebaseAuthService.auth.googleLogin();
    if (user != null) {
      Get.offNamed(AppRoutes.home);
      var userStatus = FirebaseAuthService.auth.checkUserStatus;
      UserModal m = UserModal(
          uid: user.uid,
          name: user.displayName,
          email: user.email,
          password: "",
          image: user.photoURL);
      print("${user}");

      if (userStatus != null) {
        log("${user}");
        FirestoreService.fireStoreService.addUser(
          modal: user,
        );
      }
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
