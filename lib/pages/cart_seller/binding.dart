import 'package:get/get.dart';

import 'logic.dart';

class CartSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartSellerLogic());
  }
}
