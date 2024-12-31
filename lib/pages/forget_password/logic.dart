import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ForgetPasswordLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  RxBool isSend = RxBool(false);
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  requestChangePassword() async {
    mainController.query.value = '''
  mutation ForgetPassword {
    forgetPassword(email: "${emailController.text}")
}
   ''';
    loading.value = true;
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['forgetPassword'] == true) {
        if(isSend.value){
          mainController.showToast(
              text: 'تم إعادة إرسال الرمز', type: 'success');
        }
        isSend.value = true;
      }
      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: res?.data?['errors']?[0]?['message'], type: 'error');
      }
    } catch (e) {}
    loading.value = false;
  }
  changePassword()async{
    mainController.query.value='''
    mutation ChangePasswordForget {
    changePasswordForget(email: "${emailController.text}", code: "${codeController.text}")
}
     ''';
    loading.value = true;
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['changePasswordForget'] == true) {
        if(isSend.value){
          mainController.showToast(
              text: 'تم إرسال كلمة المرور الجديدة إلى البريد الإلكتروني', type: 'success');
        }
        Get.offAllNamed(LOGIN_PAGE);
      }
      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: res?.data?['errors']?[0]?['message'], type: 'error');
      }
    } catch (e) {}
    loading.value = false;
  }
}
