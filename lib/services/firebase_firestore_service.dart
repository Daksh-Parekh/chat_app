import 'package:chat_app/modal/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();
  static FirestoreService fireStoreService = FirestoreService._();

  var firestore = FirebaseFirestore.instance;
  String collectionName = "Users";

  //Add Users
  void addUser({required User modal}) {
    UserModal userModal = UserModal(
      uid: modal.uid,
      name: modal.displayName,
      email: modal.email,
      image: modal.photoURL,
      password: "",
    );

    firestore.collection(collectionName).doc(modal.email).set(userModal.toMap);
  }
}
