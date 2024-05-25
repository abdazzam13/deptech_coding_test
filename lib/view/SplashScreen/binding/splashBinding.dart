import 'package:get/get.dart';

import '../controller/SplashScreenController.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
