import 'package:get/get.dart';

import 'logic.dart';

class LiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveLogic());
  }
}
