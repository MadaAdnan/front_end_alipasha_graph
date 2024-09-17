import 'package:get/get.dart';

import 'logic.dart';

class EditJobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditJobLogic());
  }
}
