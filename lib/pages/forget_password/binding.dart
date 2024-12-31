import 'package:get/get.dart';

import 'logic.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordLogic());
  }
}
