import 'package:get/get.dart';

import 'logic.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterLogic());
  }
}
