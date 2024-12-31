import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ActivePrivacyMiddleware extends GetMiddleware {
  GetStorage box = GetStorage('ali-pasha');

  RouteSettings? redirect(String? route) {
    bool hasUser = box.hasData('privacy');
    if (!hasUser) {
      //UserModel user = UserModel.fromJson(box.read('user'));

        return RouteSettings(name: ACTIVE_PRIVACY);

      // إذا كان المستخدم لديه توكن، توجهه إلى الصفحة الرئيسية

    }
      // إذا لم يكن لدى المستخدم توكن، توجهه إلى صفحة تسجيل الدخول
      return super.redirect(route);

  }
}
