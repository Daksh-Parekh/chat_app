import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService {
  FirebaseAuthService._();
  static FirebaseAuthService auth = FirebaseAuthService._();

  var authentication = FirebaseAuth.instance;

  //creating user
  Future<String?> creatUser(
      {required String email, required String password}) async {
    String msg;
    try {
      await authentication.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      msg = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          msg = 'this service not available';
        case 'weak-password':
          msg = "Your password is too week";
        default:
          msg = e.code;
      }
    }
    return msg;
    // return userCredential.user;
  }

  //Login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String msg;
    try {
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
      msg = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          msg = "Invalid credential";
        case 'operation-not-allowed':
          msg = "This service no more";
        default:
          msg = e.code;
      }
    }
    return msg;
  }
}
