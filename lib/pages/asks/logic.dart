import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/ask_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AsksLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxList<AskModel> asks = RxList<AskModel>([]);

  MainController mainController = Get.find<MainController>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (asks.length == 0) {
      getAsks();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getAsks() async {
    loading.value = true;
    mainController.query.value = '''
    query Questions {
    questions {
        id
        ask
        answer
    }
}
     ''';
    try {
      dio.Response? response = await mainController.fetchData();
      if (response?.data['data']['questions'] != null) {
        for (var item in response?.data['data']['questions']) {
          asks.add(AskModel.fromJson(item));
        }
      }
      if(response?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${response?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e("Error get Asks $e");
    }
    loading.value = false;
  }
}
