import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../models/partner_model.dart';

class PartnerLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxList<PartnerModel> partners = RxList<PartnerModel>([]);

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(page, (value) {
      getPartner();
    });
  }

  @override
  onReady() {
    super.onReady();
    getPartner();
  }

  getPartner() async {
    loading.value = true;
    mainController.query.value = '''
    query Partners {
    partners(first: 15, page: ${page.value}) {
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
     // mainController.logger.e(response?.data['data']['partners']?['paginatorInfo'] );
      if (response?.data['data']['partners']?['paginatorInfo'] != null) {
        hasMorePage.value = response?.data['data']['partners']?['paginatorInfo']
                ['hasMorePages'] ??
            false;
      }
      if (response?.data['data']['partners']?['data'] != null) {
        print('TEST');
        for (var item in response?.data['data']['partners']?['data']) {
          partners.add(PartnerModel.fromJson(item));
        }
      }
      if(response?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${response?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {}
    loading.value = false;
  }
}
