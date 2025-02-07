import 'dart:developer';

import 'package:chat_app/controller/home_controller.dart';
import 'package:chat_app/modal/chat_modal.dart';
import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/services/firebase_firestore_service.dart';
import 'package:chat_app/services/local_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    TextEditingController editMsgController = TextEditingController();
    HomeController controller = Get.put(HomeController());
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
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Periodic Notification"),
                        onTap: () {
                          Get.defaultDialog(
                            actions: [
                              IconButton(
                                onPressed: () {
                                  NotificationService.localNortification
                                      .periodicNotification(
                                          title: 'Periodically',
                                          body:
                                              'Thsi is periodic notification');

                                  Get.back();
                                },
                                icon: Icon(Icons.save),
                              ),
                            ],
                            content: SizedBox(
                              height: 300,
                              child: GetBuilder<HomeController>(
                                  builder: (context) {
                                return GridView.builder(
                                  itemCount: controller.chatBgImage.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.changeBgInx(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                controller.chatBgImage[index]),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color: controller.inx == index
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 4,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ];
                  },
                ),
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

                    log("${allChatData}");
                    return ListView.builder(
                      itemCount: allChatData.length,
                      itemBuilder: (context, index) {
                        DateTime time = allChatData[index].time.toDate();
                        // log("${allChatData[index].time.toDate().day}/${allChatData[index].time.toDate().month}");
                        return Column(
                          children: [
                            (time.day == DateTime.now().day &&
                                    time.month == DateTime.now().month &&
                                    time.year == DateTime.now().year)
                                ? Text("Today")
                                : (time.day ==
                                            DateTime.now()
                                                .subtract(Duration(days: 1))
                                                .day &&
                                        time.month ==
                                            DateTime.now()
                                                .subtract(Duration(days: 1))
                                                .month &&
                                        time.year ==
                                            DateTime.now()
                                                .subtract(Duration(days: 1))
                                                .year)
                                    ? Text("Yesterday")
                                    : Text(
                                        "${time.day}:${time.month}:${time.year}"),
                            (allChatData[index].receiver == user.email)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onLongPress: () {
                                          Get.defaultDialog(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    FirestoreService
                                                        .fireStoreService
                                                        .deleteChats(
                                                      sender: FirebaseAuthService
                                                              .auth
                                                              .checkUserStatus!
                                                              .email ??
                                                          "",
                                                      receiver:
                                                          user.email ?? '',
                                                      id: allChats[index].id,
                                                    );
                                                    Get.back();
                                                  },
                                                  icon: Icon(Icons.delete),
                                                ),
                                                Visibility(
                                                  visible: (DateTime.now()
                                                          .difference(time)
                                                          .inMinutes <=
                                                      10),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      editMsgController.text =
                                                          allChatData[index]
                                                              .msg;
                                                      Get.back();

                                                      Get.bottomSheet(
                                                        Container(
                                                          height: 100.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                          ),
                                                          child: TextField(
                                                            controller:
                                                                editMsgController,
                                                            decoration:
                                                                InputDecoration(
                                                              suffixIcon:
                                                                  IconButton(
                                                                onPressed: () {
                                                                  String msg =
                                                                      editMsgController
                                                                          .text;
                                                                  if (msg
                                                                      .isNotEmpty) {
                                                                    FirestoreService.fireStoreService.editChats(
                                                                        sender:
                                                                            FirebaseAuthService.auth.checkUserStatus!.email ??
                                                                                '',
                                                                        receiver:
                                                                            user
                                                                                .email!,
                                                                        id: allChats[index]
                                                                            .id,
                                                                        msg:
                                                                            msg);
                                                                  }
                                                                  Get.back();
                                                                },
                                                                icon: Icon(Icons
                                                                    .restore),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    icon: Icon(Icons.edit),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.all(4),
                                          child:
                                              Text("${allChatData[index].msg}"),
                                        ),
                                      ),
                                      Text("${time.hour % 12}:${time.minute}"),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.all(4),
                                        child:
                                            Text("${allChatData[index].msg}"),
                                      ),
                                    ],
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
            // Spacer(),
            TextField(
              controller: msgController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                hintText: "Write Something...",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () async {
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

                      // await NotificationService.localNortification
                      //     .showSimpleNotification(
                      //         id: user.name ?? '', body: msg);

                      // msgController.clear();
                      // await NotificationService.localNortification
                      //     .scheduledNotification(
                      //   title: user.name ?? '',
                      //   body: msg,
                      //   scheduledDate: DateTime.now().add(
                      //     Duration(seconds: 2),
                      //   ),
                      // );

                      await NotificationService.localNortification
                          .bigPictureNotification(
                              title: user.name ?? '',
                              body: msg,
                              url: user.image!);
                    }
                  },
                  icon: Icon(
                    Icons.send,
                  ),
                ),
              ),
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  FirestoreService.fireStoreService.sentChat(
                    modal: ChatModal(
                      msg: value,
                      sender:
                          FirebaseAuthService.auth.checkUserStatus!.email ?? '',
                      receiver: user.email!,
                      time: Timestamp.now(),
                    ),
                  );

                  await NotificationService.localNortification
                      .showSimpleNotification(id: user.name ?? '', body: value);

                  await NotificationService.localNortification
                      .scheduledNotification(
                    title: user.name ?? '',
                    body: "This is scheduled notification",
                    scheduledDate: DateTime.now().add(
                      Duration(seconds: 2),
                    ),
                  );

                  await NotificationService.localNortification
                      .bigPictureNotification(
                          title: user.name ?? '',
                          body: value,
                          url: user.image!);
                }
                msgController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
