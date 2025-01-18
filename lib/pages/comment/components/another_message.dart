import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
  RxBool replay = RxBool(false);

  AnotherMessage({super.key, required this.message, required this.logic});

  RxList<CommentModel> comments = RxList<CommentModel>([]);
  TextEditingController messageController = TextEditingController();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    comments.addAll(message.comments!.toList());
    return Container(
      width: 0.8.sw,
      margin: EdgeInsets.symmetric(vertical: 0.009.sh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(message.user?.is_verified==true)
              Container(
                width: 0.04.sw,
                height: 0.04.sw,
                decoration: BoxDecoration(image: DecorationImage(image: Svg('assets/images/svg/verified.svg'))),
              ),
              Text(
                "${message.user?.seller_name!.length != 0 ? message.user?.seller_name : message.user?.name}",
                style: H5OrangeTextStyle.copyWith(color: Colors.brown),
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
            width: 0.7.sw,
            constraints: BoxConstraints(minWidth: 0.00001.sw),
            padding:
                EdgeInsets.symmetric(vertical: 0.007.sh, horizontal: 0.02.sw),
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
                      ..."${message.comment}".split(' ').map((el) {
                        if (mainController.isURL("$el")) {
                          return TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async => await openUrl(url: '$el'),
                            text: ' $el ',
                            style: H3RedTextStyle,
                          );
                        } else {
                          return TextSpan(text: ' $el ', style: H3RegularDark);
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
                          style: H4GrayTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  width: 0.6.sw,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (replay.value) {
                            replay.value = false;
                          } else {
                            replay.value = true;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 0.02.sh),
                          width: 0.6.sw,
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (message.user?.id ==
                                      mainController.authUser.value?.id ||
                                  logic.product.value?.user?.id ==
                                      mainController.authUser.value?.id)
                                GestureDetector(
                                  onTap: () {
                                    logic.deletComment(commentId: message.id!);
                                  },
                                  child: Container(
                                    width: 0.7.sw,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'حذف',
                                      style: H3RedTextStyle,
                                    ),
                                  ),
                                ),
                              Row(
                                children: [
                                  Text(
                                    'رد',
                                    style: H2RegularDark.copyWith(color: Colors.blue),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Visibility(
                    child: Container(
                      alignment: Alignment.center,
                      width: 0.7.sw,
                      margin: EdgeInsets.only(top: 0.001.sh, left: 0.01.sw),
                      decoration: BoxDecoration(
                        color: GrayWhiteColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Visibility(
                              child: InputComponent(
                                width: 0.68.sw,
                                height: 0.05.sh,
                                suffixIcon: FontAwesomeIcons.arrowLeft,
                                hint: 'رد',
                                fill: GrayWhiteColor,
                                controller: messageController,
                                suffixClick: () async {
                                  await createComment();
                                  return "";
                                },
                              ),
                              visible: replay.value,
                            );
                          }),
                        ],
                      ),
                    ),
                    visible: replay.value,
                  );
                }),

                  Obx(() {
                    if (comments.length > 0){
                      return Transform.translate(
                        offset: Offset(0.06.sw,0),
                        child: Container(
                          width: 0.7.sw,
                          margin: EdgeInsets.only(right: 0.03.sw),
                          decoration: BoxDecoration(color: GrayLightColor),
                          child: Column(
                            children: [

                              ...List.generate(comments.length, (index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: GrayDarkColor))
                                  ),
                                  width: 0.7.sw,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          if(comments[index].user?.is_verified==true)
                                            Container(
                                              width: 0.04.sw,
                                              height: 0.04.sw,
                                              decoration: BoxDecoration(image: DecorationImage(image: Svg('assets/images/svg/verified.svg'))),
                                            ),
                                          Text(
                                            "${comments[index].user?.seller_name!=null?comments[index].user?.seller_name:comments[index].user?.name}",
                                            style: H4RegularDark,
                                          ),

                                          Container(
                                            child: Container(
                                              width: 0.05.sw,
                                              height: 0.05.sw,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          "${message.user?.image}"),
                                                      fit: BoxFit.cover),
                                                  shape: BoxShape.circle),
                                            ),
                                          ),
                                        ],),
                                      Text("${comments[index].comment}",style: H2RegularDark,),
                                    ],
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      );
                    }
                    return Row();

                  })
              ],
            ),
          )
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
        created_at
        comments{
        user {
        name
        seller_name
         image
        }
        comment
         created_at
        
        
        }
        user {
        id
            name
            seller_name
            image
            is_verified
        }
    }
}
''';
    try {
      dio.Response? res = await mainController.fetchData();
      Logger().e(res?.data);
      if (res?.data?['data']?['createComment'] != null) {
        messageController.clear();
        replay.value = false;
       var comment= CommentModel.fromJson(res?.data?['data']?['createComment']);
       comments.add(comment);
      }
    } catch (e) {}
  }
}
