import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/balance_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class BalanceLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxInt page = RxInt(1);
  RxBool hasMore = RxBool(false);
  RxList<BalanceModel> balances = RxList<BalanceModel>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) => getBalances());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getBalances();
  }

  getBalances() async {
    if (page.value == 1) {
      balances.value = [];
    }
    mainController.query.value = '''
  query Balances {
    balances(first: 40, page: ${page}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            credit
            debit
            total
            info
            created_at
        }
    }
}
  ''';

    dio.Response? res = await mainController.fetchData();
    if (res?.data != null) {
      for (var item in res?.data['data']['balances']['data']) {
        balances.add(BalanceModel.fromJson(item));
      }
      hasMore.value =
          res?.data['data']['balances']['paginatorInfo']['hasMorePages'];
    }
    if(res?.data?['errors']?[0]?['message']!=null){
      mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
    }
  }
}
