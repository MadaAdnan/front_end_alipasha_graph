import 'package:get/get.dart';

import 'logic.dart';

class GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupLogic());
  }
}
