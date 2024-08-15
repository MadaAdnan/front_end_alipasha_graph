import 'package:get/get.dart';

import 'logic.dart';

class CommunitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunitiesLogic());
  }
}
