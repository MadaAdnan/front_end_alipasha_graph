import 'package:get/get.dart';

import 'logic.dart';

class JobsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobsLogic());
  }
}
