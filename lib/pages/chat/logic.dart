

import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/message_community_model.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as audio;
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loadingSend = RxBool(false);
  TextEditingController messageController = TextEditingController(text: "${Get.parameters['msg']??''}");
  Rxn<XFile> file = Rxn<XFile>(null);
  RxBool loading = RxBool(false);
  RxBool hasMorePage = RxBool(false);
  RxInt page = RxInt(1);
  RxList<MessageCommunityModel> messages = RxList<MessageCommunityModel>([]);
  CommunityModel communityModel = Get.arguments;
  ScrollController scrollController = ScrollController();
  // Audio
  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  RxBool mPlayerIsInited = false.obs;
  RxBool mRecorderIsInited = false.obs;

  RxBool mplaybackReady = false.obs;
  //String? _mPath;
  List<double> bufferF32 = [];
  List<int> bufferI16 = [];
  List<int> bufferU8 = [];
  int sampleRate = 0;
  audio.Codec codecSelected = audio.Codec.pcmFloat32;

  Future<void> openRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await mRecorder!.openRecorder();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
    sampleRate = 16000;


      mRecorderIsInited.value = true;

  }
  // Audio
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
    // mainController.pusher
    //     .subscribe(
    //         'private-message.${communityModel.id}.${mainController.authUser.value?.id}')
    //     .bind('message.create', (event) {
    //   messages.insert(0, MessageCommunityModel.fromJson(event['message']));
    // });
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
     // mainController.logger.i(res?.data?['data']?['messages']?['data']);
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
if(messageController.text.length==0){
  return;
}
    loadingSend.value = true;

    int? sellerId = mainController.authUser.value?.id == communityModel.user?.id
        ? communityModel.seller?.id
        : communityModel.user?.id;
    mainController.query.value = '''
    mutation CreateMessage {
      createMessage(userId: ${mainController.authUser.value?.id}, sellerId: $sellerId, message: "${messageController.text.replaceAll("\n", '')}") {
        message
        attach
        created_at
          user {
            id
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
     //  mainController.logger.e(res?.data);
      if (res?.data?['data']['createMessage'] != null) {
        messageController.clear();
        messages.insert(
            0,
            MessageCommunityModel.fromJson(
                res?.data?['data']['createMessage']));
      }
    } catch (e) {
      mainController.logger.e("Error Send ${e}");
    }
loadingSend.value = false;
  }

  uploadFileMessage() async {
    if (file.value == null) {
      return;
    }
    loadingSend.value = true;
    int? sellerId = mainController.authUser.value?.id == communityModel.user?.id
        ? communityModel.seller?.id
        : communityModel.user?.id;
    Map<String,dynamic> datajson={
      "query":"mutation CreateMessage(\$userId: Int!, \$sellerId: Int!, \$message: String!, \$attach: Upload!) { createMessage(userId: \$userId, sellerId: \$sellerId, message: \$message, attach: \$attach) { user {   id name seller_name image logo } message attach created_at }}",
   "variables":<String,dynamic>{
     "userId":mainController.authUser.value?.id,
     "sellerId": sellerId,
     "message": "",
     "attach": null
   }
    };
    String map = '''
    {
  "attach": ["variables.attach"]
}
    ''';

    Map<String, XFile?> data = {
      'attach':file.value
    };
try{
  dio.Response res=await mainController.dio_manager.executeGraphQLQueryWithFile(json.encode(datajson),map: map,files: data);
  if(res.data?['data']?['createMessage']!=null){
   // mainController.logger.e(res.data?['data']?['createMessage']);
    messages.insert(
        0,
        MessageCommunityModel.fromJson(
            res.data?['data']['createMessage']));
  }
}catch(e){
  mainController.logger.e('Error Upload $e');
}
    loadingSend.value = false;
  }

  Future<void> pickImage({required ImageSource imagSource}) async {
    file.value = null;
    XFile? selected = await ImagePicker().pickImage(source: imagSource);
    if (selected != null) {
      file.value = selected;
      await uploadFileMessage();
    }
  }
}
