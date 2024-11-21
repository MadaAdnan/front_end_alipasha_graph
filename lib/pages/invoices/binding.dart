import 'package:get/get.dart';

import 'logic.dart';

class InvoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoicesLogic());
  }
}
