import 'package:chat_app/modal/user_modal.dart';
import 'package:chat_app/services/firebase_auth_service.dart';
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
}
