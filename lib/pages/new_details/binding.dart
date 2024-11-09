import 'package:get/get.dart';

import 'logic.dart';

class NewDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewDetailsLogic());
  }
}
