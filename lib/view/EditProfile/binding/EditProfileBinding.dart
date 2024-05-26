import 'package:get/get.dart';

import '../controller/EditProfileController.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}
