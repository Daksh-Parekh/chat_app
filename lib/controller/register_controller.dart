import 'dart:io';
import 'dart:math';

import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class RegisterController extends GetxController {
  File? image;
  RxBool isPassword = true.obs;
  RxBool isConfirmPassword = true.obs;

  void changePasswordVisibilty() {
    isPassword.value = !isPassword.value;
  }

  void changeConfirmPasswordVisibilty() {
    isConfirmPassword.value = !isConfirmPassword.value;
  }

  Future<void> register(
      {required String email,
      required String password,
      required String image,
      required String userName}) async {
    String? msg = await FirebaseAuthService.auth.creatUser(
      email: email,
      password: password,
    );

    if (msg == "Success") {
      Get.back();

      FirestoreService.fireStoreService.addUser(
        modal: UserModal(
          uid: FirebaseAuthService.auth.checkUserStatus?.uid ?? '',
          name: userName,
          email: email,
          password: password,
          image: image,
          token: await FirebaseMessaging.instance.getToken(),
        ),
      );

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

  Future<void> pickGalleryImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = File(file.path);
      Get.back();
    }
    update();
  }

  Future<void> pickCameraImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      image = File(file.path);
      Get.back();
    }
    update();
  }
}
