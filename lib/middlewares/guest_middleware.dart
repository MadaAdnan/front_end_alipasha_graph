import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GuestMiddleware extends GetMiddleware {
  GetStorage box = GetStorage('ali-pasha');

  RouteSettings? redirect(String? route) {
    bool hasToken = box.hasData('token') && box.read('token') != null;

    if (hasToken) {
      // إذا كان المستخدم لديه توكن، توجهه إلى الصفحة الرئيسية
      return RouteSettings(name: HOME_PAGE);
    } else {
      // إذا لم يكن لدى المستخدم توكن، توجهه إلى صفحة تسجيل الدخول
      return super.redirect(route);
    }
  }
}
