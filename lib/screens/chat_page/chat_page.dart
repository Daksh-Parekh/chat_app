import 'dart:developer';

import 'package:chat_app/modal/chat_modal.dart';
import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    UserModal user = Get.arguments;
    TextEditingController msgController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(
              height: 14.h,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 32.w,
                  ),
                ),
                CircleAvatar(
                  radius: 34.w,
                  foregroundImage: NetworkImage(user.image!),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.name}",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${user.email}",
                      style: TextStyle(fontSize: 12.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirestoreService.fireStoreService.fetchChats(
                    senderMail:
                        FirebaseAuthService.auth.checkUserStatus!.email ?? '',
                    receiverMail: user.email!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;

                    List<QueryDocumentSnapshot<Map<String, dynamic>>> allChats =
                        data!.docs;

                    List<ChatModal> allChatData = allChats
                        .map(
                          (e) => ChatModal.fromMap(data: e.data()),
                        )
                        .toList();

                    // log("${allChatData}");
                    return ListView.builder(
                      itemCount: allChatData.length,
                      itemBuilder: (context, index) {
                        // log("${allChatData[index].time}");
                        return (allChatData[index].receiver == user.email)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.all(4),
                                    child: Text("${allChatData[index].msg}"),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.all(4),
                                    child: Text("${allChatData[index].msg}"),
                                  ),
                                ],
                              );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
            Spacer(),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: 50.h,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      hintText: "Write Something...",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        FirestoreService.fireStoreService.sentChat(
                          modal: ChatModal(
                            msg: value,
                            sender: FirebaseAuthService
                                    .auth.checkUserStatus!.email ??
                                '',
                            receiver: user.email!,
                            time: Timestamp.now(),
                          ),
                        );
                      }
                      msgController.clear();
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String msg = msgController.text;

                    if (msg.isNotEmpty) {
                      FirestoreService.fireStoreService.sentChat(
                        modal: ChatModal(
                          msg: msg,
                          sender:
                              FirebaseAuthService.auth.checkUserStatus!.email ??
                                  '',
                          receiver: user.email!,
                          time: Timestamp.now(),
                        ),
                      );
                    }
                    msgController.clear();
                  },
                  icon: Icon(
                    Icons.send,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
