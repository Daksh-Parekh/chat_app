import 'package:chat_app/controller/home_controller.dart';
import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
        stream: FirestoreService.fireStoreService.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;

            List<QueryDocumentSnapshot<Map<String, dynamic>>>? allDocs =
                data?.docs ?? [];
            List<UserModal> userData = allDocs
                .map(
                  (e) => UserModal.fromMap(e.data()),
                )
                .toList();

            return ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                var usersInfo = userData[index];

                return ListTile(
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(usersInfo.image!),
                  ),
                  title: Text("${usersInfo.name}"),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
