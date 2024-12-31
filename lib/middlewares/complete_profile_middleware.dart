
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class CompleteProfileMiddleware extends GetMiddleware {
  GetStorage box = GetStorage('ali-pasha');

  RouteSettings? redirect(String? route) {
    bool hasUser = box.hasData('user') && box.read('user') != null;
    if (hasUser) {
      UserModel user = UserModel.fromJson(box.read('user'));
      if((user.phone=='' || user.address=='')){
        messageBox(title: 'لم تكمل البيانات', message: 'من فضلك قم بتعبئة البيانات الخاصة بك',isError: true);

        return RouteSettings(name: Edit_PROFILE_PAGE);
      }
      // إذا كان المستخدم لديه توكن، توجهه إلى الصفحة الرئيسية

    }
    // إذا لم يكن لدى المستخدم توكن، توجهه إلى صفحة تسجيل الدخول
    return super.redirect(route);

  }
}