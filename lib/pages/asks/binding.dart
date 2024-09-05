import 'package:get/get.dart';

import 'logic.dart';

class AsksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AsksLogic());
  }
}
