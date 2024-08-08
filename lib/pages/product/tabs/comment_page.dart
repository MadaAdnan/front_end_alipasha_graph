import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/pages/product/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommentPage extends StatelessWidget {
  CommentPage({super.key});

  ProductLogic logic = Get.find<ProductLogic>();
  MainController mainController = Get.find<MainController>();


  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
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
            fit: FlexFit.tight,
            child: Container(
              width: 1.sw,
              color: WhiteColor,
              child: SingleChildScrollView(
                child: Obx(() {
                  return Column(
                    children: [
                      ...List.generate(
                        logic.comments.length,
                        (index) => Container(
                          margin: EdgeInsets.only(bottom: 0.003.sh),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 0.05.sw,
                                    height: 0.05.sw,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(image: NetworkImage("${logic.comments[index].user?.image}"))),
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "${logic.comments[index].user?.name}",
                                    style: H4OrangeTextStyle,
                                  ),
                                ],
                              ),
                              Container(
                                width: 0.9.sw,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.02.sw, vertical: 0.01.sh),
                                decoration: BoxDecoration(
                                  color: GrayLightColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Text(
                                  "${logic.comments[index].comment}",
                                  style: H4BlackTextStyle,
                                ),
                              ),
                              Align(
                                child: Text(
                                  "${logic.comments[index].createdAt}",
                                  style: H5GrayOpacityTextStyle,
                                ),
                                alignment: Alignment.bottomLeft,
                              )
                            ],
                          ),
                        ),
                      ),
                      if (logic.loadingGetComment.value)
                        Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),
          if(isAuth())
          Container(
            height: 0.08.sh,
            width: 1.sw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 0.8.sw,
                  child: Obx(() {
                    return InputComponent(
                      fill: GrayWhiteColor,
                      hint: 'اكتب تعليقاً',
                      width: 1.sw,
                      height: 0.07.sh,
                      controller: logic.comment.value,
                    );
                  }),
                ),
                Obx(() {
                  if (logic.loadingComment.value) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      if (logic.comment.value.text.isEmpty) {
                        return;
                      }
                      logic.createComment();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: 0.02.sw, horizontal: 0.02.sw),
                      width: 0.128.sw,
                      height: 0.128.sw,
                      decoration: BoxDecoration(
                          border: Border.all(color: GrayLightColor),
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Icon(
                        FontAwesomeIcons.solidPaperPlane,
                        color: RedColor,
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
