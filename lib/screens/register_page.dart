import 'package:chat_app/controller/register_controller.dart';
import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/api_service.dart';
import 'package:chat_app/utils/extension/email_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController cPassController = TextEditingController();
    RegisterController controller = Get.put(RegisterController());
    GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: registerFormKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GetBuilder<RegisterController>(builder: (context) {
                          return CircleAvatar(
                            radius: 70,
                            foregroundImage: controller.image != null
                                ? FileImage(controller.image!)
                                : null,
                          );
                        }),
                        FloatingActionButton.small(
                          onPressed: () {
                            controller.pickImage();
                          },
                          child: Icon(Icons.camera_enhance_rounded),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Column(
                      children: [],
                    ),
                    TextFormField(
                      controller: userNameController,
                      validator: (value) =>
                          value!.isEmpty ? "required username" : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Username",
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: emailController,
                      validator: (value) => value!.isEmpty
                          ? "required email"
                          : value.isValidEmail()
                              ? null
                              : "Please enter proper email!!",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter email",
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: passController,
                      validator: (value) =>
                          value!.isEmpty ? "Please enter password" : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter password",
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: cPassController,
                      validator: (value) => value!.isEmpty
                          ? "Please enter confirm password"
                          : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter confirm password",
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (registerFormKey.currentState!.validate() &&
                            controller.image != null) {
                          if (passController.text == cPassController.text) {
                            String img = await APIService.apiService
                                .uploadUserImg(image: controller.image!);

                            controller.register(
                              email: emailController.text.trim(),
                              password: passController.text.trim(),
                              image: img,
                              userName: userNameController.text.trim(),
                            );
                          } else {
                            passController.clear();
                            cPassController.clear();
                            Get.snackbar('Failed',
                                'Password and confirm password should be match');
                          }
                        }

                        // Get.back();
                      },
                      child: Text("Register"),
                    ),
                    // const Spacer(),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Log in"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
