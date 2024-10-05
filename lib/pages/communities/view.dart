import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'logic.dart';

class CommunitiesPage extends StatelessWidget {
  CommunitiesPage({Key? key}) : super(key: key);

  final logic = Get.find<CommunitiesLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
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
            HomeAppBarComponent(
              search: () {
                Get.defaultDialog(
                    title: 'ابحث عن محادثة',
                    titleStyle: H3BlackTextStyle,
                    backgroundColor: WhiteColor,
                    textConfirm: 'بحث',
                    textCancel: 'إلغاء',
                    content: Container(
                      child: InputComponent(
                        width: 0.8.sw,
                        hint: "ابحث",
                        controller: logic.searchController,
                      ),
                    ),
                    onConfirm: () {
                      logic.search.value = logic.searchController.text;

                      FocusScope.of(context).unfocus();
                      Get.back();
                    },
                    onCancel: () {
                      FocusScope.of(context).unfocus();
                    });
              },
            ),
            Expanded(child: Obx(() {
              return ListView(
                padding: EdgeInsets.symmetric(
                    vertical: 0.01.sh, horizontal: 0.01.sw),
                children: [
                  ...List.generate(logic.communities.length, (index) {
                    UserModel? friend = logic.communities[index].users!
                        .where(
                            (el) => el.id != mainController.authUser.value?.id)
                        .firstOrNull;
                    return InkWell(
                      onTap: () {
                        switch(logic.communities[index].type){
                          case "chat":
                            Get.toNamed(CHAT_PAGE,
                                arguments: logic.communities[index]);
                            break;
                          case "group":
                            Get.toNamed(GROUP_PAGE,
                                arguments: logic.communities[index]);
                            break;
                          case "channel":
                            Get.toNamed(CHANNEL_PAGE,
                                arguments: logic.communities[index]);
                            break;
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 0.01.sh),
                        padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                        height: 0.08.sh,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: WhiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0.006,
                              blurRadius: 0.5,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // image
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 0.13.sw,
                                  height: 0.13.sw,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              "${friend?.image}"),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle),
                                ),

                                // title
                                Container(
                                  width: 0.62.sw,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            style: H3BlackTextStyle.copyWith(overflow: TextOverflow.ellipsis),
                                        children: [
                                          TextSpan(text:  '${logic.communities[index].type != 'chat' ? logic.communities[index].name : '${mainController.authUser.value?.name} & ${friend?.name}'}',style:H3BlackTextStyle.copyWith(overflow: TextOverflow.ellipsis,), ),
                                          if(logic.communities[index].type == 'chat')TextSpan(text: ' (محادثة) ',style: H5RedTextStyle),
                                          if(logic.communities[index].type == 'group')TextSpan(text: ' (مجموعة) ',style: H5RedTextStyle),
                                          if(logic.communities[index].type == 'channel')TextSpan(text: ' (قناة) ',style: H5RedTextStyle),
                                        ]
                                      )),

                                      20.verticalSpace,
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: 'عدد المشتركين :',
                                            style: H5RegularDark),
                                        TextSpan(
                                            text:
                                                '${logic.communities[index].users_count}',
                                            style: H4OrangeTextStyle),
                                      ])),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              width: 0.2.sw,
                              child: Row(
                                children: [
                                  Container(
                                    width: 0.06.sw,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (logic.communities[index].type ==
                                            'chat')
                                          Icon(
                                            FontAwesomeIcons.comments,
                                            size: 0.04.sw,
                                            color: RedColor,
                                          ),
                                        if (logic.communities[index].type ==
                                            'group')
                                          Icon(
                                            FontAwesomeIcons.users,
                                            size: 0.04.sw,
                                            color: OrangeColor,
                                          ),
                                        if (logic.communities[index].type ==
                                            'channel')
                                          Icon(
                                            FontAwesomeIcons.volumeHigh,
                                            size: 0.04.sw,
                                            color: Colors.blue,
                                          ),
                                        45.verticalSpace,
                                      ],
                                    ),
                                  ),
// notify
                                  Container(
                                    width: 0.14.sw,
                                    padding: EdgeInsets.only(left: 0.01.sw),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Badge.count(count: 10),
                                        20.verticalSpace,
                                        Text(
                                          '${logic.communities[index].lastChange}',
                                          style: H5GrayOpacityTextStyle,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                            //icon
                          ],
                        ),
                      ),
                    );
                  }),
                  if (logic.loading.value)
                    ...List.generate(
                        4,
                        (index) => Shimmer.fromColors(child: Container(
              margin: EdgeInsets.only(top: 0.01.sh),
              padding:
              EdgeInsets.symmetric(horizontal: 0.01.sw),
              height: 0.08.sh,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: WhiteColor,
              boxShadow: [
              BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0.006,
              blurRadius: 0.5,
              offset: Offset(
              0, 1), // changes position of shadow
              ),
              ],
              ),
              child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
              // image
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
              Container(
              width: 0.13.sw,
              height: 0.13.sw,
              decoration: BoxDecoration(
              shape: BoxShape.circle),
              ),

              // title
              Container(
              width: 0.62.sw,
              child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
              Text(
              '',
              style: H3BlackTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ),
              20.verticalSpace,
              RichText(
              text: TextSpan(children: [
              TextSpan(
              text: 'عدد المشتركين :',
              style: H5RegularDark),
              TextSpan(
              text: ' ',
              style: H4OrangeTextStyle),
              ])),
              ],
              ),
              ),
              ],
              ),

              Container(
              width: 0.2.sw,
              child: Row(
              children: [
              Container(
              width: 0.06.sw,
              alignment: Alignment.center,
              child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
              Icon(
              FontAwesomeIcons.comments,
              size: 0.04.sw,
              color: RedColor,
              ),
              45.verticalSpace,
              ],
              ),
              ),
// notify
              Container(
              width: 0.14.sw,
              padding:
              EdgeInsets.only(left: 0.01.sw),
              child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
              Badge.count(count: 10),
              20.verticalSpace,
              Text(
              '',
              style: H5GrayOpacityTextStyle,
              )
              ],
              ),
              )
              ],
              ),
              )
              //icon
              ],
              ),
              ) , baseColor: GrayLightColor, highlightColor: GrayWhiteColor)
                           ,)
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
