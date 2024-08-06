import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProductLogic extends GetxController {
  RxBool loading = RxBool(false);
  MainController mainController = Get.find<MainController>();
  RxnInt productId = RxnInt(null);

  Rxn<ProductModel> product = Rxn<ProductModel>(null);
  RxList<ProductModel> products = RxList<ProductModel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    productId.value = Get.arguments;
    ever(productId, (value){
      getProduct();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProduct();
  }

  getProduct() async {
    loading.value = true;
    products.clear();
    mainController.query.value = '''
    query Product {
    product(id: "${productId.value}") {
        product {
            id
            user {
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
            colors {
                code
            }
            name
            info
            tags
            is_discount
            level
            phone
            email
            address
            url
            longitude
            latitude
            price
            discount
            start_date
            end_date
            code
            type
            views_count
            turkey_price {
                price
                discount
            }
            image
            video
            images
            docs
            created_at
        }
        products {
        id
            name
            expert
            user {
                seller_name
                logo
            }
            city {
                name
            }
            level
            price
            discount
            start_date
            end_date
            code
            type
            views_count
            image
            is_discount
        }
    }
}

    ''';

    try {
      dio.Response? res = await mainController.fetchData();

      loading.value = false;
      if (res?.data?['data']?['product']['product'] != null) {
        // mainController.logger.e(res?.data?['data']?['product']);
        product.value =
            ProductModel.fromJson(res?.data?['data']?['product']['product']);
      }

      if (res?.data?['data']?['product']['products'] != null) {
        for (var item in res?.data?['data']?['product']['products']) {
          products.add(ProductModel.fromJson(item));
        }
      }
    } on CustomException catch (e) {
      mainController.logger.e(e.message);
    }

    loading.value = false;
  }
}
