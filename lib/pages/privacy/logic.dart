import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:get/get.dart';
import'package:dio/dio.dart' as dio;
class PrivacyLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxnString privacy = RxnString(null);

  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getPrivacy();
  }

  getPrivacy() async {
    loading.value = true;
    mainController.query.value = '''
    query Settings {
    settings {
        privacy
    }
}
    ''';
    try {
      dio.Response? res= await mainController.fetchData();
      if(res?.data?['data']?['settings']!=null) {
        privacy.value = res?.data?['data']?['settings']?['privacy'];
      }
    } catch (e) {
      mainController.logger.e("Error get Privacy $e");
    }

    loading.value = false;
  }
}
