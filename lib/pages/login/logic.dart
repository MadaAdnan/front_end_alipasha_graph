import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/push_notification_service.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class LoginLogic extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? token;

  ///
  RxBool loading = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    PushNotificationService.init().then((value) {
      token = value;
    });
  }

  login() async {
    loading.value=true;
    try {
      mainController.query('''
mutation Login {
    login(email: "${usernameController.text}", password: "${passwordController.text}", device_token: "${token ?? ''}") {
        token
        user {
            name
            seller_name
            email
            level
            address
            image
            logo
            is_delivery
            affiliate
            info
            city {
                name
            }
            total_balance
            total_point
        }
    }
}

''');
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['login'] != null) {
       // mainController.logger.e(res?.data?['data']?['login']);
        UserModel user =
            UserModel.fromJson(res?.data?['data']?['login']?['user']);
        mainController.setUser(user: user, isWrite: true);
        mainController.setToken(
            isWrite: true, token: res?.data?['data']?['login']?['token']);
        Get.offAndToNamed(HOME_PAGE);
      }
    } catch (e) {
      mainController.logger.e("Login Error ${e}");
    }
    loading.value=false;
  }
}
