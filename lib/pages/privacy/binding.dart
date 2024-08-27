import 'package:get/get.dart';

import 'logic.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyLogic());
  }
}
