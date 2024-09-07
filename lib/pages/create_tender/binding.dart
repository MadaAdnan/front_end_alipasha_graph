import 'package:get/get.dart';

import 'logic.dart';

class CreateTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTenderLogic());
  }
}
