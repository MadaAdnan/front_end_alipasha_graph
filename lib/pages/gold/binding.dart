import 'package:get/get.dart';

import 'logic.dart';

class GoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoldLogic());
  }
}
