import 'package:chat_app/main.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter email",
              ),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: passController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter password",
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {},
              child: Text("Login"),
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
    );
  }
}
