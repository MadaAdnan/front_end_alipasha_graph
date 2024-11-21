import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/comment_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProductLogic extends GetxController {
  RxInt pageIndex = RxInt(int.tryParse("${Get.parameters['index']}")??0);
  PageController pageController = PageController(initialPage: int.tryParse("${Get.parameters['index']}")??0);
  RxDouble rate=RxDouble(0);
  RxBool loading = RxBool(false);
  RxBool loadingComment = RxBool(false);
  RxBool loadingRate = RxBool(false);
  RxBool loadingGetComment = RxBool(false);
  MainController mainController = Get.find<MainController>();
  RxnInt productId = RxnInt(null);
ScrollController scrollController=ScrollController();
  Rxn<ProductModel> product = Rxn<ProductModel>(null);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<CommentModel> comments = RxList<CommentModel>([]);

TextEditingController comment =TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    productId.value = Get.arguments;
    ever(productId, (value) {
      comments.clear();
      comment.clear();
      getProduct();

    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if(productId.value==null){
      productId.value=int.tryParse("${Get.parameters['id']}");
    }
    getProduct();
    mainController.logger.w("PREVIOUS:");
    mainController.logger.w(Get.previousRoute);
  }

  Future<void> getProduct() async {

    if(Get.previousRoute=='/notification_page'){
      Get.toNamed(COMMENTS_PAGE,parameters: {"id":"${ productId.value}"});
      return;
    }
    loading.value = true;
    products.clear();

    String productsData = ''' products {
        id
            name
            expert
            weight
              level
            price
            discount
            start_date
            end_date
            created_at
            code
            type
            views_count
            image
            is_discount
            
            user {
              id
              seller_name
              image
              is_verified
            }
            city {
              name
            }
            category{
              name
            }
            sub1{
              name
            }
          
        } ''';

    mainController.query.value = '''
    query Product {
    product(id: "${productId.value}") {
        product {
          id
          is_rate
          vote_avg
          weight
           name
            info
            tags
            is_discount
            level
            phone
            email
            address
            url
            longitude
            latitude
            price
            discount
            start_date
            end_date
            code
            type
            views_count
            turkey_price {
                price
                discount
            }
            image
            video
            images
            docs
            created_at
            user {
            id
                seller_name
                name
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
            category {
                name
            }
            sub1 {
                name
            }
            colors {
                code
                name
            }
           
            
        }
       $productsData
    }
}

    ''';
    // Clipboard.setData( ClipboardData(text: "${mainController.query.value}"));

    try {
      dio.Response? res = await mainController.fetchData();

      loading.value = false;
      if (res?.data?['data']?['product']['product'] != null) {
        product.value =
            ProductModel.fromJson(res?.data?['data']?['product']['product']);
        rate.value=product.value?.vote_avg??0;
      }

      if (res?.data?['data']?['product']['products'] != null) {
        for (var item in res?.data?['data']?['product']['products']) {
          products.add(ProductModel.fromJson(item));
        }
      }
    } on CustomException catch (e) {
      mainController.logger.e(e.message);
    }

    loading.value = false;
  }



  Future<void> rateProduct() async {

    mainController.query.value = '''
    mutation AddVote {
    addVote(productId: ${productId}, vote: ${rate.value.toInt()}) {
          id
          is_rate
          vote_avg
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
            colors {
                code
            }
            name
            info
            tags
            is_discount
            level
            phone
            email
            address
            url
            longitude
            latitude
            price
            discount
            start_date
            end_date
            code
            type
            views_count
            turkey_price {
                price
                discount
            }
            image
            video
            images
            docs
            created_at
            
        }
}
     ''';
    try {
      loadingRate.value = true;
      dio.Response? res = await mainController.fetchData();
     //mainController.logger.i(res?.data);
      if (res?.data['data']?['addVote'] != null) {
        product.value = ProductModel.fromJson(res?.data['data']?['addVote']);
        rate.value=product.value?.vote_avg??0;
        mainController.showToast(text: "تم التقييم بنجاح",);
      }
    } catch (e) {
      mainController.logger.e("Error Add Vote $e");
    }
    loadingRate.value = false;
  }
}
