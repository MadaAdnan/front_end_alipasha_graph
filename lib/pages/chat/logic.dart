import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/redcord_manager.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/message_community_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

import 'package:pusher_client_socket/channels/channel.dart';

import '../../routes/routes_url.dart';
import '../channel/logic.dart';
import '../communities/logic.dart';
import '../group/logic.dart';

class ChatLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loadingSend = RxBool(false);
  TextEditingController messageController = TextEditingController();
  Rxn<XFile> file = Rxn<XFile>(null);
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxList<MessageModel> messages = RxList<MessageModel>([]);
  Rxn<CommunityModel> communityModel = Rxn<CommunityModel>(null);
  RxnInt communityId = RxnInt(null);
  ScrollController scrollController = ScrollController();
  RxnString message = RxnString(Get.parameters['msg']);

  // Audio

  RxBool mPlayerIsInited = false.obs;
  RxBool mRecorderIsInited = false.obs;

  RxBool mplaybackReady = false.obs;

  //String? _mPath;
  List<double> bufferF32 = [];
  List<int> bufferI16 = [];
  List<int> bufferU8 = [];
  int sampleRate = 0;

  RxString? recordedFilePath = RxString('');
  RxDouble mRecordingLevel = RxDouble(0);
  RecorderManager recorder = RecorderManager();

  Future<void> startRecording() async {
    await recorder.startRecording();
    mRecorderIsInited.value = true;
  }

  Future<void> stopRecorder() async {
    await recorder.stopRecording().then((path) {
      if (path != null) {
        recordedFilePath!.value = path;
      }
    });
    mRecorderIsInited.value = false;
  }

  Future<void> playRecordedAudio() async {
    mPlayerIsInited.value = true;
    await recorder.playRecordedAudioNetWork(filePath: recordedFilePath?.value);
  }

  Future<void> stopPlayer() async {
    await recorder.StopPlayRecordedAudio();
    mPlayerIsInited.value = false;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get _localFile async {
    final path = await _localPath;
    return '$path/recorded_audio.acc';
  }

  // Audio

  nextPage() {
    if (hasMorePage.value) {
      page.value++;
    }
  }

  Future<void> initRecord(String path) async {
    await recorder.init(path: path);
  }

  @override
  void onInit() {
    communityModel.value = Get.arguments;
    _localFile.then((value) {
      initRecord(value);
    });
    getDataFromStorage();
    // TODO: implement onInit
    super.onInit();
    communityModel.value = Get.arguments;
ever(communityId, (value){
  if(page.value>1){
    page.value=1;
  }else{
    getMessages();
  }
  messages([]);
});
    ever(page, (value) {
      getMessages();
    });

    ever(messages, (value) {
      if (value.last.user?.id == mainController.authUser.value?.id) {
        file.value = null;
      }

      if (mainController.storage
          .hasData('communities-${communityModel.value?.id}')) {
        mainController.storage
            .remove('communities-${communityModel.value?.id}');
      }
      mainController.storage.write('communities-${communityModel.value?.id}',
          messages.map((el) => el.toJson()).toList());
    });
    messageController.value=TextEditingValue(text: Get.parameters['msg']??'');
  }

  @override
  void onReady() {
    super.onReady();
    communityId.value =
        Get.arguments?.id ?? int.tryParse("${Get.parameters['id']}");
    String channelName = "private-message.${communityModel.value?.id}";
    mainController.communitySubscribe(channelName);
    messageController.value =
        TextEditingValue(text: Get.parameters['msg'] ?? '');
    getMessages();
  }

  getMessages() async {
    Logger().f("COMM $communityId");
    mainController.query.value = '''
  query GetMessages {
  ${communityModel.value == null ? '''
   community(id: "${communityId.value}") {
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
    }
   ''' : ''}
    getMessages(communityId: ${communityId}, first: 35, page: ${page.value}) {
        paginatorInfo {
            hasMorePages
        }
        data {
        id
            body
            type
            created_at
            attach
            user {
                id
                name
                trust
                seller_name
                image
            }
        }
    }
}

    ''';
    loading.value = true;
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.f(res?.data);
      if (res?.data['data']?['community'] != null) {
        communityModel.value =
            CommunityModel.fromJson(res?.data['data']?['community']);
      }
      if (res?.data?['data']?['getMessages']?['paginatorInfo'] != null) {
        hasMorePage.value = res?.data?['data']?['getMessages']?['paginatorInfo']
            ['hasMorePages'];
      }
      if (res?.data?['data']?['getMessages']?['data'] != null) {
        try {
          if (page.value == 1) {
            messages.clear();
          }
        } catch (e) {}

        for (var item in res?.data?['data']?['getMessages']?['data']) {
          messages.add(MessageModel.fromJson(item));
        }
        if (mainController.storage
            .hasData('communities-${communityId.value}')) {
          await mainController.storage
              .remove('communities-${communityId.value}');
        }

        await mainController.storage.write('communities-${communityId.value}',
            res?.data?['data']?['getMessages']?['data']);
      }
      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: '${res?.data['errors'][0]['message']}', type: 'error');
      }
    } catch (e) {
      mainController.logger.e(e);
    }
    loading.value = false;
  }

  getDataFromStorage() {
    var listProduct =
        mainController.storage.read('communities-${communityId.value}') ?? [];
    for (var item in listProduct) {
      messages.add(MessageModel.fromJson(item));
    }
  }

  sendTextMessage() async {
    if (messageController.text.length == 0) {
      return;
    }

    mainController.loading.value = true;
    messages.insert(
        0,
        MessageModel(
            id: 0,
            body: messageController.text,
            createdAt: 'منذ ثانية',
            type: 'text',
            user: mainController.authUser.value));
    mainController.query.value = '''
  mutation CreateMessage(\$communityId:Int!,\$body:String) {
    CreateMessage(communityId:\$communityId, body:\$body) {
        body
        type
        created_at
        attach
        user {
            id
            name
            seller_name
            image
            logo
        }
    }
}
    ''';
    mainController.variables.value = {
      'communityId': communityModel.value?.id,
      "body": "${messageController.text}"
    };
    try {
      messageController.clear();
      dio.Response? res = await mainController.fetchData();
      mainController.variables.value = null;
      if (res?.data?['data']?['CreateMessage'] != null) {
        int index = messages.indexWhere((el) => el.id == 0);
        if (index > -1) {
          messages[index] =
              MessageModel.fromJson(res?.data?['data']?['CreateMessage']);
        }
      }
      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: '${res?.data['errors'][0]['message']}', type: 'error');
        mainController.logger.e("Error Send ${res?.data['errors']}");
      }
    } catch (e) {
      mainController.logger.e("Error Send ${e}");
    }
    mainController.loading.value = false;
  }

  uploadFileMessage() async {
    if (file.value == null) {
      return;
    }
    mainController.loading.value = true;
    int? sellerId =
        mainController.authUser.value?.id == communityModel.value?.manager?.id
            ? communityModel.value?.manager?.id
            : communityModel.value?.manager?.id;
    Map<String, dynamic> datajson = {
      "query":
          r"""mutation CreateMessage($communityId:Int!, $body: String!, $attach: Upload) {
       CreateMessage(communityId: $communityId,  body: $body, attach: $attach){
       body
      type
      attach
      created_at
      user {
        id
        name
        image
      }
      }
      }""",
      "variables": <String, dynamic>{
        "communityId": communityModel.value?.id,
        "body": "",
        "attach": null
      }
    };
    String map = '''
    {
  "attach": ["variables.attach"]
}
    ''';

    Map<String, XFile?> data = {'attach': file.value};
    try {
      messages.insert(
          0,
          MessageModel(
              id: 0,
              body: '',
              createdAt: 'منذ ثانية',
              attach: file.value?.path,
              type: 'text',
              user: mainController.authUser.value));

      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);
      file.value = null;
      mainController.logger.w(res.data?['data']?['CreateMessage']);
      if (res.data?['data']?['CreateMessage'] != null) {
        int index = messages.indexWhere((el) => el.id == 0);
        if (index > -1) {
          messages[index] =
              MessageModel.fromJson(res?.data?['data']?['CreateMessage']);
        }
      }
    } catch (e) {
      mainController.logger.e('Error Upload $e');
    }
    mainController.loading.value = false;
  }

  Future<void> pickImage({required ImageSource imagSource}) async {
    file.value = null;
    XFile? selected = await ImagePicker().pickImage(source: imagSource);

    if (selected != null) {
      File imageFile = File(selected.path);

      // نقرأ بيانات الصورة للحصول على أبعادها
      final data = await imageFile.readAsBytes();
      final codec = await ui.instantiateImageCodec(data);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      int? width = image.width;
      int? height = image.height;
      if (width > 300) {
        width = 300;
        height = (width * (image.height / image.width)).toInt();
      }

      file.value = await mainController.commpressImage(
          file: selected, width: width, height: height);

      await uploadFileMessage();
    }
  }
}
