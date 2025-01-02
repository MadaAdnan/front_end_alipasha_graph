import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';

import '../../models/product_model.dart';

class HomeLogic extends GetxController {
  String getProductsQuery = '';
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> products = RxList([]);
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxList<UserModel> sellers = RxList<UserModel>([]);

  RxInt page = RxInt(1);


  @override
  void onInit() {
    super.onInit();

    getDataFromStorage();
    ever(
      page,
      (value) {
        getProduct();
      },
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProduct();
  }

  nextPage() {
    page.value++;
    // getProduct();
  }

  showDialogPrivacy() {

  }

  getProduct() async {
    loading.value = true;

    String dataString = '''data {
            id
            name
            weight
            expert
            type
            is_discount
            is_delivery
            is_available
            price
            views_count
            comments_count
            discount
            end_date
            type
            is_like
            likes_count
            level
            image
            video
            created_at
            user {
              id
              name
              id_color
              seller_name
              image
              logo
              is_verified
              city{
                id
               city_id
              }
            }
          
            city {
            id
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
        paginatorInfo {
            hasMorePages
        } ''';
    mainController.query('''
    query Products {
      SpecialProduct(first:3, page: ${page.value}) {
          $dataString
      }
      HobbiesProduct(first:12, page: ${page.value}) {
          $dataString
      }
       LatestProduct(first:15, page: ${page.value}) {
          $dataString
      }
   
   ${page.value == 1 ? r'''
    mainCategories{
        name
        color
        type
        has_color
        id
        image
      children{
        id
        name
        children{
          id
          name
          children{
            id
            name
         }
        }
      }
    }
    specialSeller{
      id
      name
      seller_name
      image
      custom
    }
    
    cities{
      id
      name
      is_delivery
      image
      city_id
    }
    
    mainCity{
      id
      name
      city_id
      children{
       id
      name
      city_id
      }
    }
    
      colors{
      name
      id
    }
    
    
   ''' : ''}
   
  
}
    ''');

    try {
      dio.Response? res = await mainController.fetchData();
      loading.value = false;
      if (res?.data?['data']?['LatestProduct']?['paginatorInfo']
              ?['hasMorePages'] !=
          null) {
        hasMorePage(res?.data?['data']?['LatestProduct']?['paginatorInfo']
            ?['hasMorePages']);
      }
      if (res?.data?['data']?['LatestProduct']?['data'] != null) {
        if (page.value == 1) {
          products.clear();
        }
        for (var item in res?.data?['data']?['SpecialProduct']?['data']) {
          products.add(ProductModel.fromJson(item));
        }
        for (var item in res?.data?['data']?['HobbiesProduct']?['data']) {
          products.add(ProductModel.fromJson(item));
        }

        for (var item in res?.data?['data']?['LatestProduct']?['data']) {
          products.add(ProductModel.fromJson(item));
        }

        var productsList = [
          ...res?.data?['data']?['LatestProduct']?['data'] ?? [],
          ...res?.data?['data']?['HobbiesProduct']?['data'] ?? [],
          ...res?.data?['data']?['SpecialProduct']?['data'] ?? [],
        ];

        if (mainController.storage.hasData('products')) {
          mainController.storage.remove('products');
        }
        await mainController.storage.write('products', productsList);
      }

      if (res?.data['data']?['mainCategories'] != null) {
        if (page.value == 1) {
          mainController.categories.clear();
        }
        for (var item in res?.data['data']['mainCategories']) {
          mainController.categories.add(CategoryModel.fromJson(item));
        }
        mainController.storage
            .write('mainCategories', res?.data['data']['mainCategories']);
      }

      if (res?.data?['data']?['cities'] != null) {
        for (var item in res?.data['data']?['cities']) {
          mainController.cities.add(CityModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['mainCity'] != null) {
        for (var item in res?.data['data']?['mainCity']) {
          mainController.mainCities.add(CityModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['colors'] != null) {
        for (var item in res?.data['data']['colors']) {
          mainController.colors.add(ColorModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['specialSeller'] != null) {
        if (page.value == 1) {
          sellers.clear();
        }
        for (var item in res?.data?['data']?['specialSeller']) {
          sellers.add(UserModel.fromJson(item));
        }
        mainController.storage
            .write('specialSeller', res?.data?['data']?['specialSeller']);
      }
    } catch (e) {
      mainController.logger.w('ERRORPRO');
      mainController.logger.w('$e');
    }

    loading.value = false;
  }

  getDataFromStorage() {
    var listProduct = mainController.storage.read('products') ?? [];
    var listCategories = mainController.storage.read('mainCategories') ?? [];
    var listSeller = mainController.storage.read('specialSeller') ?? [];
    for (var item in listProduct) {
      products.add(ProductModel.fromJson(item));
    }
    for (var item in listCategories) {
      mainController.categories.add(CategoryModel.fromJson(item));
    }
    for (var item in listSeller) {
      sellers.add(UserModel.fromJson(item));
    }
  }
}
