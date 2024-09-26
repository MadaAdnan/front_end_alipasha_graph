import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:toast/toast.dart';

class JobsLogic extends GetxController {
  RxBool loading =RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> jobs = RxList<ProductModel>([]);

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
    products(type: "job", first: 15, page: ${page.value}) {
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
      loading.value=true;
      dio.Response? res = await mainController.fetchData();
      mainController.logger.e(res?.data);
      if (res?.data?['data']?['products']?['paginatorInfo'] != null) {
        hasMorePage.value = bool.tryParse(
                "${res?.data?['data']?['products']?['paginatorInfo']?['hasMorePages']}") ??
            false;
      }
      if (res?.data?['data']?['products']?['data'] != null) {
        for (var item in res?.data?['data']?['products']?['data']) {
          jobs.add(ProductModel.fromJson(item));
        }
      }
    } on CustomException catch (e) {
      mainController.logger.e("Error Jobs Pge ${e.message}");
    }
    loading.value=false;
  }
}
