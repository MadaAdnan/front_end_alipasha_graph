import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class OrdersLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  RxInt page = RxInt(1);

  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) {
      getOrders();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getOrders();
  }

  nextPage() {
    if (hasMorePage.value) {
      page.value = page.value + 1;
    }
  }

  getOrders() async {
    loading.value = true;
    mainController.query.value = '''
   
query MyOrderShipping {
    myOrderShipping(first: 25, page: ${page.value}) {
        data {
            id
            size
            weight
          
            receive_name
            receive_address
            receive_phone
          
            status
            price
            created_at
            from {
                id
                name
                city {
                    name
                    id
                }
            }
            to {
                id
                name
                city {
                    id
                    name
                }
            }
        }
    }
}

   ''';

    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['myOrderShipping']?['paginatorInfo'] != null) {
        hasMorePage.value = res?.data?['data']?['myOrderShipping']
            ?['paginatorInfo']?['hasMorePages'];
      }

      if (res?.data?['data']?['myOrderShipping']?['data'] != null) {
        for (var item in res?.data?['data']?['myOrderShipping']?['data']) {
          orders.add(OrderModel.fromJson(item));
        }
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e("Error Get Orders $e");
    }
    if(mainController.showPopupShipping.value==false){
      showPopup();
      mainController.showPopupShipping.value=true;
    }
    loading.value = false;
  }

  showPopup(){
    String msg='''
    تتم عمليات البيع والشراء مباشرة بين التاجر والزبون دون أي وسيط.
وفي حال تعذّر على التاجر توصيل البضاعة، يمكنه الاستفادة من خدمة الشحن بشكل اختياري، وذلك عبر النقر على "طلب جديد" وتسجيل معلومات الشحنة.

⚠ ملاحظة هامة: تأكد من إدخال معلومات الشحنة بدقة، حيث لن يتم قبول الطلب في حال وجود أي خطأ في البيانات المسجلة.
     ''';

    Get.dialog(AlertDialog(
      title: Text('تعليمات شحن'),
      content: Text(msg),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('حسنا'),
        ),
      ],
    ));
  }
}
