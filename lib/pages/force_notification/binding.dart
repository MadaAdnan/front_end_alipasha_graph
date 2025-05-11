import 'package:get/get.dart';

import 'logic.dart';

class ForceNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForceNotificationLogic());
  }
}
