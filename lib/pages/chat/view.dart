import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
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
    UserModel? frind =
        mainController.authUser.value?.id == logic.communityModel.user?.id
            ? logic.communityModel.seller
            : logic.communityModel.user;
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
          children: [
            Container(
              height: 0.085.sh,
              padding: EdgeInsets.only(top: 0.022.sh),
              alignment: Alignment.center,
              color: RedColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 0.1.sw,
                    height: 0.1.sw,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('${frind?.image}'))),
                  ),
                  15.horizontalSpace,
                  Container(
                    alignment: Alignment.centerRight,
                    width: 0.8.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${frind?.name}',
                          style: H3WhiteTextStyle,
                        ),
                        Text(
                          '${frind?.seller_name}',
                          style: H4GrayTextStyle,
                        )
                      ],
                    ),
                  ),
                  10.verticalSpace,
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
                    return _buildMessage(context,
                        isIam: isIam, message: logic.messages[index]);
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r),borderSide: BorderSide(color: GrayLightColor)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                logic.pickImage(
                                    imagSource: ImageSource.gallery);
                              },
                              icon: Icon(FontAwesomeIcons.paperclip),),
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

  Widget _buildMessage(context,
      {required bool isIam, required MessageCommunityModel message}) {
    return Container(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            isIam ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: 0.05.sw,
            height: 0.05.sw,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage('${message.user?.image}'))),
          ),
          Container(
              width: 0.75.sw,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(
                color: isIam ? OrangeColor : GrayLightColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: (message.message!.length > 0)
                  ? RichText(
                      softWrap: true,
                      text: TextSpan(children: [
                        ..."${message.message}".split(' ').map((el) {
                          if (isURL("$el")) {
                            return TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async => await openUrl(url: '$el'),
                              text: ' $el ',
                              style: !isIam
                                  ? H3OrangeTextStyle.copyWith(height: 1.5)
                                  : H3WhiteTextStyle.copyWith(height: 1.5),
                            );
                          } else {
                            return TextSpan(
                                text: ' $el ',
                                style: H3BlackTextStyle.copyWith(height: 1.5));
                          }
                        })
                      ]),
                    )
                  : InkWell(
                      child: Container(
                          constraints: BoxConstraints(maxHeight: 0.2.sh),
                          child: CachedNetworkImage(
                            imageUrl: '${message.attach}',
                            imageBuilder: (context, imageProvider) => Container(
                              child: Image(
                                image: imageProvider,
                              ),
                            ),
                            useOldImageOnUrlChange: true,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
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
                                      child: Icon(Icons.close,
                                          color: RedColor, size: 30),
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
          Container(
            width: 0.7.sw,
            alignment: isIam ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              '${message.createdAt}',
              style: H4GrayTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
