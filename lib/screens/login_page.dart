import 'package:chat_app/controller/login_controller.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/utils/extension/email_extension.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
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
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: loginFormKey,
          child: Column(
            children: [
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
              ElevatedButton(
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    controller.loginUser(
                      email: emailController.text.trim(),
                      password: passController.text.trim(),
                    );
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.anonymouslyLogin();
                    },
                    label: Text("Anonymously"),
                    icon: Icon(Icons.person),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.googleLogin();
                    },
                    label: Text("Google"),
                    icon: Icon(Icons.g_mobiledata),
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.register);
                },
                child: Text("Sing up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
