import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/SharedPreferences.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    timer();
    print("isLogin ${SharedPref().getIsRememberMe()}");
  }

  void timer() {
    var timer = const Duration(seconds: 4);
    Timer(timer, () {
      if (SharedPref().getIsRememberMe() == true){
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.offAllNamed(AppRoutes.login);
        }

    });
  }

}