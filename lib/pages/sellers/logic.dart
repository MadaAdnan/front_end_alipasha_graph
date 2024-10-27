import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../models/partner_model.dart';
import 'package:dio/dio.dart' as dio;

class SellersLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxList<PartnerModel> sellers = RxList<PartnerModel>([]);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  Rxn<CategoryModel> selectedCity = Rxn<CategoryModel>(null);

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {

    super.onInit();
   // categories(mainController.categories.where((el)=>el.type=='product').toList());
    ever(page, (value) {
      getSellers();
    });

    ever(selectedCity, (value) {

      sellers([]);
      if(page.value!=1){
        page.value=1;
      }else{
        getSellers();
      }


    });
  }

  @override
  onReady() {
    super.onReady();
    getSellers();
  }

  getSellers() async {
    loading.value = true;
    mainController.query.value = '''
    query Sellers {
    sellers(first: 25, page: ${page.value} ${selectedCity.value!=null ? ',category_id:"${selectedCity.value?.id}"':''}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            name
            city {
                name
            }
            address
            phone
            info
            image
        }
    }
    
    ${page.value==1? ''' mainCategories(type: "product") {
        id
        name
        image
    } ''':''}
}

     ''';
    try {
      dio.Response? response = await mainController.fetchData();
      mainController.logger
          .e(response?.data['data']['sellers']);
      if (response?.data['data']['sellers']?['paginatorInfo'] != null) {
        hasMorePage.value = response?.data['data']['sellers']?['paginatorInfo']
                ['hasMorePages'] ??
            false;
      }
      if (response?.data['data']['sellers']?['data'] != null) {

        for (var item in response?.data['data']['sellers']?['data']) {
          sellers.add(PartnerModel.fromJson(item));
        }
      }
      if (response?.data['data']['mainCategories'] != null && categories.length==0) {

        for (var item in response?.data['data']['mainCategories'] ) {
          categories.add(CategoryModel.fromJson(item));
        }
      }
    } catch (e) {
      mainController.logger
          .e("Error get Sellers $e");
    }
    loading.value = false;
  }
}
