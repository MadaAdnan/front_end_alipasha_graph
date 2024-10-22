import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/main.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../models/product_model.dart';
import '../../models/setting_model.dart';

class HomeLogic extends GetxController {
  String getProductsQuery = '';
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> products = RxList([]);
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxList<UserModel> sellers = RxList<UserModel>([]);

  int page = 1;

  @override
  void onInit() {
    super.onInit();
    page = 1;
    getDataFromStorage();
    getProduct();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  nextPage() {
    page++;
    getProduct();
  }

  getProduct() async {
    loading.value = true;

    mainController.query('''
    query Products {
    products(first:35, page: ${page}) {
        data {
            id
            name
            expert
            type
            is_discount
            is_delivary
            is_available
            price
            views_count
            discount
            end_date
            type
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
        paginatorInfo {
            hasMorePages
        }
    }
   ${page == 1 ? r'''
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
    colors{
    name
    id
    }
    
    
   ''' : ''}
   
  
}
    ''');

    try {
      dio.Response? res = await mainController.fetchData();

      if (res?.data['data']['products']['paginatorInfo']['hasMorePages'] !=
          null) {
        hasMorePage(
            res?.data['data']['products']['paginatorInfo']['hasMorePages']);
      }
      if (res?.data['data']['products']['data'] != null) {
        if (page == 1) {
          products.clear();
        }
        for (var item in res?.data['data']['products']['data']) {
          products.add(ProductModel.fromJson(item));

        }
        mainController.storage.write('products',  res?.data['data']['products']['data']);
      }
      if (res?.data['data']['mainCategories'] != null) {
        if (page == 1) {
          mainController.categories.clear();
        }
        for (var item in res?.data['data']['mainCategories']) {
          mainController.categories.add(CategoryModel.fromJson(item));
        }
        mainController.storage.write('mainCategories',  res?.data['data']['mainCategories']);
      }

      if (res?.data['data']['cities'] != null) {
        for (var item in res?.data['data']['cities']) {
          mainController.cities.add(CityModel.fromJson(item));
        }
      }

      if (res?.data['data']['colors'] != null) {
        for (var item in res?.data['data']['colors']) {
          mainController.colors.add(ColorModel.fromJson(item));
        }
      }

      if (res?.data['data']['specialSeller'] != null) {
        if (page == 1) {
          sellers.clear();
        }
        for (var item in res?.data['data']['specialSeller']) {
          sellers.add(UserModel.fromJson(item));
        }
        mainController.storage.write('specialSeller', res?.data['data']['specialSeller']);
      }
    } catch (e) {}

    loading.value = false;
  }

  getDataFromStorage() {
    var listProduct = mainController.storage.read('products')??[];
    var listCategories = mainController.storage.read('mainCategories')??[];
    var listSeller = mainController.storage.read('specialSeller')??[];
    for (var item in listProduct) {
      products.add(ProductModel.fromJson(item));
    }
    for (var item in listCategories) {
      mainController.categories.add(CategoryModel.fromJson(item));
    }
    for (var item in listSeller) {
      sellers.add(UserModel.fromJson(item));
    }
    mainController.logger.d("Products ${products.length}");
    mainController.logger.d("Products ${sellers.length}");
  }
}
