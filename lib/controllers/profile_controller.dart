import 'package:get/get.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/utils/app_routes.dart';

class ProfileController extends GetxController {

  Future<void> logout() async {
    await UserTokenPref.clearToken();
    Get.offAllNamed(AppRoutes.auth);
  }
}
