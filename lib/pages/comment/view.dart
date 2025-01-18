import 'package:ali_pasha_graph/pages/comment/components/another_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../components/progress_loading.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../models/comment_model.dart';
import 'logic.dart';

class CommentPage extends StatelessWidget {
  CommentPage({Key? key}) : super(key: key);

  final logic = Get.find<CommentLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        title: Text(
          'التعليقات',
          style: H4RegularDark,
        ),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !mainController.loading.value &&
              logic.hasMorePage.value) {
            logic.nextPage();
          }
          return true;
        },
        child: Column(
          children: [
            Expanded(

              child: Container(
                width: 1.sw,
                color: WhiteColor,
                child: SingleChildScrollView(
                  controller: logic.scrollController,
                  child: Obx(() {
                    if (logic.loading.value) {
                      return Container(
                        width: 1.sw,
                        height: 1.sh,
                        alignment: Alignment.center,
                        child: ProgressLoading(
                          width: 0.2.sw,
                          height: 0.2.sw,
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ...List.generate(
                          logic.comments.length,
                              (index) {
                            if (logic.comments[index].user?.id ==
                                mainController.authUser.value?.id) {
                              return myMessage(context,
                                  message: logic.comments[index]);
                            }
                            return AnotherMessage(
                              message: logic.comments[index],logic: logic,);
                          },
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        if (logic.loading.value)
                          Container(
                            child: Center(
                              child: ProgressLoading(
                                width: 0.03.sw,
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            if (isAuth())
              Container(

                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                alignment: Alignment.center,
                constraints: BoxConstraints(maxHeight: 0.8.sh),
                width: 1.sw,
                height: 0.07.sh,
                child: Container(
                  width: 0.9.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                            child: FormBuilderTextField(
                              name: 'msg',
                              controller: logic.comment,
                              style: H2RegularDark.copyWith(color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: WhiteColor,
                                filled: true,
                                hintStyle: H5GrayTextStyle.copyWith(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.02.sw),
                                suffixIcon: Obx(() {
                                  if (logic.loadingComment.value) {
                                    return Container(
                                      width: 0.04.sw,
                                      height: 0.04.sw,
                                      child: Container(
                                          padding: const EdgeInsets.all(7),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(7),
                                              child: CircularProgressIndicator(),
                                            ),
                                          )),
                                    );
                                  }
                                  return Container(
                                    decoration: const BoxDecoration(
                                        color: RedColor, shape: BoxShape.circle),
                                    child: Transform.flip(
                                      flipX: true,
                                      child: IconButton(
                                          onPressed: () {
                                            logic.createComment();
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.paperPlane,
                                            color: WhiteColor,
                                          )),
                                    ),
                                  );
                                }),
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
                    ],
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }

  Widget myMessage(context, {required CommentModel message}) {
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
              "${message.user?.seller_name!.length!=0 ?message.user?.seller_name: message.user?.name}",
              style: H3OrangeTextStyle,
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
                child: Row(
                  children: [
                    Text(
                      "${message.createdAt}",
                      style: H4GrayTextStyle,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
        if (message.user?.id == mainController.authUser.value?.id || logic.product.value?.user?.id == mainController.authUser.value?.id)
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
          )
      ],
    );
  }

  Widget anotherMessage(context, {required CommentModel message}) {
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
                "${message.user?.seller_name!.length != 0 ? message.user?.seller_name: message.user?.name}",
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
                  child:Container(
                    transformAlignment: Alignment.bottomLeft,
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${message.createdAt}",
                          style: H4GrayTextStyle,
                        ),
                        GestureDetector(
                          child: Text('رد',style: H3RegularDark,),
                        )
                      ],
                    ),
                  ),
                ),
                if (message.user?.id == mainController.authUser.value?.id || logic.product.value?.user?.id == mainController.authUser.value?.id)
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
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
