import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/comment_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/components.dart';
import '../../../helpers/style.dart';
import 'another_message.dart';

class MyMessage extends StatelessWidget {
   MyMessage({super.key,required  this.message,required this.logic,this.isReplay=true});
  MainController mainController = Get.find<MainController>();
  final logic ;
  final isReplay ;
final CommentModel message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
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
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${message.user?.seller_name!.length != 0 ? message.user?.seller_name : message.user?.name}",
                        style: H4OrangeTextStyle,
                      ),
                    ),
                    SizedBox(width: 0.01.sw,),
                    if (message.user?.is_verified == true)
                      Container(
                        width: 0.04.sw,
                        height: 0.04.sw,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Svg('assets/images/svg/verified.svg'))),
                      )
                  ],
                )),
          ],
        ),
        Container(
          width: 0.85.sw,
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
                    ..."${message.comment}".split(' ').map((el) {
                      if (mainController.isURL("$el")) {
                        return TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async => await openUrl(url: '$el'),
                          text: ' $el ',
                          style: H4RedTextStyle,
                        );
                      } else {
                        return TextSpan(text: ' $el ', style: H4RegularDark);
                      }
                    })
                  ]),
                ),
              ),
              Container(
                transformAlignment: Alignment.bottomLeft,
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${message.createdAt}",
                      style: H4GrayTextStyle,
                    ),
                    InkWell(
                      onTap: () {
                        Get.dialog(AlertDialog(
                          backgroundColor: Colors.white,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('تحذير أنت على وشك حذف التعليق',
                                style: H3RedTextStyle,),
                              Text('هل أنت متأكد من الحذف؟',
                                style: H3RegularDark,),
                              SizedBox(height: 0.01.sh,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  MaterialButton(
                                    color: PrimaryColor,
                                    onPressed: () async {


                                      await logic.deletComment(
                                          commentId: message.id!);
                                      Get.back();
                                    },
                                    child: Text('نعم',
                                      style: H4WhiteTextStyle,),
                                  ),
                                  MaterialButton(
                                    color: Colors.grey,
                                    onPressed: () async {
                                      Get.back();
                                    },
                                    child: Text('لا',
                                      style: H4WhiteTextStyle,),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                      },
                      child: Text('حذف',style: H4RedTextStyle,),
                    ),
                    if(message.comments?.length !=0)
                      ...[
                        Text('الردود:',style: H5OrangeTextStyle,),

                        Divider(),
                        for (CommentModel comment in message.comments!)
                          if (comment.user?.id == mainController.authUser.value?.id)
                            MyMessage(message: comment, logic: logic,isReplay: false,)
                          else
                            AnotherMessage(
                              message: comment,
                              logic: logic,
                              isReplay: false,
                            ),
                      ],
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
