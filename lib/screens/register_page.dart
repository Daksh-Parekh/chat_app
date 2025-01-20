import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController cPassController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            TextFormField(
              controller: cPassController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter confirm password",
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
