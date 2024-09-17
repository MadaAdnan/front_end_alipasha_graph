import 'package:get/get.dart';

import 'logic.dart';

class CartItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartItemLogic());
  }
}
