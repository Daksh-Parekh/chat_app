import 'package:chat_app/controller/home_controller.dart';
import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_firestore_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            FutureBuilder(
              future: FirestoreService.fireStoreService.fetchSingleUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("ERROR : ${snapshot.error}");
                } else if (snapshot.hasData) {
                  var data = snapshot.data;

                  UserModal modal = UserModal.fromMap(data?.data() ?? {});

                  return UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      foregroundImage: NetworkImage(modal.image!),
                    ),
                    accountName: Text(modal.name!),
                    accountEmail: Text(modal.email!),
                  );
                }

                return Container();
              },
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
        title: Text(
          "Chat",
          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
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

                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Get.toNamed(AppRoutes.chat, arguments: usersInfo);
                        },
                        leading: CircleAvatar(
                          foregroundImage: NetworkImage(usersInfo.image ?? ''),
                        ),
                        title: Text(
                          "${usersInfo.name}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
