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
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
class ChatLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loadingSend = RxBool(false);
  TextEditingController messageController =
      TextEditingController(text: "${Get.parameters['msg']!=null?Get.parameters['msg']: ''}");
  Rxn<XFile> file = Rxn<XFile>(null);
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxList<MessageModel> messages = RxList<MessageModel>([]);
  Rxn<CommunityModel> communityModel = Rxn<CommunityModel>(null);
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
        print("PATH IS ${path}");
      } else {
        print("PATH IS ${path}");
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
    _localFile.then((value) {
      initRecord(value);
    });

    // TODO: implement onInit
    super.onInit();
    communityModel.value = Get.arguments;

    getDataFromStorage();
    ever(page, (value) {
      getMessages();
    });

    ever(messages, (value){
      if(value.last.user?.id==mainController.authUser.value?.id){
        messageController.clear();
        file.value=null;
      }

      if(mainController.storage.hasData('communities-${communityModel.value?.id}')){
        mainController.storage.remove('communities-${communityModel.value?.id}');
      }
       mainController.storage.write('communities-${communityModel.value?.id}', messages.map((el)=>el.toJson()).toList());
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
    
query GetMessages {
    getMessages(communityId: ${communityModel.value?.id}, first: 15, page: ${page.value}) {
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
      mainController.logger.d(res?.data?['data']);
      if (res?.data?['data']?['getMessages']?['paginatorInfo'] != null) {
        hasMorePage.value = res?.data?['data']?['getMessages']?['paginatorInfo']
            ['hasMorePages'];
      }
      if (res?.data?['data']?['getMessages']?['data'] != null) {
        for (var item in res?.data?['data']?['getMessages']?['data']) {
          messages.add(MessageModel.fromJson(item));
        }
        if(mainController.storage.hasData('communities-${communityModel.value?.id}')){
          mainController.storage.remove('communities-${communityModel.value?.id}');
        }
        await mainController.storage.write('communities-${communityModel.value?.id}', res?.data?['data']?['getMessages']?['data']);
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e(e);
    }
    loading.value = false;
  }

  getDataFromStorage() {
    var listProduct = mainController.storage.read('communities-${communityModel.value?.id}')??[];

    for (var item in listProduct) {
      messages.add(MessageModel.fromJson(item));
    }
  }

  sendTextMessage() async {
    if (messageController.text.length == 0) {
      return;
    }
    mainController.loading.value = true;

    mainController.query.value = '''
  mutation CreateMessage {
    CreateMessage(communityId: ${communityModel.value?.id}, body: "${messageController.text}") {
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
    try {
      dio.Response? res = await mainController.fetchData();
      //mainController.logger.e(res?.data);
      if (res?.data?['data']['CreateMessage'] != null) {
        messageController.clear();
    /*    messages.insert(
            0, MessageModel.fromJson(res?.data?['data']['CreateMessage']));*/
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
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
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);
      mainController.logger.e(res.data);
      if (res.data?['data']?['CreateMessage'] != null) {
        messages.insert(
            0, MessageModel.fromJson(res.data?['data']['CreateMessage']));
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
      int? width=image.width;
      int? height=image.height;
      if(width>300){
        width=300;
        height=(width*(image.height/image.width)).toInt();
      }

      file.value = await mainController.commpressImage(file: selected,width: width,height: height);

      await uploadFileMessage();
    }
  }
}
