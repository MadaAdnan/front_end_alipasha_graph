import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../models/partner_model.dart';
import 'package:dio/dio.dart' as dio;

class SellersLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxList<PartnerModel> sellers = RxList<PartnerModel>([]);

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(page, (value) {
      getSellers();
    });
  }

  @override
  onReady() {
    super.onReady();
    getSellers();
  }

  getSellers() async {
    loading.value = true;
    mainController.query.value = '''
    query Sellers {
    sellers(first: 15, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            id
            name
            city {
                name
            }
            address
            phone
            image
        }
    }
}

     ''';
    try {
      dio.Response? response = await mainController.fetchData();
      mainController.logger
          .e(response?.data['data']['sellers']?['paginatorInfo']);
      if (response?.data['data']['sellers']?['paginatorInfo'] != null) {
        hasMorePage.value = response?.data['data']['sellers']?['paginatorInfo']
                ['hasMorePages'] ??
            false;
      }
      if (response?.data['data']['sellers']?['data'] != null) {

        for (var item in response?.data['data']['sellers']?['data']) {
          sellers.add(PartnerModel.fromJson(item));
        }
      }
    } catch (e) {
      mainController.logger
          .e("Error get Sellers $e");
    }
    loading.value = false;
  }
}
