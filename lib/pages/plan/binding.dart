import 'package:get/get.dart';

import 'logic.dart';

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlanLogic());
  }
}
