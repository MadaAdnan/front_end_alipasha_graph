import 'package:get/get.dart';

import 'logic.dart';

class PdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PdfLogic());
  }
}
