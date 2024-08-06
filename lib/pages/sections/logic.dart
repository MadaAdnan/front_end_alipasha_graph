import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/main.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class SectionsLogic extends GetxController {
  RxBool loading = RxBool(false);

  MainController mainController = Get.find<MainController>();
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getSections();
  }

  Future<void> getSections() async {
    loading.value = true;
    mainController.query.value = '''
    
    query MainCategories {
    mainCategories {
        id
        name
        color
        type
        image
    }
}

    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['mainCategories'] != null) {
        for (var item in res?.data?['data']?['mainCategories']) {
          categories.add(CategoryModel.fromJson(item));
        }
      }
    } on CustomException catch (e) {}
    loading.value = false;
  }
}
