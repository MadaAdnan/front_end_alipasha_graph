import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/order_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

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
    loading.value = false;
  }
}
