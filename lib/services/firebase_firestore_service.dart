import 'package:chat_app/modal/chat_modal.dart';
import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();
  static FirestoreService fireStoreService = FirestoreService._();

  var firestore = FirebaseFirestore.instance;
  String collectionName = "Users";
  String chatRoomCollectionName = "Chatroom";

  //Add Users
  Future<void> addUser({required UserModal modal}) async {
    await firestore
        .collection(collectionName)
        .doc(modal.email)
        .set(modal.toMap);
  }

  //FetchUsers
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUsers() {
    String email = FirebaseAuthService.auth.checkUserStatus?.email ?? '';

    return firestore
        .collection(collectionName)
        .where("email", isNotEqualTo: email)
        .snapshots();
    // return firestore.collection(collectionName).snapshots();
  }

  //Fetch Single User
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchSingleUser() async {
    String email = FirebaseAuthService.auth.checkUserStatus!.email ?? '';
    return await firestore.collection(collectionName).doc(email).get();
  }

  String getDocId({required String senderMail, required String receiverMail}) {
    List user = [senderMail, receiverMail];
    user.sort();
    String docId = user.join('_');
    return docId;
  }

  //Chat Logic
  void sentChat({required ChatModal modal}) {
    String docId =
        getDocId(senderMail: modal.sender, receiverMail: modal.receiver);
    firestore
        .collection(chatRoomCollectionName)
        .doc(docId)
        .collection('Chats')
        .add(modal.toMap);
  }

  //fetch chats
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchChats(
      {required String senderMail, required String receiverMail}) {
    String docId = getDocId(
      senderMail: senderMail,
      receiverMail: receiverMail,
    );
    return firestore
        .collection(chatRoomCollectionName)
        .doc(docId)
        .collection('Chats')
        .orderBy('time', descending: false)
        .snapshots();
  }
}
