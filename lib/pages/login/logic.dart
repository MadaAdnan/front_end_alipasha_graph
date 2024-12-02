import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/push_notification_service.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../exceptions/custom_exception.dart';
import '../../helpers/google_auth.dart';

class LoginLogic extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController affiliateController = TextEditingController();
  String? token;

  ///
  RxBool loading = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    PushNotificationService.init().then((value) {
      token = value;
    });
  }

  login() async {
    loading.value = true;
    // mainController.showToast(text: token);
    try {
      mainController.query('''
mutation Login {
    login(email: "${usernameController.text}", password: "${passwordController.text}", device_token: "${token ?? ''}") {
        token   
        ${AUTH_USER}
    }
}

''');
      dio.Response? res = await mainController.fetchData();
      //  mainController.logger.e(res?.data?['data']?['login']?['user']);
      if (res?.data?['data']?['login'] != null) {
        mainController.setUserJson(json: res?.data?['data']?['login']?['user']);
        mainController.setToken(
            isWrite: true, token: res?.data?['data']?['login']?['token']);
        Get.offAndToNamed(HOME_PAGE);
      }
      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: '${res?.data['errors'][0]['message']}', type: 'error');
      }
    } catch (e) {
      mainController.logger.e("Login Error ${e}");
    }
    loading.value = false;
  }

  Future<void> registerGoogel() async {
    Map<String, String>? user = await GoogleAuth.signin();
    if (user == null) {
      return;
    }
    String input = "ali-pasha5${DateTime.now().day}";
    var bytes = utf8.encode(input);
    var hash = md5.convert(bytes);
    loading.value = true;
    mainController.query.value = '''
mutation CreateGoogleUser(\$input:CreateGoogleUserInput) {
    createGoogleUser(
        input: \$input
    ) {
        token
        user {
           $AUTH_FIELDS
        }
    }
}

''';
    mainController.variables.value = {
      'input': {
        "name": "${user['name']}",
        "email": "${user['email']}",
        "password": "${user['password']}",
        "device_token": "${token ?? ''}",
        "affiliate": "${affiliateController.text??''}",
        "hash": "${hash}"
      }
    };
    try {
      dio.Response? res = await mainController.fetchData();
      loading.value = false;

     // mainController.logger.e(res?.data);
      if (res?.data?['data']?['createGoogleUser']?['token'] != null) {
        await mainController.setToken(
            token: res?.data?['data']?['createGoogleUser']?['token'],
            isWrite: true);

        await mainController.setUserJson(
            json: res?.data?['data']?['createGoogleUser']?['user']);
        Get.offAndToNamed(HOME_PAGE);
      }

      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: '${res?.data['errors'][0]['message']}', type: 'error');
      }
    } catch (e) {
      mainController.showToast(text: '$e', type: 'error');
    }
    loading.value = false;
  }
}
