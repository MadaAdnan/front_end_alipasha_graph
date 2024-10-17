import 'package:get/get.dart';

import 'logic.dart';

class CreateCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCommunityLogic());
  }
}
