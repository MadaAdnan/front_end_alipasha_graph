
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

    if (!hasUser) {
      return RouteSettings(name: LOGIN_PAGE);
    }

    return super.redirect(route);
  }
}
