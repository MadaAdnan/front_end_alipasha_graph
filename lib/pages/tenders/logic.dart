import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../models/product_model.dart';
import 'package:dio/dio.dart' as dio;

class TendersLogic extends GetxController {
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> tenders = RxList<ProductModel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) {
      getJobs();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getJobs();
  }

  void nextPage() {
    if (hasMorePage.value) {
      page.value += 1;
    }
  }

  Future<void> getJobs() async {
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

      dio.Response? res = await mainController.fetchData();
      mainController.logger.e(res?.data);
      if (res?.data?['data']?['products']?['paginatorInfo'] != null) {
        hasMorePage.value = bool.tryParse(
            "${res?.data?['data']?['products']?['paginatorInfo']?['hasMorePages']}") ??
            false;
      }
      if (res?.data?['data']?['products']?['data'] != null) {
        for (var item in res?.data?['data']?['products']?['data']) {
          tenders.add(ProductModel.fromJson(item));
        }
      }
    }  catch (e) {
      mainController.logger.e("Error Tenders Pge ${e}");
    }
  }
}
