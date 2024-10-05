import 'package:get/get.dart';

import 'logic.dart';

class ChannelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChannelLogic());
  }
}
