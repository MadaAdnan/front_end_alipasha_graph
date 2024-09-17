import 'package:get/get.dart';

import 'logic.dart';

class EditTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditTenderLogic());
  }
}
