import 'package:get/get.dart';

import 'logic.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationLogic());
  }
}
