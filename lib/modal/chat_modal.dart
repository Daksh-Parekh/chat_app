import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModal {
  String msg, sender, receiver;
  Timestamp time;

  ChatModal(
      {required this.msg,
      required this.sender,
      required this.receiver,
      required this.time});

  factory ChatModal.fromMap({required Map data}) => ChatModal(
        msg: data['msg'],
        sender: data['sender'],
        receiver: data['receiver'],
        time: data['time'],
      );

  Map<String, dynamic> get toMap => {
        'msg': msg,
        'sender': sender,
        'receiver': receiver,
        'time': time,
      };
}
