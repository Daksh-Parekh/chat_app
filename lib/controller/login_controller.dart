import 'dart:async';
import 'dart:developer';

import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_firestore_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class LoginController extends GetxController {
  RxBool isPassword = true.obs;

  void changePasswordVisibilty() {
    isPassword.value = !isPassword.value;
  }

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
    String? user = await FirebaseAuthService.auth.googleLogin();
    if (user == "Success") {
      Get.offNamed(AppRoutes.home);
      var userStatus = FirebaseAuthService.auth.checkUserStatus;
      log("$userStatus");

      if (userStatus != null) {
        log("${user}");
        await FirestoreService.fireStoreService.addUser(
          modal: UserModal(
            uid: userStatus.uid,
            name: userStatus.displayName,
            email: userStatus.email,
            password: "",
            image: userStatus.photoURL,
            token: await FirebaseMessaging.instance.getToken(),
          ),
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
