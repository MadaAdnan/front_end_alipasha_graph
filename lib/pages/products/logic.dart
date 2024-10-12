import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../helpers/queries.dart';
import '../../models/product_model.dart';

class ProductsLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool hasMorePage = RxBool(false);
  RxBool loading = RxBool(false);
  RxInt page = RxInt(1);
  Rxn<UserModel> seller = Rxn<UserModel>(Get.arguments);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<AdviceModel> advices = RxList<AdviceModel>([]);
RxnInt categoryId=RxnInt(null);
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
    ever(categoryId,(value){
      if(page.value==1){
        getProducts();
      }else{
        page.value=1;
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
    loading.value = true;

    mainController.query.value = '''
   query Products {
    products(sub1_id:${categoryId.value},user_id: ${seller.value?.id}, first: 15, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
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
                image
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
    }
   
    ${page.value == 1 ? '''  
     advices (user_id: ${seller.value?.id}) {
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
    user(id:${seller.value?.id}){$AUTH_FIELDS}
    categoryBySeller(sellerId:${seller.value?.id}) {id name}''' : ''}
}

  ''';
    try {
      dio.Response? res = await mainController.fetchData();
      //  mainController.logger.e(res?.data);
      if (res?.data?['data']?['products']?['paginatorInfo'] == null) {
        hasMorePage.value =
            res?.data?['data']?['products']?['paginatorInfo']['hasMorePages'];
      }
      //mainController.logger.w(products.length);
      if (res?.data?['data']?['products']?['data'] != null) {
        if(page.value==1){
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
  }
}
