import 'package:ali_pasha_graph/Global/main_controller.dart';

import 'package:ali_pasha_graph/helpers/queries.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;

import '../../models/setting_model.dart';

class MenuLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxnString selectedValue1 = RxnString(null);
  RxnString selectedValue2 = RxnString('settings');
  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool loadingBay = RxBool(false);
  RxnString message = RxnString(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    mainController.pusher.subscribe('change-setting').bind('update-setting',
            (event) {
          mainController.settings.value = SettingModel.fromJson(event['setting']);
          mainController.logger.d(event);
        });

  }

  changeSelectedValue1(String? value) {
    selectedValue1.value = value;
    switch (value) {
      case 'privacy':
        Get.offAndToNamed(PRIVACY_PAGE);
        break;
      case 'asks':
        Get.offAndToNamed(ASKS_PAGE);
        break;
      case 'contact_us':
        Get.offAndToNamed(CONTACT_US_PAGE);
        break;
    }
  }

  changeSelectedValue2(String? value) {
    switch (value) {
      case 'about':
        Get.offAndToNamed(ABOUT_PAGE);
        break;
      case 'settings':
        //Get.offAndToNamed(ABOUT_PAGE);
        break;
      case 'logOut':
        mainController.logout();
        break;
    }
  }

  charge() async {
    loadingBay.value = true;
    mainController.query.value = '''
  mutation Charge {
    charge(code: "${codeController.text}", password: "${passController.text}") {
        $AUTH_FIELDS
    }
}

   ''';
    try {
      dio.Response? res = await mainController.fetchData();

      if (res?.data['data']?['charge'] != null) {
        mainController.setUserJson(json: res?.data['data']?['charge']);
        message.value = 'تم الشحن بنجاح';
        loadingBay.value = false;
      }

      if (res?.data['errors'][0]['message'] != null) {
        message.value = '${res?.data['errors'][0]['message']}';
      }
    } catch (e) {
      mainController.logger.e(e);
    }
    loadingBay.value = false;


  }
}
