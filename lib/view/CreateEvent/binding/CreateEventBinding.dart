import 'package:get/get.dart';

import '../controller/CreateEventController.dart';

class CreateEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateEventController());
  }
}
