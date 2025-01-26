import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuthService._();
  static FirebaseAuthService auth = FirebaseAuthService._();

  FirebaseAuth authentication = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

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
        case 'week-password':
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

  //Anonymously Login
  Future<User?> anonymouslyLogin() async {
    UserCredential userCredential = await authentication.signInAnonymously();
    return userCredential.user;
  }

  //Google Login
  Future<String> googleLogin() async {
    String msg;

    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await authentication.signInWithCredential(credential);

        msg = "Success";
      } else {
        msg = "No google Account";
      }
    } on FirebaseAuthException catch (e) {
      msg = e.code;
    }

    return msg;
  }

  //Check user Login
  User? get checkUserStatus => authentication.currentUser;

  //Logout
  Future<void> logoutUser() async {
    await authentication.signOut();
    await googleSignIn.signOut();
  }
}
