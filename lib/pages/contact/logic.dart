import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/setting_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../models/social_model.dart';

class ContactLogic extends GetxController {
  RxBool loading = RxBool(false);
  Rxn<SocialModel> social = Rxn<SocialModel>(null);
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
    getSocial();
  }

  getSocial() async {
    loading.value = true;
    mainController.query.value='''
    query Settings {
    settings {
        social {
            twitter
            face
            instagram
            youtube
            linkedin
            telegram
            name
            email
            sub_email
            phone
            sub_phone
        }
    }
}

     ''';
    try {
      dio.Response? res = await mainController.fetchData();
     // mainController.logger.i(res?.data?['data']?['settings']?['social']);
      if(res?.data?['data']?['settings']?['social']!=null){
        social.value=SocialModel.fromJson(res?.data?['data']?['settings']?['social']);
      }
    } catch (e) {
      mainController.logger.e("Error Get Social: $e");
    }
    loading.value = false;
  }
}
