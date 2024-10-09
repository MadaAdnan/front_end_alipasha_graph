import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../models/message_community_model.dart';

class LiveLogic extends GetxController {
  TextEditingController msgController = TextEditingController();
  RxList<MessageModel> messages = RxList<MessageModel>([]);
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  RxBool loadingSend = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  ScrollController scrollController = ScrollController();

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(page, (value) {
      getMessages();
    });
  }


  @override
  void onReady() {
    super.onReady();
    getMessages();
  }

  getMessages() async {
    loading.value = true;
    mainController.query.value = '''
query GetLiveMessages {
    getLiveMessages(first: 25, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            body
            user {
            id
                name
                image
            }
            created_at
        }
    }
}
  ''';

    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['getLiveMessages']?['paginatorInfo'] != null) {
        hasMorePage.value = bool.tryParse(
            "${res
                ?.data?['data']?['getLiveMessages']?['paginatorInfo']?['hasMorePages']}") ??
            false;
      }
      if (res?.data?['data']?['getLiveMessages']?['data'] != null) {
        for (var item in res?.data?['data']?['getLiveMessages']?['data']) {
          messages.insert(0,MessageModel.fromJson(item));
        }
      }
    } catch (e) {
      mainController.logger.e("Error GetCommunity");
    }
    loading.value = false;
    if (page.value == 1) {
      Future.delayed(Duration(milliseconds: 200), () =>
          goScrollTo(position: scrollController.position.maxScrollExtent)
      );
    }
  }

  sendMessage() async {
    loadingSend.value = true;
    mainController.query.value = '''
    
mutation CreateLiveMessage {
    createLiveMessage(body: "${msgController.text}") {
        body
        created_at
        user {
        id
            name
            image
        }
    }
}

     ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['createLiveMessage'] != null) {
        msgController.value = TextEditingValue.empty;
        messages.add(
            MessageModel.fromJson(res?.data?['data']?['createLiveMessage']));
        goScrollTo(position: scrollController.position.maxScrollExtent);
      }
    } catch (e) {

    }
    loadingSend.value = false;
  }

  goScrollTo({required double position}) {
    scrollController.animateTo(position, duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut);
  }

}
