import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../models/product_model.dart';

class ProductsLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxInt page = RxInt(1);
  UserModel seller = Get.arguments;
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<AdviceModel> advices = RxList<AdviceModel>([]);

  void nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) {
      getProducts();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProducts();
  }

  getProducts() async {
    loading.value = true;

    mainController.query.value = '''
   query Products {
    products(user_id: ${seller.id}, first: 15, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            expert
            type
            is_discount
            is_delivary
            is_available
            price
            views_count
            discount
            end_date
            type
            level
            image
            created_at
            user {
            id
                seller_name
                logo
            }
          
            city {
                name
            }
            start_date
              sub1 {
                name
            }
            category {
                name
            }
        }
    }
    advices (user_id: ${seller.id}) {
        name
        user {
            id
            name
            seller_name
        }
        url
        image
        id
    }
}

  ''';
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.e(res?.data);
      if (res?.data?['data']?['products']?['paginatorInfo'] == null) {
        hasMorePage.value =
            res?.data?['data']?['products']?['paginatorInfo']['hasMorePages'];
      }
      mainController.logger.w(products.length);
      if (res?.data?['data']?['products']?['data'] != null) {
        for (var item in res?.data?['data']?['products']?['data']) {
          products.add(ProductModel.fromJson(item));

        }

      }

      if (res?.data?['data']?['advices'] != null) {
        for (var item in res?.data?['data']?['advices']) {
          advices.add(AdviceModel.fromJson(item));

        }

      }
      mainController.logger.w(products.length);
    } catch (e) {
      mainController.logger.e('Error Get Products By Seller $e');
    }

    loading.value = false;
  }
}
