import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/comment_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';

class ProductLogic extends GetxController {
  RxInt pageIndex = RxInt(int.tryParse("${Get.parameters['index']}") ?? 0);
  PageController pageController = PageController(
      initialPage: int.tryParse("${Get.parameters['index']}") ?? 0);
  RxDouble rate = RxDouble(0);
  RxBool loading = RxBool(false);
  RxBool loadingComment = RxBool(false);
  RxBool loadingRate = RxBool(false);
  RxBool loadingGetComment = RxBool(false);
  MainController mainController = Get.find<MainController>();
  RxnInt productId = RxnInt(null);
  ScrollController scrollController = ScrollController();
  Rxn<ProductModel> product = Rxn<ProductModel>(null);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<CommentModel> comments = RxList<CommentModel>([]);

  TextEditingController comment = TextEditingController();



  @override
  void onInit() {
    super.onInit();

    // كل ما productId يتغير => حدث التعليقات و جلب المنتج
    ever(productId, (value) {
      comments.clear();
      comment.clear();
      if (value != null) {
        getProduct();
      }
    });

  }



  @override
  void onReady() {
    super.onReady();

    // تحديث productId من الـ arguments أو من الـ parameters
    productId.value = Get.arguments ?? int.tryParse("${Get.parameters['id']}");


  }
  @override
  void onClose() {
    productId.value =null; // أو null حسب حالتك

    super.onClose();
  }
  Future<void> getProduct() async {

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
            is_delivery
            created_at
            code
            type
            views_count
            image
            is_discount
            
            user {
              id
              seller_name
              full_phone
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
          is_like
          vote_avg
          weight
           name
            info
            tags
            is_discount
            is_delivery
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
             syr_price {
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
                phone
                full_phone
                is_verified
                city{
                id
                  name
                is_delivery
                code_city
                level
              
              }
               area{
                id
                  name
                is_delivery
                code_city
                level
               
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
     // mainController.logger.f(res?.data);
      loading.value = false;
      if (res?.data?['data']?['product']['product'] != null) {
        product.value =
            ProductModel.fromJson(res?.data?['data']?['product']['product']);
        rate.value = product.value?.vote_avg ?? 0;
      }

      if (res?.data?['data']?['product']['products'] != null) {
        for (var item in res?.data?['data']?['product']['products']) {
          products.add(ProductModel.fromJson(item));
        }
      }
    }  catch (e) {
      mainController.logger.e(e);
    }
    if (Get.previousRoute == '/notification_page') {
      Get.toNamed(COMMENTS_PAGE, parameters: {"id": "${productId.value}"});
      return;
    }
    loading.value = false;
  }

  like() async {
    loadingRate.value = true;
    mainController.query.value = '''
    mutation AddLike{
addLike(product_id:"${product.value!.id}"){
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
              phone
              full_phone
              seller_name
              image
              logo
              is_verified
              city{
                id
                  name
                is_delivery
                code_city
                level  
              }
              area{
               id
               name
                is_delivery
                code_city
                level
               
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
            colors {
                code
                name
            }
           
            
}
}
    
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
Logger().e(res?.data);
      if (res?.data?['data']?['addLike'] != null) {
        ProductModel prod =
            ProductModel.fromJson(res?.data?['data']?['addLike']);

        product.value = prod;
      }
    } catch (e) {}
    loadingRate.value = false;
  }
  createOrder() async {
    loading.value = true;
    if (mainController.authUser.value!.address!.isEmpty ||
        mainController.authUser.value!.phone!.isEmpty) {
      mainController.showToast(
          text: 'يرجى إكمال الملف الشخصي وإضافة عنوان ورقم هاتف',
          type: 'error');
      return;
    }
    Map<String, dynamic> data = {
      'seller_id': product.value?.user?.id,
      'weight': product.value?.weight,
      'address': mainController.authUser.value?.address,
      'phone': mainController.authUser.value?.phone,
      'items': [
        {"product_id": "${product.value?.id}", 'qty':1}
      ],
    };
    mainController.logger.i(data);
    mainController.query.value = r'''
    mutation CreateNewInvoice($input:InvoiceInput!){
      createNewInvoice(input:$input){
          id
          user{
            name
            full_phone
          }
          seller{
            seller_name
          }
      }
    
    }
     ''';
    mainController.variables.value = {'input': data};
    try {

      var res = await mainController.fetchData();
      if (res?.data?['data']?['createNewInvoice'] != null) {
        mainController.showToast(text: 'الطلب بإنتظار المراجعة شكراً لك');
        await mainController.refreshCart();
        // Get.offNamed(MY_INVOICE_PAGE);
      }else if(res?.data?['errors']?[0]?['message']!=null){
        throw Exception("${res?.data?['errors']?[0]?['message']}");
      }
      else {
        throw Exception('خطأ في الطلب يرجى المحاولة لاحقاً');
      }
    } catch (e) {
      mainController.showToast(
          text: '$e'.replaceAll('Exception:', ''), type: 'error');
    }
    loading.value = false;
  }

}
