import 'package:get/get.dart';

import 'logic.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductLogic());
  }
}
