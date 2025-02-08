import 'package:chat_app/controller/login_controller.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/utils/extension/email_extension.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    LoginController controller = Get.put(LoginController());
    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text("Login"),
      // ),
      body: Column(
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
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 26.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Form(
              key: loginFormKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (value) => value!.isEmpty
                            ? "E-mail is required"
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
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Obx(() {
                        return TextFormField(
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
                            labelText: 'Password',
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
                        );
                      }),
                      SizedBox(height: 36.h),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: OutlinedButton(
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              controller.loginUser(
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 1.5,
                              color: Color(0XFF1565C0),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Text.rich(
                        TextSpan(
                          text: 'New User? ',
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.register);
                                },
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                          ),
                          Text(" Or "),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.anonymouslyLogin();
                            },
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/login/user.png'),
                                  scale: 14,
                                  // fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.googleLogin();
                            },
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/login/google.png'),
                                  scale: 14,
                                  // fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
