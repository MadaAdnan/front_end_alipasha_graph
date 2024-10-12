import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:get/get.dart';
import "package:dio/dio.dart" as dio;

class SectionLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxnInt categoryId = RxnInt(null);
  RxnInt mainCategory = RxnInt(null);
  RxnInt subCategoryId = RxnInt(null);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<AdviceModel> advices = RxList<AdviceModel>([]);
  Rxn<CategoryModel> category = Rxn<CategoryModel>(null);

  nextPage() {
    if (hasMorePage.value) {
      page.value += 1;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(categoryId, (value) {
      products.clear();
      page.value = 1;
      getPosts();
    });
    ever(page, (value) {
      getPosts();
    });

    mainCategory.value = Get.arguments;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getPosts();
  }

  Future<void> getPosts() async {

    loading.value = true;
    mainController.query.value = '''
    query Products {
    products(category_id: ${mainCategory.value ?? null},sub1_id:${categoryId.value ?? null}, page: ${page.value}, first: 25) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            name
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
            level
            code
            type
            is_discount
            discount
            views_count
            image
            price
        }
    }
    
    ${page.value == 1 ? '''category(id: "${mainCategory.value}") {
        id
        name
        color
        type
        image
        children {
            id
            name
            color
            type
            image
            
        }
    }
    
    advices (category_id: ${mainCategory.value ?? mainCategory.value}) {
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
    
    ''' : ''' '''}
}

    ''';

    try {
      dio.Response? res = await mainController.fetchData();
      loading.value = false;
      // mainController.logger.e(res?.data);
      if (res?.data?['data']?['products']['paginatorInfo'] != null) {
        hasMorePage.value =
            res?.data?['data']?['products']['paginatorInfo']['hasMorePages'];
      }

      if (res?.data?['data']?['products']['data'] != null) {
        for (var item in res?.data?['data']?['products']['data']) {
          products.add(ProductModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['category'] != null ) {
        category.value =
            CategoryModel.fromJson(res?.data?['data']?['category']);
        category.value?.children?.insert(
            0,
            CategoryModel(
              name: 'الكل',
            ));
      }

      if (res?.data?['data']?['advices'] != null) {
        advices.clear();
        for (var item in res?.data?['data']?['advices']) {
          advices.add(AdviceModel.fromJson(item));
        }
      } else {
        advices.addAll(mainController.advices);
      }
    } on CustomException catch (e) {
      mainController.logger.e(e.message);
    }

    loading.value = false;
  }

  changeCategory(CategoryModel categorymodel) {
    category.value = categorymodel;

  }
}
