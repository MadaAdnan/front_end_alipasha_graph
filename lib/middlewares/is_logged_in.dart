import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class IsLoggedIn extends GetMiddleware {
  @override
  // TODO: implement priority
  int? get priority => 1;

  GetStorage box = GetStorage('ali-pasha');

  RouteSettings? redirect(String? route) {
    bool hasUser = box.hasData('user') && box.read('user') != null;
    //  Get.find<MainController>().logger.e("Middlewaare");
    //Get.find<MainController>().logger.e(hasUser);
    if (!hasUser) {
      return RouteSettings(name: LOGIN_PAGE);
    }
    // إذا كان المستخدم لديه توكن، توجهه إلى الصفحة الرئيسية

    // إذا لم يكن لدى المستخدم توكن، توجهه إلى صفحة تسجيل الدخول
    return super.redirect(route);
  }
}
