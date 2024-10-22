import 'package:get/get.dart';

import 'logic.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryLogic());
  }
}
