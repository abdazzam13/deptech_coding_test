import 'package:get/get.dart';

import '../controller/EventController.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());
  }
}
