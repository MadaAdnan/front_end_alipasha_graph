import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../Global/main_controller.dart';
import '../../models/ask_model.dart';
import 'package:dio/dio.dart' as dio;

class AskLogic extends GetxController {
  RxBool loading = RxBool(false);
  Rxn<AskModel> ask = Rxn<AskModel>(null);
  AskModel askModel = Get.arguments;
  MainController mainController = Get.find<MainController>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (ask.value == null) {
      getAsk();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getAsk() async {
    loading.value = true;
    mainController.query.value = '''
query Question {
    question(id: "${askModel.id}") {
        id
        ask
        answer
        image
    }
}

     ''';
    try {
      dio.Response? response = await mainController.fetchData();
      if (response?.data['data']['question'] != null) {
        ask.value = AskModel.fromJson(response?.data['data']['question']);
      }
    } catch (e) {
      mainController.logger.e("Error get Asks $e");
    }
    loading.value = false;
  }
}
