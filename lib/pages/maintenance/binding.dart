import 'package:get/get.dart';

import 'logic.dart';

class MaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MaintenanceLogic());
  }
}
