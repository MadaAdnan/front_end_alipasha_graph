import 'package:get/get.dart';

import 'logic.dart';

class PartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PartnerLogic());
  }
}
