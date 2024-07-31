import 'package:get/get.dart';

import 'logic.dart';

class TendersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TendersLogic());
  }
}
