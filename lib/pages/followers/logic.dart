import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import "package:dio/dio.dart" as dio;

class FollowersLogic extends GetxController {
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  MainController mainController = Get.find<MainController>();
  RxList<UserModel> sellers = RxList<UserModel>([]);
  RxBool loading = RxBool(false);

  nextPage() {
    if (hasMorePage.value == true) {
      page.value += 1;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) {
      getFollowers();
    });


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getFollowers();
  }

  getFollowers() async {
    loading.value = true;
    mainController.query.value = '''
    query GetMyFollowers {
    getMyFollowers(first: 10, page: ${page.value}) {
        data {
            seller {
                seller_name
                name
                image
                address
                id
            }
        }
         paginatorInfo {
            hasMorePages
        }
    }
}

    ''';

    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['getMyFollowers']?['paginatorInfo']!=null) {
        hasMorePage.value = bool.tryParse(
                "${res?.data?['data']?['getMyFollowers']?['paginatorInfo']?['hasMorePages']}") ??
            false;
      }
      if (res?.data?['data']?['getMyFollowers']?['data']!=null) {
        for (var item in res?.data?['data']?['getMyFollowers']?['data']) {
          sellers.add(UserModel.fromJson(item['seller']));
        }
      }
    } on CustomException catch (e) {}
    loading.value = false;
  }
}
