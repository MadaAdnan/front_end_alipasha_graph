import 'package:get/get.dart';

import 'logic.dart';

class SectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SectionsLogic());
  }
}
