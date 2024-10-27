import 'package:ali_pasha_graph/models/comment_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import 'package:dio/dio.dart' as dio;

import '../../exceptions/custom_exception.dart';

class CommentLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxBool loadingComment = RxBool(false);
  TextEditingController comment = TextEditingController();
  MainController mainController = Get.find<MainController>();
  Rxn<ProductModel> product = Rxn<ProductModel>(Get.arguments);
  RxnInt productId = RxnInt(null);
  RxList<CommentModel> comments = RxList<CommentModel>([]);

  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);

  ScrollController scrollController = ScrollController();

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    productId.value = Get.arguments?.id ;
    ever(productId, (value) {
      comments.clear();
      comment.clear();
      getComments();
    });
    ever(page, (value) {
      getComments();
    });
  }

  @override
  onReady() {
    super.onReady();
    productId.value = int.tryParse("${Get.parameters['id']}");
  }

  Future<void> createComment() async {
    loadingComment.value = true;
    mainController.query.value = '''
      mutation CreateComment {
    createComment(product_id: ${productId.value}, comment: "${comment.value.text}") {
        id
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

    loading.value = true;
    mainController.query.value = '''
     query Product {
        product(id: "${productId.value}") {
          product {
          name
          expert
          id
          image
          user{
            id
            name
            seller_name
            image
          }
            comments(first: 30, page: ${page.value}) {
                paginatorInfo {
                    hasMorePages
                }
                data {
                    id
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

      if (res?.data?['data']?['product']['product']['comments']['paginatorInfo'] != null) {
        hasMorePage.value = res?.data?['data']?['product']['product']
            ['comments']['paginatorInfo']['hasMorePages'];
      }
      if (res?.data?['data']?['product']['product']['comments']['data'] != null) {
        for (var item in res?.data?['data']?['product']['product']['comments']
            ['data']) {
          comments.add(CommentModel.fromJson(item));
        }
      }
      if (res?.data?['data']?['product']['product'] != null) {
        product.value=ProductModel.fromJson(res?.data?['data']?['product']['product']);
      }


    } on CustomException catch (e) {}
    loading.value = false;
  }

  Future<void> deletComment({required int commentId}) async {

    mainController.logger.e(commentId);
    mainController.query.value = '''
  mutation DeleteComment {
    deleteComment(id: "$commentId") 
}

   ''';
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.e(res?.data);
      if (res?.data?['data']?['deleteComment'] != null) {
        mainController.showToast(text: 'تم حذف التعليق بنجاح');
        int index = comments.indexWhere((el) => el.id == commentId);
        mainController.logger.e("INDEX: $index");
        if (index != -1) {

          comments.removeAt(index);
        }
      }

      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {}
  }
}
