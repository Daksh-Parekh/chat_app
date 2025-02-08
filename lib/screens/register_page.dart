import 'package:chat_app/controller/register_controller.dart';
import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/api_service.dart';
import 'package:chat_app/utils/extension/email_extension.dart';
import 'package:flutter/gestures.dart';
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
      // appBar: AppBar(
      //   title: Text("Register Page"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100.h,
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Form(
              key: registerFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GetBuilder<RegisterController>(builder: (context) {
                          return CircleAvatar(
                            radius: 80,
                            foregroundImage: controller.image != null
                                ? FileImage(controller.image!)
                                : null,
                          );
                        }),
                        FloatingActionButton.small(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Photos",
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      controller.pickCameraImage();
                                      // Get.back();
                                    },
                                    label: Text("Camera"),
                                    icon: Icon(Icons.camera_alt_rounded),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      controller.pickGalleryImage();
                                    },
                                    label: Text("Gallery"),
                                    icon: Icon(Icons.camera),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Icon(Icons.camera_enhance_rounded),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: userNameController,
                      validator: (value) =>
                          value!.isEmpty ? "required username" : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "Enter Username",
                        labelText: "Username",
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
                        filled: true,
                        fillColor: Colors.blueAccent.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "Enter email",
                        labelText: "Email",
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: passController,
                      obscureText: controller.isPassword.value,
                      validator: (value) =>
                          value!.isEmpty ? "Please enter password" : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "Enter password",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.changePasswordVisibilty();
                          },
                          icon: Icon(
                            (controller.isPassword.value)
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: cPassController,
                      obscureText: controller.isConfirmPassword.value,
                      validator: (value) => value!.isEmpty
                          ? "Please enter confirm password"
                          : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "Enter confirm password",
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.changeConfirmPasswordVisibilty();
                          },
                          icon: Icon(
                            (controller.isPassword.value)
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    OutlinedButton(
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
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1,
                          color: Color(0XFF1565C0),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text.rich(
                      TextSpan(
                        text: 'Already have a account? ',
                        children: [
                          TextSpan(
                            text: 'Log in',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
                              },
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
