import 'package:get/get.dart';

import 'logic.dart';

class SellersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellersLogic());
  }
}
