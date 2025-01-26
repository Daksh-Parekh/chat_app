import 'package:chat_app/services/firebase_auth_service.dart';
import 'package:chat_app/utils/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString name = "ABC".obs;
  RxString email = "abc@gmail.com".obs;
  RxString image =
      "https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369989.png"
          .obs;

  void getCurrentUserData() {
    var user = FirebaseAuthService.auth.checkUserStatus;
    if (user != null) {
      name.value =
          user.displayName ?? user.email?.split('@')[0].toUpperCase() ?? "ABC";
      email.value = user.email ?? "abc@gmail.com";
      image.value = user.photoURL ??
          "https://png.pngtree.com/png-clipart/20231019/original/pngtree-user-profile-avatar-png-image_13369989.png";
    }
  }

  void logOut() {
    FirebaseAuthService.auth.logoutUser();
    Get.offNamed(AppRoutes.login);
  }
}
