
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;





class ProfileLogic extends GetxController {
  RxInt pageSelected = RxInt(0);
  TextEditingController searchController = TextEditingController();
  RxBool loading = RxBool(false);
  RxBool loadingProduct = RxBool(false);


  // Data From Api
  //  products Page
  RxList<ProductModel> products = RxList<ProductModel>([]);

// chart page
  RxList<AdviceModel> myAdvices = RxList<AdviceModel>([]);
  RxList<SliderModel> sliders = RxList<SliderModel>([]);
  RxList<ProductModel> myProducts = RxList<ProductModel>([]);
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
    loadingProduct.value = true;
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
            created_at
            name
            expert
            is_available
            level
            active
            type
            views_count
            image
            user{
            id
            seller_name
            is_verified
            }
            city{
            id
            name
            }
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

      if (res?.data?['data']?['myProducts'] != null) {
        hasMorePage(
            res?.data['data']?['myProducts']['paginatorInfo']['hasMorePages']);
        for (var item in res?.data['data']['myProducts']['data']) {
          products.add(ProductModel.fromJson(item));
        }
      }
      if(res?.data['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } on CustomException catch (e) {
      mainController.logger.e(e);
    }
    loadingProduct.value = false;
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
            image
            id
            expired_date
            views_count
        }
      
    }
      mySliders {
            id
            url
            image
            expired_date
            views_count
        }
        
        mySpecialProducts {
          id
          name
          expert
          is_discount
          price
          discount
          code
          type
          views_count
          image
          created_at
          category {
              name
          }
          sub1 {
              name
          }
        }
    
}
    ''');
    dio.Response? res = await mainController.fetchData();

    if (res != null) {
      if (res.data['data']['myAdvice']['advices'] != null) {
        for (var item in res.data['data']['myAdvice']['advices']) {
          myAdvices.add(AdviceModel.fromJson(item));
        }
      }

      if (res.data['data']['mySliders'] != null) {
        for (var item in res.data['data']['mySliders']) {
          sliders.add(SliderModel.fromJson(item));
        }
      }
      if (res.data['data']['mySpecialProducts'] != null) {
        for (var item in res.data['data']['mySpecialProducts']) {
          myProducts.add(ProductModel.fromJson(item));
        }
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
