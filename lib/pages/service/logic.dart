import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';

class ServiceLogic extends GetxController {
  CategoryModel categoryModel = Get.arguments;
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxList<ProductModel> products = RxList<ProductModel>([]);

  RxInt page = RxInt(1);
  MainController mainController = Get.find<MainController>();

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) {
      getService();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getService();
  }

  getService() async {
    loading.value = true;
    mainController.query.value = '''
    query MainCategories {
    products(first: 15, sub1_id: ${categoryModel.id}, page: $page) {
        paginatorInfo {
            hasMorePages
        }
        data {
            user {
                name
                seller_name
                image
                logo
            }
            city {
                name
            }
            sub1 {
                name
            }
            name
            address
            views_count
            image
            created_at
        }
    }
}

     ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['products']?['paginatorInfo'] != null) {
        hasMorePage.value =
            res?.data?['data']?['products']?['paginatorInfo']?['hasMorePages'];
      }

      if (res?.data?['data']?['products']?['data'] != null) {
        for (var item in res?.data?['data']?['products']?['data']) {
          products.add(ProductModel.fromJson(item));
        }
      }
    } catch (e) {
      mainController.logger.e("Error Get Service $e");
    }
    loading.value = false;
  }
}
