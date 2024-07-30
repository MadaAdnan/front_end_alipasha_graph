import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../models/product_model.dart';

class HomeLogic extends GetxController {
  String getProductsQuery = '';
  MainController mainController = Get.find<MainController>();
  RxList<ProductModel> products = RxList([]);
  RxBool hasMorePage = RxBool(false);
  RxList<UserModel> sellers = RxList<UserModel>([]);

  int page = 1;

  @override
  void onInit() {
    super.onInit();
    page = 1;
    getProduct();
  }

  nextPage() {
    page++;
    getProduct();
  }

  getProduct() async {
    if (page == 1) {
      products.clear();
    }
    mainController.query('''
    query Products {
    products(first:15, page: ${page}) {
        data {
            id
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
            created_at
            user {
            id
                seller_name
                logo
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
    id
    image
    }
    specialSeller{
    id
    name
    logo
    custom
    }
    
    cities{
    id
    name
    is_delivery
    image
    city_id
    }
   ''' : ''}
}
    ''');
    dio.Response? res = await mainController.fetchData();

    if (res != null) {
      hasMorePage(
          res.data['data']['products']['paginatorInfo']['hasMorePages']);
      for (var item in res.data['data']['products']['data']) {
        products.add(ProductModel.fromJson(item));
      }
      if (res.data['data']['mainCategories'] != null) {
        for (var item in res.data['data']['mainCategories']) {
          mainController.categories.add(CategoryModel.fromJson(item));
        }
      }
      if (res.data['data']['cities'] != null) {
        for (var item in res.data['data']['cities']) {
          mainController.cities.add(CityModel.fromJson(item));
        }
      }
      if (res.data['data']['specialSeller'] != null) {
        for (var item in res.data['data']['specialSeller']) {
          sellers.add(UserModel.fromJson(item));
        }
      }
    }
  }
}
