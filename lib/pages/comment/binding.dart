import 'package:get/get.dart';

import 'logic.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommentLogic());
  }
}
