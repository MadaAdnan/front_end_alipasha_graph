import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';
import 'package:ali_pasha_graph/pages/comment/components/my_message.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/components.dart';
import '../../../helpers/style.dart';
import '../../../models/comment_model.dart';
import '../logic.dart';
import "package:dio/dio.dart" as dio;

class AnotherMessage extends StatelessWidget {
  final CommentModel message;
  final CommentLogic logic;
  final isReplay;
  RxBool replay = RxBool(false);

  AnotherMessage({super.key, required this.message, required this.logic,this.isReplay=true});

  RxList<CommentModel> comments = RxList<CommentModel>([]);
  TextEditingController messageController = TextEditingController();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    comments.addAll(message.comments!.toList());
    return Container(
      width: 0.9.sw,
      margin: EdgeInsets.symmetric(vertical: 0.009.sh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (message.user?.is_verified == true)
                Container(
                  width: 0.04.sw,
                  height: 0.04.sw,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Svg('assets/images/svg/verified.svg'))),
                ),
              AutoSizeText(
                "${message.user?.seller_name!.length != 0 ? message.user?.seller_name : message.user?.name}",
                style: H4OrangeTextStyle.copyWith(color: Colors.brown),
              ),

              /**/
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
            width: 0.9.sw,

            padding:
                EdgeInsets.symmetric(vertical: 0.007.sh, horizontal: 0.02.sw),
            margin: EdgeInsets.only(top: 0.005.sh),
            decoration: BoxDecoration(
                color: GrayLightColor,
                borderRadius: BorderRadius.circular(15.r)),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                              text: ' $el',
                              style: H4RedTextStyle,
                            );
                          } else {
                            return TextSpan(text: ' $el', style: H4RegularDark);
                          }
                        })
                      ]),
                    ),
                  ),
                  Container(
                    transformAlignment: Alignment.bottomLeft,
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      transformAlignment: Alignment.bottomLeft,
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${message.createdAt}",
                            style: H5GrayTextStyle,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (message.user?.id ==
                                      mainController.authUser.value?.id ||
                                  logic.product.value?.user?.id ==
                                      mainController.authUser.value?.id)
                                InkWell(
                                  child: Text(
                                    'حذف',
                                    style: H4RedTextStyle,
                                  ),
                                  onTap: () {
                                    Get.dialog(AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'تحذير أنت على وشك حذف التعليق',
                                            style: H3RedTextStyle,
                                          ),
                                          Text(
                                            'هل أنت متأكد من الحذف؟',
                                            style: H3RegularDark,
                                          ),
                                          SizedBox(
                                            height: 0.01.sh,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MaterialButton(
                                                color: PrimaryColor,
                                                onPressed: () async {
                                                  await logic.deletComment(
                                                      commentId: message.id!);
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'نعم',
                                                  style: H4WhiteTextStyle,
                                                ),
                                              ),
                                              MaterialButton(
                                                color: Colors.grey,
                                                onPressed: () async {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'لا',
                                                  style: H4WhiteTextStyle,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                                  },
                                ),
                              SizedBox(
                                width: 0.07.sw,
                              ),
                              if(isReplay)
                              InkWell(
                                onTap: () {
                                  Get.dialog(AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      'أكتب ردك',
                                      style: H3RedTextStyle,
                                    ),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                              controller: messageController,
                                              decoration: InputDecoration(
                                                hintText: 'أكتب ردك',
                                                hintStyle: H3RegularDark,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 0.01.sh,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                MaterialButton(
                                                  color: PrimaryColor,
                                                  onPressed: () async {
                                                    await createComment();
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    'أرسال',
                                                    style: H4WhiteTextStyle,
                                                  ),
                                                ),
                                                MaterialButton(
                                                  color: Colors.grey,
                                                  onPressed: () async {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    'إلغاء',
                                                    style: H4WhiteTextStyle,
                                                  ),
                                                ),
                                              ])
                                        ]),
                                  ));
                                },
                                child: Text(
                                  'رد',
                                  style: H4RegularDark,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  if (message.comments?.length != 0)
                   ...[
                     Text('الردود:',style: H4RedTextStyle,),

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
              );
            }),
          ),
        ],
      ),
    );
  }

  Future<void> createComment() async {
    mainController.query.value = '''
      mutation CreateComment {
    createComment(product_id: ${logic.productId.value}, comment: "${messageController.text}" , comment_id:"${message.id}") {
        id
        comment
        comment_id
        created_at
        comments{
        user {
        name
        full_phone
        seller_name
         image
        }
        comment
         created_at
        
        
        }
        user {
        id
            name
            full_phone
            seller_name
            image
            is_verified
        }
    }
}
''';
    try {
      dio.Response? res = await mainController.fetchData();
      Logger().e("RESPONSE");
      Logger().e(res?.data);
      if (res?.data?['data']?['createComment'] != null) {
        messageController.clear();
        replay.value = false;
        var comment =
            CommentModel.fromJson(res?.data?['data']?['createComment']);





            message.comments?.insert(0,comment);



      }
    } catch (e) {}
  }
}
