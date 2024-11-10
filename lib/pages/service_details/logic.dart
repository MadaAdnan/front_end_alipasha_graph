import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ServiceDetailsLogic extends GetxController {
  Rxn<ProductModel> serviceModel = Rxn<ProductModel>(null);
  RxBool loading = RxBool(false);
  RxnInt serviceId =
      RxnInt(null);
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(serviceId, (value) {
      getService();
    });
  }

  @override
  void onReady() {
    serviceId.value=int.tryParse("${Get.parameters['id']}");
    // TODO: implement onReady
    super.onReady();
    getService();
  }

  getService() async {
    mainController.query.value = '''
    query Product {
    product(id: "${serviceId.value}") {
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
      mainController.logger.w(res?.data);
      if (res?.data?['data']?['product']['product'] != null) {
        serviceModel.value =
            ProductModel.fromJson(res?.data?['data']?['product']['product']);
      }
    } catch (e) {
      mainController.logger.e("Error Get Service Details $e");
    }
  }
}
