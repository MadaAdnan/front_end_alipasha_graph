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
  RxBool loadingProduct = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxnInt categoryId = RxnInt(null);
  RxnInt mainCategory = RxnInt(Get.arguments);
  RxnInt subCategoryId = RxnInt(null);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<AdviceModel> advices = RxList<AdviceModel>([]);
  Rxn<CategoryModel> category = Rxn<CategoryModel>(null);
  RxList orderBy = RxList(['created_at', 'desc']);

  nextPage() {
    if (hasMorePage.value) {
      page.value += 1;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataFromStorage();
    ever(orderBy, (value) {
      products.clear();
      page.value = 1;
      getPosts();
    });
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
    if (category.value == null) {
      loadingProduct.value = true;
    }

    mainController.query.value = '''
    query Products {
    products(  order_by: { column: "${orderBy[0] ?? 'created_at'}", orderBy: "${orderBy[1] ?? 'desc'}" },category_id: ${mainCategory.value ?? null},sub1_id:${categoryId.value ?? null}, page: ${page.value}, first: 25) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            name
            user {
            id
                seller_name
                image
                phone
                city{
                id
                city_id
              }
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
            weight
            end_date
            active
            level
            code
            type
            is_discount
            is_delivery
            discount
            views_count
            image
            price
            created_at
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
        if(page.value==1){
          products.clear();
        }
        for (var item in res?.data?['data']?['products']['data']) {
          products.add(ProductModel.fromJson(item));
        }
        if (mainController.storage
            .hasData('category-products-${mainCategory.value}')) {
          mainController.storage
              .remove('category-products-${mainCategory.value}');
        }
        await mainController.storage.write(
            'category-products-${mainCategory.value}',
            res?.data?['data']?['products']['data']);
      }

      if (res?.data?['data']?['category'] != null) {
        category.value =
            CategoryModel.fromJson(res?.data?['data']?['category']);
        category.value?.children?.insert(
            0,
            CategoryModel(
              name: 'الكل',
            ));
        if (mainController.storage
            .hasData('category-${mainCategory.value}')) {
          mainController.storage
              .remove('category-${mainCategory.value}');
        }
        await mainController.storage.write(
            'category-${mainCategory.value}',
            res?.data?['data']?['category']);
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
    loadingProduct.value = false;
  }

  changeCategory(CategoryModel categorymodel) {
    category.value = categorymodel;
  }

  getDataFromStorage() {
    var listProduct =
        mainController.storage.read('category-products-${mainCategory.value}') ??
            [];
if(mainController.storage.hasData('category-${mainCategory.value}')){
  var data=mainController.storage.read('category-${mainCategory.value}');
  if(data['id']!=null){
    category.value=CategoryModel.fromJson(data);
    category.value?.children?.insert(
        0,
        CategoryModel(
          name: 'الكل',
        ));
  }
}
    for (var item in listProduct) {
      products.add(ProductModel.fromJson(item));
    }
  }
}
