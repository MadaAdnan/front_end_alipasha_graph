import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../helpers/queries.dart';
import '../../models/user_model.dart';
import 'package:dio/dio.dart' as dio;
class FollowingLogic extends GetxController {

  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  MainController mainController = Get.find<MainController>();
  RxList<UserModel> users = RxList<UserModel>([]);
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
    mainController.logger.e('ERROR ERROR');
    ever(page, (value) {
      getMyFollowing();
    });


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getMyFollowing();
  }




  getMyFollowing()async{
    loading.value=true;
  mainController.query.value=  ''' 
    query GetMyFollowing {
    getMyFollowing(first:25, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            user {
                id
                name
                seller_name
                image
            }
        }
        
    }
}

    ''';

    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.d(res?.data?['data']);
      if (res?.data?['data']?['getMyFollowing']?['paginatorInfo']!=null) {
        hasMorePage.value = bool.tryParse(
            "${res?.data?['data']?['getMyFollowing']?['paginatorInfo']?['hasMorePages']}") ??
            false;
      }
      if (res?.data?['data']?['getMyFollowing']?['data']!=null) {
        for (var item in res?.data?['data']?['getMyFollowing']?['data']) {
          users.add(UserModel.fromJson(item['user']));
        }
      }
    }catch (e) {}
    loading.value = false;
  }

  Future<void> unFollowing(int sellerId) async {
    try {
      mainController.query.value = '''
     mutation UnFollowing {
    unFollowing(id: "$sellerId") {
        id
        name
    }
}

      ''';
      dio.Response? res = await mainController.fetchData();
      // mainController.logger.e(res?.data);
      if (res?.data?['data']?['unFollowing']?['id'] != null) {
        int index = users.indexWhere((el) => el.id == sellerId);
        if (index > -1) {
          users.removeAt(index);
        }
      }
    }  catch (e) {
      mainController.logger.e(e);
    }
  }
}
