import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ServiceDetailsLogic extends GetxController {
  Rx<ProductModel> serviceModel = Rx<ProductModel>(Get.arguments);
  Rxn<ProductModel> service = Rxn<ProductModel>(null);
  RxBool loading = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(serviceModel, (value) {
      getService();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  getService() async {
    mainController.query.value = '''
    query Product {
    product(id: "${serviceModel.value.id}") {
        product {
            id
            user {
                name
                seller_name
                image
                logo
                open_time
                close_time
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
            name
            info
            tags
            phone
            email
            address
            url
            longitude
            latitude
            views_count
            video
            images
            created_at
        }
    }
}

     ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['product']['product'] != null) {
        service.value =
            ProductModel.fromJson(res?.data?['data']?['product']['product']);
      }
    } catch (e) {
      mainController.logger.e("Error Get Service Details $e");
    }
  }
}
