import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../helpers/queries.dart';
import '../../models/product_model.dart';

class ProductsLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  TextEditingController searchController = TextEditingController();
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxBool loadingProducts = RxBool(false);
  RxInt page = RxInt(1);
  RxnInt sellerId = RxnInt(Get.arguments?.id??int.tryParse("${Get.parameters['id']}") ?? null);
  Rxn<UserModel> seller = Rxn<UserModel>(null);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<AdviceModel> advices = RxList<AdviceModel>([]);
  RxString search = RxString('');
  RxnInt categoryId = RxnInt(null);

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
    ever(categoryId, (value) {
      if (page.value == 1) {
        getProducts();
      } else {
        page.value = 1;
      }
    });
    ever(search, (value) {
      if (page.value > 1) {
        page.value = 1;
      } else {
        getProducts();
      }
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProducts();
  }

  getProducts() async {
    if (seller.value ==null) {
      loading.value = true;
    } else {
      loadingProducts.value = true;
    }
    mainController.query.value = '''
   query Products {
    products(search: "${search.value}" sub1_id:${categoryId.value},user_id: ${sellerId.value}, first: 35, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            expert
            weight
            name
            type
            is_discount
            active
            is_delivery
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
                image
                is_verified
                city{
                id
                city_id
              }
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
   
    ${page.value == 1 ? '''
     advices (user_id: ${sellerId.value}) {
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
    user(id:${sellerId.value}){$AUTH_FIELDS}
    categoryBySeller(sellerId:${sellerId.value}) {id name}''' : ''}
}

  ''';
    try {
      dio.Response? res = await mainController.fetchData();
     // mainController.logger.e(res?.data?['data']?['products']);
      if (res?.data?['data']?['products']?['paginatorInfo'] != null) {
        hasMorePage.value =
            res?.data?['data']?['products']?['paginatorInfo']['hasMorePages'];

      }
      //mainController.logger.w(products.length);
      if (res?.data?['data']?['products']?['data'] != null) {
        if (page.value == 1) {
          products.clear();
        }
        for (var item in res?.data?['data']?['products']?['data']) {
          products.add(ProductModel.fromJson(item));
        }
      }
      if (res?.data?['data']?['user'] != null) {
        seller.value = UserModel.fromJson(res?.data?['data']?['user']);
      }

      if (res?.data?['data']?['categoryBySeller'] != null) {
        categories.clear();
        for (var item in res?.data?['data']?['categoryBySeller']) {
          categories.add(CategoryModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['advices'] != null) {
        for (var item in res?.data?['data']?['advices']) {
          advices.add(AdviceModel.fromJson(item));
        }
      }
      //mainController.logger.w(products.length);
    } catch (e) {
      mainController.logger.e('Error Get Products By Seller $e');
    }

    loading.value = false;
    loadingProducts.value = false;
  }
}
