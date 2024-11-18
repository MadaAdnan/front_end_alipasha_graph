import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;


class CommunitiesLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxString search = RxString('');
  RxList<CommunityModel> communities = RxList<CommunityModel>([]);
  MainController mainController = Get.find();
  TextEditingController searchController = TextEditingController();

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getDataFromStorage();
    ever(page, (value) {
      if (value == 1) {
        communities.clear();
      }
      getCommunities();
    });
    ever(search, (value) {
      if (page.value > 1) {
        page.value = 1;
      } else {
        communities.clear();

        getCommunities();
      }
    });

  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getCommunities();
  }

  Future<void> getCommunities() async {
    loading.value = true;
    mainController.query.value = '''
    query Communities {
    getMyCommunity(
        search: "${search.value}",first: 25, page: ${page.value}) {
         data {
            id
            name
            image
            type
            last_update
            users_count
            manager{
            id 
            name
            seller_name
            logo
            }
            users{
                id
                name
                seller_name
                image
                trust
            }
            pivot {
                is_manager
                notify
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
      mainController.logger.e(res?.data);
      if (res?.data?['data']?['getMyCommunity']?['paginatorInfo'] != null) {
        hasMorePage.value = res?.data?['data']?['getMyCommunity']?['paginatorInfo']
            ['hasMorePages'];
      }

      if (res?.data?['data']?['getMyCommunity']?['data'] != null) {
       try{
         if(page.value==1){
           communities.clear();
         }
       }catch(e){

       }
        for (var item in res?.data?['data']?['getMyCommunity']?['data']) {
          communities.indexWhere((el) => el.id == item['id']) == -1
              ? communities.add(CommunityModel.fromJson(item))
              : null;
        }
        if(mainController.storage.hasData('communities')){
          mainController.storage.remove('communities');
        }
        await mainController.storage.write('communities', res?.data?['data']?['getMyCommunity']?['data'] );
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
      //searchController.clear();
    } catch (e) {
      mainController.logger.e(e);
    }
    loading.value = false;
  }

  getDataFromStorage() {
    var listProduct = mainController.storage.read('communities')??[];

    for (var item in listProduct) {
      communities.add(CommunityModel.fromJson(item));
    }
  }
}
