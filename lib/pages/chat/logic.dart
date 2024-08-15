import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/message_community_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class ChatLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loadingSend = RxBool(false);
  TextEditingController messageController = TextEditingController();

  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxList<MessageCommunityModel> messages = RxList<MessageCommunityModel>([]);
  CommunityModel communityModel = Get.arguments;
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
    mainController.pusher
        .subscribe(
            'private-message.${communityModel.id}.${mainController.authUser.value?.id}')
        .bind('message.create', (event) {
      messages.insert(0, MessageCommunityModel.fromJson(event['message']));
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getMessages();
  }

  getMessages() async {
    mainController.query.value = '''
    
query Messages {
    messages(community_id: ${communityModel.id}, first: 15, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
            user {
            id
                name
                seller_name
                image
                logo
            }
            message
            attach
            created_at
        }
    }
}

    ''';
    loading.value = true;
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.i(res?.data?['data']?['messages']?['data']);
      if (res?.data?['data']?['messages']?['paginatorInfo'] != null) {
        hasMorePage.value =
            res?.data?['data']?['messages']?['paginatorInfo']['hasMorePages'];
      }
      if (res?.data?['data']?['messages']?['data'] != null) {
        for (var item in res?.data?['data']?['messages']?['data']) {
          messages.add(MessageCommunityModel.fromJson(item));
        }
      }
    } catch (e) {
      mainController.logger.e(e);
    }
    loading.value = false;
  }

  sendTextMessage() async {
    loadingSend.value = true;
    int? sellerId = mainController.authUser.value?.id == communityModel.user?.id
        ? communityModel.seller?.id
        : communityModel.user?.id;
    mainController.query.value = '''
    mutation CreateMessage2 {
    createMessage(userId: ${mainController.authUser.value?.id}, sellerId: $sellerId, message: "${messageController.text}") {
    message
    created_at
        user {
            name
            seller_name
            image
            logo
        }
        community {
            id
            user {
                name
                seller_name
                image
                logo
            }
            last_change
            seller {
                name
                seller_name
                image
                logo
            }
        }
    }
}

    ''';
    try {
      dio.Response? res = await mainController.fetchData();
     // mainController.logger.e(res?.data);
      if (res?.data?['data']['createMessage'] != null) {
        messageController.clear();
        messages.insert(0,MessageCommunityModel.fromJson(
            res?.data?['data']['createMessage']));
      }
    } catch (e) {
      mainController.logger.e("Error Send ${e}");
    }
  }
}
