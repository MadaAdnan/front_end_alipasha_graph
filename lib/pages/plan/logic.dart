import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../models/plan_model.dart';

class PlanLogic extends GetxController {
  RxBool loading = false.obs;
  RxList<PlanModel> plans = RxList([]);
  MainController mainController = Get.find<MainController>();
  RxnDouble balance = RxnDouble(null);

  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getPlans();
  }

  getPlans() async {
    loading.value = true;
    mainController.query.value = '''
   query Plans {
     me {
      
        total_balance
       
    }
    plans {
        id
        price
        name
        is_discount
        discount
        type
        info
        items {
            active
            item
        }
       duration
special_count
products_count
ads_count
special_store
    }
}

   ''';

    try {
      dio.Response? res = await mainController.fetchData();
      loading.value = false;
      // mainController.logger.e(res?.data);
      if (res?.data['data']['me']['total_balance'] != null) {
        balance.value =
            double.tryParse("${res?.data['data']['me']['total_balance']}");
      }
      if (res?.data?['data']['plans'] != null) {
        for (var item in res?.data?['data']['plans']) {
          plans.add(PlanModel.fromJson(item));
        }
      }
    } catch (e) {
      mainController.logger.e("Plans Error $e");
    }
    loading.value = false;
  }

  subscribePlan({required int planId}) async {
    loading.value = true;
    mainController.query.value = '''
    mutation SubscribePlan {
    subscribePlan(id: "$planId}") {
       $AUTH_FIELDS
    }
}
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      // mainController.logger.i("${res?.data}");
      if (res?.data?['errors']?[0]?['message'] != null) {
        messageBox(
            title: 'خطأ',
            message: res?.data['errors'][0]?['message'],
            isError: true);
      }
      if (res?.data?['data']?['subscribePlan'] != null) {
        mainController.setUserJson(json: res?.data['data']['subscribePlan']);
        if (res?.data['data']['subscribePlan']['total_balance'] != null) {
          balance.value = double.tryParse(
              res?.data['data']['subscribePlan']['total_balance']);
        }
      }
    } catch (e) {
      mainController.logger.e("Error In Subscribe Plan $e");
    }
    loading.value = false;
  }
}
