import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../models/product_model.dart';
import 'package:dio/dio.dart' as dio;

class TendersLogic extends GetxController {

  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> tenders = RxList<ProductModel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataFromStorage();
    ever(page, (value) {
      getTenders();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getTenders();
  }

  void nextPage() {
    if (hasMorePage.value) {
      page.value += 1;
    }
  }

  Future<void> getTenders() async {
    mainController.query.value = '''
    query Products {
    products(type: "tender", first: 15, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            user {
            id
                seller_name
                logo
                image
                  is_verified
            }
            city {
                name
            }
            category {
                name
            }
            sub1 {
                name
            }
            expert
            name
            level
            address
            start_date
            end_date
            code
            type
            views_count
            created_at
        }
    }
}

    ''';
    try {
loading.value=true;
      dio.Response? res = await mainController.fetchData();

      if (res?.data?['data']?['products']?['paginatorInfo'] != null) {
        hasMorePage.value = bool.tryParse(
            "${res?.data?['data']?['products']?['paginatorInfo']?['hasMorePages']}") ??
            false;
      }
      if (res?.data?['data']?['products']?['data'] != null) {
        if(page.value==1){
          tenders.clear();
        }
        for (var item in res?.data?['data']?['products']?['data']) {
          tenders.add(ProductModel.fromJson(item));
        }
        if(mainController.storage.hasData('tenders')){
          mainController.storage.remove('tenders');
        }
        await mainController.storage.write('tenders', res?.data?['data']?['products']?['data'] );
      }
    }  catch (e) {
      mainController.logger.e("Error Tenders Pge ${e}");
    }
    loading.value=false;
  }

  getDataFromStorage() {
    var listProduct = mainController.storage.read('tenders')??[];

    for (var item in listProduct) {
      tenders.add(ProductModel.fromJson(item));
    }
  }
}
