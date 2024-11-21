import 'package:get/get.dart';

import 'logic.dart';

class MyInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyInvoiceLogic());
  }
}
