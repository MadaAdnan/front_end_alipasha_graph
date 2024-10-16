import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/comment_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProductLogic extends GetxController {
  RxInt pageIndex = RxInt(int.tryParse("${Get.parameters['index']}")??0);
  PageController pageController = PageController(initialPage: int.tryParse("${Get.parameters['index']}")??0);
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
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);

TextEditingController comment =TextEditingController();

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    productId.value = Get.arguments;
    ever(productId, (value) {
      page.value = 1;
      comments.clear();
      comment.clear();
      getProduct();
      getComments();
    });
    ever(page, (value) {
      getComments();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if(pageIndex.value>0){
      pageController.animateToPage(pageIndex.value, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
    }

    getProduct();
    getComments();
  }

  Future<void> getProduct() async {
    loading.value = true;
    products.clear();

    String productsData = ''' products {
        id
            name
            expert
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
          name
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
        ${page.value == 1 ? '$productsData' : ''}
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

  Future<void> createComment() async {
    loadingComment.value = true;
    mainController.query.value = '''
      mutation CreateComment {
    createComment(product_id: ${productId.value}, comment: "${comment.value.text}") {
        comment
        created_at
        user {
        id
            name
            seller_name
            image
            is_verified
        }
    }
}
''';
    try {
      dio.Response? res = await mainController.fetchData();

      if (res?.data?['data']?['createComment'] != null) {
        comments
            .add(CommentModel.fromJson(res?.data?['data']?['createComment']));
        comment.clear();
      }
    } on CustomException catch (e) {}
    loadingComment.value = false;
  }

  Future<void> getComments() async {
    loadingGetComment.value = true;
    mainController.query.value = '''
     query Product {
        product(id: "${productId.value}") {
          product {
            comments(first: 10, page: ${page.value}) {
                paginatorInfo {
                    hasMorePages
                }
                data {
                    comment
                    created_at
                    user {
                    id
                    seller_name
                        name
                        image
                    }
                }
            }
          }
        }
     }
    ''';

    try {
      dio.Response? res = await mainController.fetchData();
     // mainController.logger.e(res?.data);
      if (res?.data?['data']?['product']['product']['comments']
              ['paginatorInfo'] !=
          null) {
        hasMorePage.value = res?.data?['data']?['product']['product']
            ['comments']['paginatorInfo']['hasMorePages'];
      }
      if (res?.data?['data']?['product']['product']['comments']['data'] !=
          null) {
        for (var item in res?.data?['data']?['product']['product']['comments']
            ['data']) {
          comments.add(CommentModel.fromJson(item));
        }

      }
    } on CustomException catch (e) {}
    loadingGetComment.value = false;
  }

  Future<void> rateProduct({required int value}) async {
    mainController.query.value = '''
    mutation AddVote {
    addVote(productId: ${productId}, vote: $value) {
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
     // mainController.logger.i(res?.data);
      if (res?.data['data']?['addVote'] != null) {
        product.value = ProductModel.fromJson(res?.data['data']?['addVote']);
      }
    } catch (e) {
      mainController.logger.e("Error Add Vote $e");
    }
    loadingRate.value = false;
  }
}
