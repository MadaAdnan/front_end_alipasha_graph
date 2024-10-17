import 'package:get/get.dart';

import 'logic.dart';

class FollowingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowingLogic());
  }
}
