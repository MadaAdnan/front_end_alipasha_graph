import 'package:get/get.dart';

import 'logic.dart';

class CreateJobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateJobLogic());
  }
}
