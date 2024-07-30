import 'package:get/get.dart';

import 'logic.dart';

class FollowersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowersLogic());
  }
}
