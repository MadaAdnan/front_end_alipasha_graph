import 'package:get/get.dart';

import 'logic.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutLogic());
  }
}
