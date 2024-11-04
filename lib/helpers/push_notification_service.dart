
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token = null;

  static Future<String?> init() async {
    await messaging.requestPermission();
    token = await messaging.getToken();
    //Get.find<MainController>().logger.i(token);
    FirebaseMessaging.onBackgroundMessage(handelBackGroundMessage);
    FirebaseMessaging.onMessageOpenedApp.first.then((value) {
      print("test");
    });

    FirebaseMessaging.onMessageOpenedApp;
    return token;
  }

  static Future<void> handelBackGroundMessage(RemoteMessage rm) async {
    // await  Firebase.initializeApp( );
    Get.find<MainController>().logger.i(rm.notification?.title);
  }
}
