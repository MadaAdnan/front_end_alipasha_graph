import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class NewDetailsLogic extends GetxController {
  RxBool loading = RxBool(false);
  Rxn<ProductModel> post = Rxn<ProductModel>(null);
  RxnInt postId = RxnInt(null);
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    postId.value = int.tryParse("${Get.parameters['id']}");
    // TODO: implement onReady
    super.onReady();
    getPost();
  }

  getPost() async {

    loading.value = true;
    mainController.query.value = '''
  query Product {
    product(id: "${postId.value}") {
        product {
            id
            name
            info
            tags
            level
            url
            views_count
            image
            video
            created_at
            category {
                name
            }
            sub1 {
              name
            }
        }
    }
  }
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.i(res?.data);
      loading.value = false;
      if (res?.data?['data']?['product']['product'] != null) {
        post.value =
            ProductModel.fromJson(res?.data?['data']?['product']['product']);
      }
    } catch (e) {}
    loading.value = false;
  }
}
