import 'package:get/get.dart';

import 'logic.dart';

class AskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AskLogic());
  }
}
