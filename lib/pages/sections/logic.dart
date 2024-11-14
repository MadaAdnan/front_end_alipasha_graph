import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
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
    getDataFromStorage();
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
    mainCategories (type: "product"){
        id
        name
        color
        type
        image
        products_count
    }
}

    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.e(res?.data?['data']?['mainCategories']);
      if (res?.data?['data']?['mainCategories'] != null) {
        for (var item in res?.data?['data']?['mainCategories']) {
          categories.add(CategoryModel.fromJson(item));
        }
        if(mainController.storage.hasData('sections')){
          mainController.storage.remove('sections');
        }
        await mainController.storage.write('sections', res?.data?['data']?['mainCategories']);
      }
    } on CustomException catch (e) {}
    loading.value = false;
  }

  isVisit(int id,int count){
   if( mainController.storage.hasData('sectionID.${id}')){

     var oldCount= mainController.storage.read('sectionID.${id}');
     mainController.logger.d("DDD ${oldCount!=count}");
     if(oldCount!=count){
       return false;
     }else{
       return true;
     }
   }
   return false;
  }

  visit(int id,int count)async{
      await mainController.storage.write('sectionID.${id}',count);
  }

  getDataFromStorage() {
    var listProduct = mainController.storage.read('sections')??[];

    for (var item in listProduct) {
      categories.add(CategoryModel.fromJson(item));
    }
  }
}
