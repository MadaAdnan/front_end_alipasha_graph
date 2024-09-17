import 'package:get/get.dart';

import 'logic.dart';

class EditProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProductLogic());
  }
}
