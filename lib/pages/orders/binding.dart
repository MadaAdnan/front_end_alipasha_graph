import 'package:get/get.dart';

import 'logic.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersLogic());
  }
}
