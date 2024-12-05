import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../models/message_community_model.dart';
import '../chat/view.dart';
import 'logic.dart';

class GroupPage extends StatelessWidget {
  GroupPage({Key? key}) : super(key: key);

  final logic = Get.find<GroupLogic>();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Container(
                    width: 1.sw,
                    alignment: Alignment.center,
                    height: 0.085.sh,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (logic.communityModel.users!.length > 0)
                          Positioned(
                            right: 0.08.sw,
                            child: Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${logic.communityModel.users?[0].image}"),
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
                                      "${logic.communityModel.users?[1].image}"),
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
                                      "${logic.communityModel.users?[2].image}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                            right: 0.3.sw,
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'عدد المشتركين : ',
                                    style: H4RegularDark.copyWith(
                                      color: WhiteColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${logic.communityModel.users_count}'
                                        .toFormatNumberK(),
                                    style: H4RegularDark.copyWith(
                                      color: WhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )),
                  Flexible(
                      child: PopupMenuButton<String>(
                    color: WhiteColor,
                    iconColor: WhiteColor,
                    onSelected: (value) async {
                      switch (value) {
                        case '1':
                          mainController.logger
                              .w(mainController.settings.value.support?.id);
                          if (mainController.settings.value.support?.id !=
                              null) {
                            mainController.createCommunity(
                                sellerId:
                                    mainController.settings.value.support!.id!,
                                message: ''' السلام عليكم ورحمة الله وبركاته 
                            إبلاغ  عن المجموعة ${logic.communityModel.name} #${logic.communityModel.id}'''
                                    .toString());
                          } else {
                            openUrl(
                                url:
                                    "https://wa.me/${mainController.settings.value.social?.phone}");
                          }

                          break;
                        default:
                          print('default');
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: '1',
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.headset,
                              color: GrayDarkColor,
                              size: 0.04.sw,
                            ),
                            SizedBox(
                              width: 0.02.sw,
                            ),
                            Text(
                              "إبلاغ عن المحادثة",
                              style: H3RegularDark,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
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
              padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              alignment: Alignment.center,
              constraints: BoxConstraints(maxHeight: 0.07.sh),
              width: 1.sw,
              height: 0.07.sh,
              decoration: const BoxDecoration(
                color: GrayWhiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    child: FormBuilderTextField(
                      name: 'msg',
                      controller: logic.messageController,
                      style: H2RegularDark.copyWith(color: Colors.black),
                      onChanged: (value) => logic.message.value = value,
                      decoration: InputDecoration(
                        fillColor: WhiteColor,
                        filled: true,
                        hintStyle: H5GrayTextStyle.copyWith(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0.02.sw),
                        suffixIcon: Container(
                          decoration: const BoxDecoration(
                              color: RedColor, shape: BoxShape.circle),
                          child: Transform.flip(
                            flipX: true,
                            child: Obx(() {

                              if (logic.message.value == null ||
                                  logic.message.value!.isEmpty) {
                                return IconButton(
                                    onPressed: () {
                                      if(mainController.loading.value){
                                        return;
                                      }
                                      logic.startRecording();
                                      Get.defaultDialog(
                                          title: ' ',
                                          content: Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 0.12.sw,
                                                  height: 0.12.sw,
                                                  child: Obx(() {

                                                    if (logic.mRecorderIsInited
                                                        .value) {
                                                      return AnimatedContainer(
                                                        constraints:
                                                            BoxConstraints
                                                                .expand(
                                                                    width:
                                                                        0.08.sw,
                                                                    height: 0.08
                                                                        .sw),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        height:
                                                            (logic.mRecordingLevel /
                                                                    1000)
                                                                .sw,
                                                        width:
                                                            (logic.mRecordingLevel /
                                                                    1000)
                                                                .sw,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: RedColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      150.r),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            logic
                                                                .stopRecorder();
                                                          },
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.stop,
                                                              color:
                                                                  Colors.white,
                                                              size: 0.08
                                                                  .sw, // تغيير حجم الأيقونة بناءً على شدة الصوت
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
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        if (logic
                                                                .mPlayerIsInited
                                                                .value ==
                                                            false)
                                                          IconButton(
                                                            onPressed: () {
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
                                                  if (logic.mRecorderIsInited
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

                                                          if (logic
                                                                  .recordedFilePath
                                                                  ?.value !=
                                                              null) {
                                                            logic.file.value =
                                                                XFile(
                                                                    "${logic.recordedFilePath!.value}");
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
                                                                      0.05.sw,
                                                                  vertical:
                                                                      0.02.sw),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
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
                                                                      0.05.sw,
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
                                    icon: const Icon(
                                      FontAwesomeIcons.microphone,
                                      color: WhiteColor,
                                    ));
                              }
                              return IconButton(
                                  onPressed: () {
                                    if(mainController.loading.value){
                                      return;
                                    }
                                    if (logic.messageController.text
                                        .trim()
                                        .isNotEmpty) {
                                      logic.sendTextMessage();
                                    }
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.paperPlane,
                                    color: WhiteColor,
                                  ));
                            }),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(150.r),
                          borderSide: const BorderSide(
                            color: RedColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(150.r),
                          borderSide: const BorderSide(
                            color: RedColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(150.r),
                          borderSide: const BorderSide(
                            color: RedColor,
                          ),
                        ),
                      ),
                    ),
                  )),
                  Transform.rotate(
                    angle: -0.78,
                    child: IconButton(
                        onPressed: () {
                          logic.pickImage(imagSource: ImageSource.gallery);
                        },
                        icon: const Icon(
                          FontAwesomeIcons.paperclip,
                          color: GrayDarkColor,
                        )),
                  ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.014.sh),
              child: Container(
                width: 0.09.sw,
                height: 0.09.sw,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            "${message.user?.image}"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle),
              ),
            ),
            SizedBox(
              width: 0.01.sw,
            ),
            Flexible(
                child: Text(
              "${message.user?.seller_name ?? message.user?.name}",
              style: H5OrangeTextStyle,
            )),
          ],
        ),
        Container(
          width: 0.75.sw,
          padding: EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.02.sw),
          margin: EdgeInsets.only(top: 0.005.sh),
          decoration: BoxDecoration(
              color: GrayLightColor, borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: RichText(
                  softWrap: true,
                  text: TextSpan(children: [
                    ..."${message.body}".split(' ').map((el) {
                      if (isURL("$el")) {
                        if(el.startsWith('https://wa.me')){
                          return WidgetSpan(
                              child: InkWell(
                                onTap: () {
                                  openUrl(url: '$el');
                                },
                                child: Container(
                                  alignment:Alignment.center,
                                  padding:EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.01.sh),
                                  margin:EdgeInsets.only(top: 0.01.sh),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'تواصل عبر واتسآب',
                                        style: H3WhiteTextStyle,
                                      ),
                                      SizedBox(width: 0.02.sw,),
                                      Icon(FontAwesomeIcons.whatsapp,color: WhiteColor,)
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.r),
                                      color: Colors.green
                                  ),
                                ),
                              ));
                        }
                        return TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async => await openUrl(url: '$el'),
                          text: ' $el ',
                          style: H2RedTextStyle,
                        );
                      } else {
                        return TextSpan(text: ' $el ', style: H4RegularDark);
                      }
                    })
                  ]),
                ),
              ),
              if (message.type == 'aac')
                PlayerSoundMessage(
                  path: message.attach,
                ),
              if (message.type != 'aac' && message.type != 'text')
                InkWell(
                  child: Container(
                    width: 0.75.sw,
                    height: 0.75.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        image: DecorationImage(
                            image:
                                CachedNetworkImageProvider("${message.attach}"),
                            fit: BoxFit.cover)),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
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
                                  child: const Icon(Icons.close,
                                      color: RedColor, size: 30),
                                ),
                                onPressed: () => Get.back(),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                color: Colors.black.withOpacity(0.7),
                                child: Text(
                                  '${message.body}', // وصف الصورة
                                  style: H4BlackTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              Container(
                transformAlignment: Alignment.bottomLeft,
                alignment: Alignment.bottomLeft,
                child: Text(
                  "${message.createdAt}",
                  style: H5GrayTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget anotherMessage(context, {required MessageModel message}) {
    return SizedBox(
      width: 0.75.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${message.user?.seller_name ?? message.user?.name}",
                style: H5OrangeTextStyle.copyWith(color: Colors.brown),
              ),
              Container(
                child: Container(
                  width: 0.09.sw,
                  height: 0.09.sw,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "${message.user?.image}"),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          Container(
            width: 0.7.sw,
            constraints: BoxConstraints(minWidth: 0.00001.sw),
            padding:
                EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.02.sw),
            margin: EdgeInsets.only(top: 0.005.sh),
            decoration: BoxDecoration(
                color: GrayLightColor,
                borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints:
                      BoxConstraints(minWidth: 0.001.sw, maxWidth: 0.7.sw),
                  child: RichText(
                    softWrap: true,
                    text: TextSpan(children: [
                      ..."${message.body}".split(' ').map((el) {
                        if (isURL("$el")) {
                          if(el.startsWith('https://wa.me')){
                            return WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    openUrl(url: '$el');
                                  },
                                  child: Container(
                                    alignment:Alignment.center,
                                    padding:EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.01.sh),
                                    margin:EdgeInsets.only(top: 0.01.sh),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'تواصل عبر واتسآب',
                                          style: H3WhiteTextStyle,
                                        ),
                                        SizedBox(width: 0.02.sw,),
                                        Icon(FontAwesomeIcons.whatsapp,color: WhiteColor,)
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.r),
                                        color: Colors.green
                                    ),
                                  ),
                                ));
                          }
                          return TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async => await openUrl(url: '$el'),
                            text: ' $el ',
                            style: H2RedTextStyle,
                          );
                        } else {
                          return TextSpan(text: ' $el ', style: H4RegularDark);
                        }
                      })
                    ]),
                  ),
                ),
                if (message.type == 'aac')
                  PlayerSoundMessage(
                    path: message.attach,
                  ),
                if (message.type != 'aac' && message.type != 'text')
                  InkWell(
                    child: Container(
                      width: 0.75.sw,
                      height: 0.75.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "${message.attach}"),
                              fit: BoxFit.cover)),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
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
                                    child: const Icon(Icons.close,
                                        color: RedColor, size: 30),
                                  ),
                                  onPressed: () => Get.back(),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  color: Colors.black.withOpacity(0.7),
                                  child: Text(
                                    '${message.body}', // وصف الصورة
                                    style: H4BlackTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                Container(
                  transformAlignment: Alignment.bottomLeft,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${message.createdAt}",
                    style: H5GrayTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
