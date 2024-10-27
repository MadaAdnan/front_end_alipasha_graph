import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/comment_model.dart';
import 'package:ali_pasha_graph/pages/product/logic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommentPage extends StatelessWidget {
  CommentPage({super.key});

  ProductLogic logic = Get.find<ProductLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(); /*Stack(
      children: [
        if (isAuth())
        Positioned(child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
          alignment: Alignment.center,
          constraints: BoxConstraints(maxHeight: 0.8.sh),
          width: 1.sw,
          height: 0.07.sh,
          decoration: const BoxDecoration(

          ),
          child:Container(
            width: 0.9.sw,
            child:  Row(
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
        ),bottom: 0.01.sh,),
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent * 0.80 &&
                !mainController.loading.value &&
                logic.hasMorePage.value) {
              logic.nextPage();
            }

            if (scrollInfo is ScrollUpdateNotification) {
              if (scrollInfo.metrics.pixels > scrollInfo.metrics.minScrollExtent) {
                mainController.is_show_home_appbar(false);
              } else {
                mainController.is_show_home_appbar(true);
              }
            }
            return true;
          },
          child: Column(
            children: [
              Flexible(
                flex: 9,
                child: Container(

                  width: 1.sw,
                  color: WhiteColor,
                  child: SingleChildScrollView(
                    controller: logic.scrollController,
                    child: Obx(() {
                      return Column(
                        children: [
                          ...List.generate(
                            logic.comments.length,
                                (index) {
                              if(logic.comments[index].user?.id ==mainController.authUser.value?.id){
                                return myMessage(context, message: logic.comments[index]);
                              }
                              return anotherMessage(context, message: logic.comments[index]);
                            },
                          ),
                          SizedBox(height: 0.01.sh,),
                          if (logic.loadingGetComment.value)
                            Container(
                              child: Center(
                                child: ProgressLoading(width: 0.03.sw,),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ),
              ),

            ],
          ),
        )
      ],
    );*/

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
                child:  RichText(
                  softWrap: true,
                  text: TextSpan(children: [
                    ..."${message.comment}".split(' ').map((el) {
                      if (mainController.isURL("$el")) {
                        return TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async => await openUrl(url: '$el'),
                          text: ' $el ',
                          style:  H4RedTextStyle,
                        );
                      } else {
                        return TextSpan(
                            text: ' $el ',
                            style:  H4RegularDark);
                      }
                    })
                  ]),
                ),
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
                      ..."${message.comment}".split(' ').map((el) {
                        if (mainController.isURL("$el")) {
                          return TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async => await openUrl(url: '$el'),
                            text: ' $el ',
                            style:  H4RedTextStyle,
                          );
                        } else {
                          return TextSpan(
                              text: ' $el ',
                              style:  H4RegularDark);
                        }
                      })
                    ]),
                  ),
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
