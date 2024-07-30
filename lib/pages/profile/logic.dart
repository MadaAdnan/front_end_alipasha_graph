import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class ProfileLogic extends GetxController {
  RxInt pageSelected = RxInt(0);
  TextEditingController searchController = TextEditingController();
  RxBool loading = RxBool(false);

  // Data From Api
  //  products Page
  RxList<ProductModel> products = RxList<ProductModel>([]);

// chart page
  RxList<AdviceModel> myAdvices = RxList<AdviceModel>([]);
  RxInt adviceCount = RxInt(0);
  RxInt views = RxInt(0);
  RxInt sliderCount = RxInt(0);
  RxDouble myBalance = RxDouble(0);
  RxDouble myPoint = RxDouble(0);
  RxDouble myWins = RxDouble(0);

  /////
  RxString search = RxString('');
  MainController mainController = Get.find<MainController>();
  RxInt page = 1.obs;
  RxBool hasMorePage = RxBool(false);
  PageController pageController = PageController(
    initialPage: 0,
  );

  nextPage() {
    page.value = page.value + 1;
  }

  @override
  void onInit() {
    super.onInit();

    ever(page, (value) {
      getProduct();
    });
    ever(search, (value) {
      if (page.value == 1) {
        getProduct();
      } else {
        page.value = 1;
      }
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (pageSelected.value == 0 && page.value == 1) {
      getProduct();
    }
    if (myAdvices.length == 0) {
      getMyAdvice();
    }
  }

  getProduct() async {
    loading.value = true;
    if (page.value == 1) {
      products.clear();
    }
    mainController.query('''
    query MyProducts {
      myProducts(first: 15, page: ${page} ,search:"${search.value ?? ''}") {
         paginatorInfo {
            hasMorePages
         }
        data {
            id
            name
            expert
            is_available
            level
            active
            type
            views_count
            image
            category {
              name
            }
            sub1 {
                name
            }
        }
      }
    }

    ''');
    try {
      dio.Response? res = await mainController.fetchData();

      mainController.logger.i(res?.data);
      if (res?.data?['data']?['myProducts'] != null) {
        hasMorePage(
            res?.data['data']?['myProducts']['paginatorInfo']['hasMorePages']);
        for (var item in res?.data['data']['myProducts']['data']) {
          products.add(ProductModel.fromJson(item));
        }
      }
    } on CustomException catch (e) {
      mainController.logger.e(e);
    }
    loading.value = false;
  }

  getMyAdvice() async {
    mainController.query('''
  query MyAdvice {
    myAdvice {
        advice_count
        my_balance
        my_point
        my_wins
        views
        slider_count
        advices {
            name
            id
            expired_date
            views_count
        }
    }
}
    ''');
    dio.Response? res = await mainController.fetchData();

    if (res != null) {
      // mainController.logger.i(res.data);
      for (var item in res.data['data']['myAdvice']['advices']) {
        myAdvices.add(AdviceModel.fromJson(item));
      }
      views.value =
          int.tryParse("${res.data['data']['myAdvice']['views']}") ?? 0;
      sliderCount.value =
          int.tryParse("${res.data['data']['myAdvice']['slider_count']}") ?? 0;
      adviceCount.value =
          int.tryParse("${res.data['data']['myAdvice']['advice_count']}") ?? 0;
      myBalance.value =
          double.tryParse("${res.data['data']['myAdvice']['my_balance']}") ?? 0;
      myPoint.value =
          double.tryParse("${res.data['data']['myAdvice']['my_point']}") ?? 0;
      myWins.value =
          double.tryParse("${res.data['data']['myAdvice']['my_wins']}") ?? 0;
    }
  }
}
