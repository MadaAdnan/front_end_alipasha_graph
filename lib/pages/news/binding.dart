import 'package:get/get.dart';

import 'logic.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsLogic());
  }
}
