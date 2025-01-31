import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // RxString name = "ABC".obs;
  // RxString email = "abc@gmail.com".obs;
  // RxString image =
  //     "https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369989.png"
  //         .obs;

  // void getCurrentUserData() {
  //   var user = FirebaseAuthService.auth.checkUserStatus;
  //   if (user != null) {
  //     name.value =
  //         user.displayName ?? user.email?.split('@')[0].toUpperCase() ?? "ABC";
  //     email.value = user.email ?? "abc@gmail.com";
  //     image.value = user.photoURL ??
  //         "https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369989.png";
  //   }
  // }
  List chatBgImage = [
    'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjQ4MS1iYi1uaW5nLTEyYl8xLmpwZw.jpg',
    'https://media.istockphoto.com/id/1945538809/vector/speech-bubble-talking-chatting-quote-communication-abstract-background.jpg?s=612x612&w=0&k=20&c=eG7i2WH3JOmjaKP6FfK7B36VTK16QP0jvSaUW8DOpHY=',
    'https://img.freepik.com/free-vector/flat-world-emoji-day-background-with-emoticons_23-2149427424.jpg?semt=ais_hybrid',
    'https://img.freepik.com/premium-vector/dark-blue-abstract-background_1378-176.jpg?semt=ais_hybrid',
    'https://i.pinimg.com/236x/31/be/f7/31bef72331b8bbf76d6738a375fb9bff.jpg',
    'https://t4.ftcdn.net/jpg/04/88/23/97/360_F_488239763_kZ0IyHirUrhkT6SPL2fRamKSSQIYmC2T.jpg',
  ];
  int inx = 0;
  void changeBgInx(int index) {
    inx = index;
    update();
  }

  void logOut() {
    FirebaseAuthService.auth.logoutUser();
    Get.offNamed(AppRoutes.login);
  }
}
