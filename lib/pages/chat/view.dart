import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/redcord_manager.dart';
import 'package:ali_pasha_graph/models/message_community_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final logic = Get.find<ChatLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
// mainController.logger.w();
          if (logic.scrollController.position.atEdge &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !mainController.loading.value &&
              logic.hasMorePage.value) {
            logic.nextPage();
          }

          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 0.085.sh,
              width: 1.sw,
              alignment: Alignment.center,
              color: RedColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 1.sw,
                    alignment: Alignment.center,
                    height: 0.085.sh,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (logic.communityModel.users?[0] != null)
                          Positioned(
                            right: 0.08.sw,
                            child: Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${logic.communityModel.users?[0]
                                          .image}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        if (logic.communityModel.users!.length > 1)
                          Positioned(
                            right: 0.12.sw,
                            child: Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${logic.communityModel.users?[1]
                                          .image}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        if (logic.communityModel.users!.length > 2)
                          Positioned(
                            right: 0.16.sw,
                            child: Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${logic.communityModel.users?[2]
                                          .image}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                            right: 0.3.sw,
                            child: Text(
                              '${mainController.authUser.value?.name} & ${logic
                                  .communityModel.users!.where((el) =>
                              el.id != mainController.authUser.value?.id)
                                  .firstOrNull?.seller_name!.length !=0 ?logic
                                  .communityModel.users!.where((el) =>
                              el.id != mainController.authUser.value?.id)
                                  .firstOrNull?.seller_name : logic
                                  .communityModel.users!.where((el) =>
                              el.id != mainController.authUser.value?.id)
                                  .firstOrNull?.name}',
                              style: H3WhiteTextStyle,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Obx(() {
              return ListView(
                reverse: true,
                controller: logic.scrollController,
                padding: EdgeInsets.symmetric(
                    vertical: 0.01.sh, horizontal: 0.02.sw),
                children: [
                  ...List.generate(logic.messages.length, (index) {
                    bool isIam = mainController.authUser.value?.id ==
                        logic.messages[index].user?.id;
                    if (isIam)
                      return myMessage(context, message: logic.messages[index]);
                    else
                      return anotherMessage(context,
                          message: logic.messages[index]);
                  }),
                  if (logic.loading.value)
                    Container(
                      alignment: Alignment.center,
                      width: 1.sw,
                      height: 0.05.sh,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'جاري جلب البيانات',
                            style: H4GrayTextStyle,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                ],
              );
            })),
            Container(
              width: 1.sw,
              height: 0.07.sh,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 0.85.sw,
                      height: 0.06.sh,
                      child: FormBuilderTextField(
                        name: 'msg',
                        controller: logic.messageController,
                        style: H4BlackTextStyle,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(color: GrayLightColor)),
                          suffixIcon: Container(
                            width: 0.1.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      logic.pickImage(
                                          imagSource: ImageSource.gallery);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.paperclip,
                                      size: 0.04.sw,
                                    ),
                                  ),
                                  width: 0.05.sw,
                                ),
                                Obx(() {
                                  if (!logic.mRecorderIsInited.value) {
                                    return Container(
                                      width: 0.05.sw,
                                      child: IconButton(
                                        onPressed: () {
                                           logic.startRecording();
                                          Get.defaultDialog(
                                              title: ' ',
                                              content: Container(
                                                child: Column(
                                                  children: [
                                                   Container(
                                                     width: 0.12.sw,
                                                     height: 0.12.sw,
                                                     child:  Obx(() {
                                                       if (logic
                                                           .mRecorderIsInited
                                                           .value) {

                                                         return AnimatedContainer(
                                                           constraints: BoxConstraints.expand(width:0.08.sw,height: 0.08.sw),
                                                           duration: Duration(milliseconds: 200),
                                                           height: (logic.mRecordingLevel /1000).sw,
                                                           width:  (logic.mRecordingLevel/ 1000).sw,
                                                           decoration:
                                                           BoxDecoration(
                                                             color: RedColor,
                                                             borderRadius:
                                                             BorderRadius
                                                                 .circular(
                                                                 150.r),
                                                           ),
                                                           child:  InkWell(
                                                               onTap: () {
                                                                 logic
                                                                     .stopRecorder();
                                                               },
                                                               child: Center(
                                                                 child: Icon(
                                                                   Icons.stop,
                                                                   color: Colors
                                                                       .white,
                                                                   size:0.08.sw , // تغيير حجم الأيقونة بناءً على شدة الصوت
                                                                 ),
                                                               ),
                                                             ),

                                                         );
                                                       }
                                                       return Container(
                                                         width: 0.15.sw,
                                                         height: 0.15.sw,
                                                         alignment:
                                                         Alignment.center,
                                                         decoration: BoxDecoration(
                                                             borderRadius:
                                                             BorderRadius
                                                                 .circular(
                                                                 100.r),
                                                             color:
                                                             GrayLightColor),
                                                         child: IconButton(
                                                             onPressed: () {
                                                               logic
                                                                   .startRecording();
                                                             },
                                                             icon: Icon(
                                                               FontAwesomeIcons
                                                                   .microphone,
                                                               size: 0.08.sw,
                                                               color: WhiteColor,
                                                             )),
                                                       );
                                                     }),
                                                   ),
                                                    SizedBox(height: 0.01.sh),
                                                    Obx(() {
                                                      if (logic.recordedFilePath
                                                          ?.value !=
                                                          null &&
                                                          logic.mRecorderIsInited
                                                              .value ==
                                                              false) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: [
                                                            if (logic
                                                                .mPlayerIsInited
                                                                .value ==
                                                                false)
                                                              IconButton(
                                                                onPressed: (){
                                                                  logic
                                                                      .playRecordedAudio();
                                                                },
                                                                icon: Icon(
                                                                    FontAwesomeIcons
                                                                        .solidCirclePlay),
                                                              ),
                                                            if (logic
                                                                .mPlayerIsInited
                                                                .value ==
                                                                true)
                                                              IconButton(
                                                                onPressed: logic
                                                                    .stopPlayer,
                                                                icon: Icon(
                                                                    FontAwesomeIcons
                                                                        .solidCircleStop),
                                                              ),
                                                          ],
                                                        );
                                                      }

                                                      return Container();
                                                    }),
                                                    Obx(() {
                                                      if (logic
                                                          .mRecorderIsInited
                                                          .value) {
                                                        return Container();
                                                      }
                                                      return Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              if(logic.recordedFilePath?.value!=null){
                                                                logic.file.value = XFile("${logic.recordedFilePath!.value}");
                                                              }
                                                              Get.back();
                                                              await logic
                                                                  .uploadFileMessage();
                                                              logic
                                                                  .recordedFilePath!
                                                                  .value = '';

                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  0.05
                                                                      .sw,
                                                                  vertical:
                                                                  0.02.sw),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    50.r),
                                                              ),
                                                              child: Text(
                                                                'إرسال',
                                                                style:
                                                                H4WhiteTextStyle,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              logic
                                                                  .recordedFilePath!
                                                                  .value = '';
                                                              Get.back();
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  0.05
                                                                      .sw,
                                                                  vertical:
                                                                  0.02.sw),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: RedColor,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    50.r),
                                                              ),
                                                              child: Text(
                                                                'إلغاء',
                                                                style:
                                                                H4WhiteTextStyle,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    })
                                                  ],
                                                ),
                                              ));

                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.microphone,
                                          size: 0.04.sw,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: 0.05.sw,
                                      child: IconButton(
                                        onPressed: () {
                                          logic.stopRecorder();
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.stop,
                                          size: 0.04.sw,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Obx(() {
                    if (logic.loadingSend.value)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return InkWell(
                      onTap: () {
                        if (logic.messageController.text.length > 0) {
                          logic.sendTextMessage();
                        }
                      },
                      child: Container(
                        height: 0.06.sh,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.03.sw, vertical: 0.02.sw),
                        decoration: BoxDecoration(
                          color: OrangeColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          'إرسال',
                          style: H4WhiteTextStyle,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isURL(String text) {
    final RegExp urlRegExp =
    RegExp(r'^(https?:\/\/)?' //  بدء الرابط بـ "http://" أو "https://"
    r'([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,}' // النطاق مثل "example.com"
    r'(:\d+)?(\/[^\s]*)?$' // اختياري: المنفذ والمسار
    );
    return urlRegExp.hasMatch(text);
  }

  Widget myMessage(context, {required MessageModel message}) {
    return Container(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: 0.09.sw,
                height: 0.09.sw,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('${message.user?.image}'))),
              ),
              SizedBox(
                width: 0.01.sw,
              ),
              Text(
                "${message.user?.name}",
                style: H3BlackTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 0.004.sh,
          ),
          if (message.type == 'text')
            Container(
              width: 0.75.sw,
              padding:
              EdgeInsets.symmetric(vertical: 0.009.sh, horizontal: 0.02.sw),
              decoration: BoxDecoration(
                color: RedColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                    topLeft: Radius.circular(30.r)),
              ),
              child: RichText(
                softWrap: true,
                text: TextSpan(children: [
                  ..."${message.body}".split(' ').map((el) {
                    if (isURL("$el")) {
                      return TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async => await openUrl(url: '$el'),
                        text: ' $el ',
                        style: H3WhiteTextStyle.copyWith(height: 1.5),
                      );
                    } else {
                      return TextSpan(
                          text: ' $el ',
                          style: H3WhiteTextStyle.copyWith(height: 1.5));
                    }
                  })
                ]),
              ),
            ),
          if (message.type == 'wav'|| message.type == 'aac')
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 0.004.sw, horizontal: 0.004.sw),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: RedColor.withOpacity(0.5)),
              child: PlayerSoundMessage(
                path: message.attach,
              ),
            ),
          if (message.type != 'text' && message.type != 'wav'&& message.type != 'aac')
            InkWell(
              child: Container(
                width: 0.7.sw,
                height: 0.6.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider("${message.attach}"),
                        fit: BoxFit.cover)),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      Dialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                                imageUrl: '${message.attach}',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      child: Image(
                                        image: imageProvider,
                                      ),
                                    )),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: WhiteColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: DarkColor,
                                            blurRadius: 0.02.sw)
                                      ]),
                                  child:
                                  Icon(Icons.close, color: RedColor, size: 30),
                                ),
                                onPressed: () => Get.back(),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                color: Colors.black.withOpacity(0.7),
                                child: Text(
                                  'Image Description', // وصف الصورة
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                );
              },
            ),
          SizedBox(
            height: 0.008.sh,
          ),
          Container(
            width: 0.7.sw,
            alignment: Alignment.centerLeft,
            child: Text(
              '${message.createdAt}',
              style: H4GrayTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget anotherMessage(context, {required MessageModel message}) {
    return Container(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${message.user?.name}",
                style: H3BlackTextStyle,
              ),
              SizedBox(
                width: 0.01.sw,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: 0.09.sw,
                height: 0.09.sw,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('${message.user?.image}'))),
              ),
            ],
          ),
          SizedBox(
            height: 0.004.sh,
          ),
          if (message.type == 'text')
            Container(
              width: 0.75.sw,
              padding:
              EdgeInsets.symmetric(vertical: 0.009.sh, horizontal: 0.02.sw),
              decoration: BoxDecoration(
                color: GrayLightColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                    topLeft: Radius.circular(0)),
              ),
              child: RichText(
                softWrap: true,
                text: TextSpan(children: [
                  ..."${message.body}".split(' ').map((el) {
                    if (isURL("$el")) {
                      return TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async => await openUrl(url: '$el'),
                        text: ' $el ',
                        style: H3OrangeTextStyle.copyWith(height: 1.5),
                      );
                    } else {
                      return TextSpan(text: ' $el ', style: H3BlackTextStyle);
                    }
                  })
                ]),
              ),
            ),
          if (message.type == 'wav' || message.type == 'aac')
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 0.004.sw, horizontal: 0.004.sw),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150.r),
                  color: GrayLightColor),
              child: PlayerSoundMessage(
                path: message.attach,
              ),
            ),
          if (message.type != 'text' && message.type != 'wav'&& message.type != 'aac')
            InkWell(
              child: Container(
                width: 0.7.sw,
                height: 0.6.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider("${message.attach}"),
                        fit: BoxFit.cover)),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      Dialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                                imageUrl: '${message.attach}',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      child: Image(
                                        image: imageProvider,
                                      ),
                                    )),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: WhiteColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: DarkColor,
                                            blurRadius: 0.02.sw)
                                      ]),
                                  child:
                                  Icon(Icons.close, color: RedColor, size: 30),
                                ),
                                onPressed: () => Get.back(),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                color: Colors.black.withOpacity(0.7),
                                child: Text(
                                  'Image Description', // وصف الصورة
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                );
              },
            ),
          SizedBox(
            height: 0.008.sh,
          ),
          Container(
            width: 0.7.sw,
            alignment: Alignment.centerRight,
            child: Text(
              '${message.createdAt}',
              style: H4GrayTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerSoundMessage extends StatelessWidget {
  PlayerSoundMessage({super.key, this.path});

  RxBool play = RxBool(false);
  final String? path;
  RecorderManager recorderManager = RecorderManager();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: play.value
            ? IconButton(
            onPressed: () async {
              await stopPlayer();
            },
            icon: Icon(FontAwesomeIcons.stop))
            : IconButton(
            onPressed: () async {
              await playAudio();
            },
            icon: Icon(FontAwesomeIcons.play)),
      );
    });
  }

  Future<void> playAudio() async {
    if (!play.value) {
      await recorderManager.playRecordedAudio(path: path);
      play.value = true;
    }
  }

  Future<void> stopPlayer() async {
    await recorderManager.StopPlayRecordedAudio();
    play.value = false;
  }
}
