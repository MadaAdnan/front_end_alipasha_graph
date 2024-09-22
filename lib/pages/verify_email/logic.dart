import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class VerifyEmailLogic extends GetxController {
  MainController mainController = Get.find<MainController>();

  TextEditingController codeController = TextEditingController();

  RxBool loading = RxBool(false);
  RxnString error = RxnString(null);

  @override
  onInit() {
    super.onInit();
   // mainController.logger.i(mainController.storage.read('token'));
  }

  verify() async {
    loading.value = true;
    mainController.query.value = '''
   mutation VerifyEmail {
    verifyEmail(code: "${codeController.text}") {
        name
        id
        seller_name
        email_verified_at
        email
        level
        phone
        image
        logo
        address
        open_time
        close_time
        is_delivery
        is_restaurant
        is_active
        affiliate
        info
        city {
            name
        }
        total_balance
        total_point
    }
}

    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      //mainController.logger.e(res?.data);
      if (res?.data?['errors']?[0]?['extensions'] != null) {
        error.value = res?.data?['errors']?[0]?['extensions']?['debugMessage'];
      }
      if (res?.data?['data']?['verifyEmail'] != null) {
        if (res?.data?['data']?['verifyEmail']?['email_verified_at'] != null) {
          mainController.setUserJson(json: res?.data?['data']?['verifyEmail']);
          Get.offAndToNamed(HOME_PAGE);
        }
      }
    } on CustomException catch (e) {
      print('Error $e');
    }
    loading.value = false;
  }

  resendVerifyCode() async {
    loading.value = true;
    mainController.query.value = '''
  query ResendEmailVerify {
    resendEmailVerify {
        name
        seller_name
        id
    }
}


    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.e(res?.data);
      if (res?.data?['errors']?[0]?['extensions'] != null) {
        error.value = res?.data?['errors']?[0]?['extensions']?['debugMessage']??null;
      }
      if (res?.data?['data']?['resendEmailVerify'] != null) {
        Get.snackbar('', '',duration: Duration(seconds: 3),titleText: Center(child: Text('نجاح العملية',style: H3RedTextStyle,)),messageText: Center(child: Text('تم إعادة إرسال كود التفعيل',style: H3BlackTextStyle,)));
      }
    } on CustomException catch (e) {
      print('Error $e');
    }
    loading.value = false;
  }
}
