import 'package:get/get.dart';

import 'logic.dart';

class VerifyEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyEmailLogic());
  }
}
