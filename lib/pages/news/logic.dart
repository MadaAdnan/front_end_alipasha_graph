import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class NewsLogic extends GetxController {
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxInt page = RxInt(1);
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> news = RxList<ProductModel>([]);

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
      getNews();
    });
  }

  @override
  void onReady() {
    super.onReady();
    getNews();
  }

  getNews() async {
    loading.value = true;
    mainController.query.value = '''
query Products {
    products(type: "news", first: 15, page:${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            user {
                name
            }
            category {
                name
                id
            }
            sub1 {
                name
                id
            }
            id
            name
            expert
            views_count
            image
            images
            created_at
        }
    }
}

''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['products']['paginatorInfo'] != null) {
        hasMorePage.value = res?.data?['data']?['products']['paginatorInfo']
                ['hasMorePages'] ??
            false;
      }
      if (res?.data?['data']?['products']['data'] != null) {
        for (var item in res?.data?['data']?['products']['data']) {
          news.add(ProductModel.fromJson(item));
        }
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e("Error get News $e");
    }
    loading.value = false;
  }
}
