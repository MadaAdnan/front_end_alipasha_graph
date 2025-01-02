
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token = null;

  static Future<String?> init() async {
    await messaging.requestPermission();
    token = await messaging.getToken();
    //Get.find<MainController>().logger.i(token);
    FirebaseMessaging.onBackgroundMessage(handelBackGroundMessage);


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //  Get.find<MainController>().showToast(text: 'I');
      Get.toNamed(NOTIFICATION_PAGE);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
     // Get.toNamed(NOTIFICATION_PAGE);
    // Get.find<MainController>().showToast(text: 'am');
      // هنا يمكن عرض تنبيه مخصص أو التعامل مع البيانات
    });

    return token;
  }

  static Future<void> handelBackGroundMessage(RemoteMessage rm) async {
    // await  Firebase.initializeApp( );
    Get.find<MainController>().logger.i(rm.notification?.title);
  }
}
