import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

class ChannelPage extends StatelessWidget {
  ChannelPage({Key? key}) : super(key: key);

  final logic = Get.find<ChannelLogic>();
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

                          Positioned(
                            right: 0.08.sw,
                            child: Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${logic.communityModel.manager?.logo}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),


                        Positioned(
                            right: 0.2.sw,
                            child: Text(
                              '${logic.communityModel.name}',
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
                    return myMessage(context,  message: logic.messages[index]);

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

  Widget myMessage(context,{ required MessageModel message}) {
    return Container(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center ,
        children: [
          Container(
            width: 0.8.sw,
            alignment:  Alignment.centerRight ,
            child: Text(
              '${message.createdAt}',
              style: H4GrayTextStyle,
            ),
          ),
          SizedBox(height: 0.02.sw,),
          if (message.type == 'text')
            Container(
              width: 0.9.sw,
              padding:
              EdgeInsets.symmetric(vertical: 0.009.sh, horizontal: 0.02.sw),
              decoration: BoxDecoration(
                color: RedColor ,
                borderRadius: BorderRadius.circular(30.r),
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
                        style:  H3WhiteTextStyle.copyWith(height: 1.5),
                      );
                    } else {
                      return TextSpan(
                          text: ' $el ',
                          style:  H3WhiteTextStyle.copyWith(height: 1.5));
                    }
                  })
                ]),
              ),
            ),
          if (message.type == 'wav')
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.004.sw,horizontal:0.004.sw ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(150.r),color: RedColor.withOpacity(0.5)),
              child:  PlayerSoundMessage(
                path: message.attach,
              ),
            ),
          if (message.type != 'text' && message.type != 'wav')
            InkWell(
              child: Container(
                width: 0.9.sw,
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
                  builder: (context) => Dialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                            imageUrl: '${message.attach}',
                            imageBuilder: (context, imageProvider) => Container(
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
                                        color: DarkColor, blurRadius: 0.02.sw)
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
          SizedBox(height: 0.008.sh,),
        ],
      ),
    );
  }
}
