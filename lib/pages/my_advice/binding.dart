import 'package:get/get.dart';

import 'logic.dart';

class MyAdviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAdviceLogic());
  }
}
