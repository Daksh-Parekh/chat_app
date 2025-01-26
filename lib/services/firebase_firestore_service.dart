import 'package:chat_app/modal/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();
  static FirestoreService fireStoreService = FirestoreService._();

  var firestore = FirebaseFirestore.instance;
  String collectionName = "Users";

  //Add Users
  Future<void> addUser({required UserModal modal}) async {
    await firestore
        .collection(collectionName)
        .doc(modal.email)
        .set(modal.toMap);
  }

  //FetchUsers
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUsers() {
    return firestore.collection(collectionName).snapshots();
  }
}
