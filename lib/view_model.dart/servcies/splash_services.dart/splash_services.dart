import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../local_storage_services/local_storage_methods_services.dart';

class SplashServices {
  startTimer() async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      final token = LocalStorageMethods.instance.getUserApiToken();
      print("SplashLocalToken : $token");

      if (token == null || token.isEmpty) {
        Get.toNamed(Pages.signin);
      } else {
        Get.toNamed(Pages.home);
      }
    });
  }
}
