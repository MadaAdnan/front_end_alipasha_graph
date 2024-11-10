import 'package:get/get.dart';

import 'logic.dart';

class RestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantLogic());
  }
}
