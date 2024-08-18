import 'package:get/get.dart';

import 'logic.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsLogic());
  }
}
