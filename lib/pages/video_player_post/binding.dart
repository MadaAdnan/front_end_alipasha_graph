import 'package:get/get.dart';

import 'logic.dart';

class VideoPlayerPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoPlayerPostLogic());
  }
}
