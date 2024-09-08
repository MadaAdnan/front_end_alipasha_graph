import 'package:get/get.dart';

import 'logic.dart';

class CreateServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateServiceLogic());
  }
}
