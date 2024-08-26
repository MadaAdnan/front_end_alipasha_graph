import 'package:get/get.dart';

import 'logic.dart';

class ServiceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceDetailsLogic());
  }
}
