import 'package:get/get.dart';

import 'logic.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServicesLogic());
  }
}
