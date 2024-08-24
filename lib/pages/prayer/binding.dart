import 'package:get/get.dart';

import 'logic.dart';

class PrayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrayerLogic());
  }
}
