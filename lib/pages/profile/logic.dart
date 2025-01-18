import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';

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
  TextEditingController urlController = TextEditingController();
  Rxn<XFile> image = Rxn<XFile>(null);
  PageController pageController = PageController(
    initialPage: 0,
  );

  nextPage() {
    page.value = page.value + 1;
  }

  @override
  void onInit() {
    super.onInit();
    getDataFromStorage();
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

    mainController.query('''
    query MyProducts {
      myProducts(first: 35, page: ${page} ,search:"${search.value ?? ''}") {
         paginatorInfo {
            hasMorePages
         }
        data {
            id
            created_at
            start_date
            end_date
            name
            expert
            price
            is_discount
            discount
            weight
            is_available
            level
            active
            is_delivery
            type
            views_count
            image
            user{
              image
              id
              seller_name
              is_verified
              city{
                id
                city_id
              }
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
        if (page.value == 1) {
          products([]);
        }
        await mainController.storage.write(
            'products-${mainController.authUser.value?.id}',
            res?.data['data']['myProducts']['data']);
        for (var item in res?.data['data']['myProducts']['data']) {
          products.add(ProductModel.fromJson(item));
        }
      }
      if (res?.data['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: '${res?.data['errors'][0]['message']}', type: 'error');
      }
    } catch (e) {
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
            url
            expired_date
            views_count
            name
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
          weight
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

  getDataFromStorage() {
    var listProduct = mainController.storage
            .read('products-${mainController.authUser.value?.id}') ??
        [];

    for (var item in listProduct) {
      products.add(ProductModel.fromJson(item));
    }
  }

  deletAdvice({required int adviceId}) async {
    mainController.query.value = '''
    mutation DeleteAdvice {
    deleteAdvice(id: "$adviceId") {
        id
    }
}
     ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['deleteAdvice'] != null) {
        int index = myAdvices.indexWhere((el) =>
            el.id ==
            int.tryParse("${res?.data?['data']?['deleteAdvice']['id']}"));
        if (index > -1) {
          myAdvices.removeAt(index);
        }
      }
    } catch (e) {}
  }

  saveAdvice({required int adviceId}) async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query": r"""mutation UpdateAdvice($id:ID!,$input:UpdateAdviceInput!) {
       updateAdvice(id:$id,input: $input){
          image
            id
            url
            expired_date
            views_count
            name
       }
      }""",
      "variables": <String, dynamic>{
        "input": {
          'url': "${urlController.text ?? ''}",
          'image': null,
        },
        "id": "$adviceId"
      }
    };
    String map = '''
    {
  "image": ["variables.input.image"]
}
    ''';

    Map<String, XFile?> data = {if (image.value != null) 'image': image.value};
    try {
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);

      if (res.data?['data']?['updateAdvice'] != null) {
        image.value = null;

        urlController.clear();
        int index = myAdvices.indexWhere((el) => el.id == adviceId);
        myAdvices[index] =
            AdviceModel.fromJson(res.data?['data']?['updateAdvice']);
        mainController.showToast(
            text: 'تم إرسال الإعلان إلى المراجعة قبل تفعيله', type: 'success');
      }
      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: '${res?.data['errors'][0]['message']}', type: 'error');
        mainController.logger.e("Error Send ${res?.data['errors']}");
      }
    } catch (e) {}
    loading.value = false;
  }
}
