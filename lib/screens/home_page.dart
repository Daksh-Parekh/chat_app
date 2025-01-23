import 'package:chat_app/controller/home_controller.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    controller.getCurrentUserData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(controller.image.value),
              ),
              accountName: Text(controller.name.value),
              accountEmail: Text(controller.email.value),
            ),
            ListTile(
              onTap: () {
                controller.logOut();
              },
              leading: Icon(Icons.logout_rounded),
              title: Text("Log Out"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home Page"),
      ),
    );
  }
}
