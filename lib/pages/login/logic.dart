import 'package:ali_pasha_graph/helpers/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    PushNotificationService.init();

  }


}
