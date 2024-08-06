import 'package:get/get.dart';

import 'logic.dart';

class SectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SectionLogic());
  }
}
