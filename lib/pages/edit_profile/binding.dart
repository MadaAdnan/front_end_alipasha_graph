import 'package:get/get.dart';

import 'logic.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileLogic());
  }
}
