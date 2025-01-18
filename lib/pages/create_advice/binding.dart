import 'package:get/get.dart';

import 'logic.dart';

class CreateAdviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateAdviceLogic());
  }
}
