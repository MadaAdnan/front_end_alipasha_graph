import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import 'package:dio/dio.dart' as dio;
class AboutLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxnString about = RxnString(null);

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
    getAbout();
  }

  getAbout() async {
    loading.value = true;
    mainController.query.value = '''
    query Settings {
    settings {
        about
    }
}
    ''';
    try {
      dio.Response? res= await mainController.fetchData();
      if(res?.data?['data']?['settings']!=null) {
        about.value = res?.data?['data']?['settings']?['about'];
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e("Error get About $e");
    }

    loading.value = false;
  }
}
