import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/plan_card/view.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

import 'logic.dart';

class CommunitiesPage extends StatelessWidget {
  CommunitiesPage({Key? key}) : super(key: key);

  final logic = Get.find<CommunitiesLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
          child: PopupMenuButton(
            offset: Offset(0, -0.13.sh),
            iconColor: WhiteColor,
            color: WhiteColor,
            onSelected: (value) {
              switch (value) {
                case '0':
                  break;
                case 'channel':
                  Get.toNamed(CREATE_COMMUNITY_PAGE, arguments: 'channel');
                  break;
                case 'group':
                  Get.toNamed(CREATE_COMMUNITY_PAGE, arguments: 'group');
                  break;
                case 'join':
                  _joinCommunity();
                  break;
              }
            },
            itemBuilder: (context) =>
            [
              PopupMenuItem(
                value: 'join',
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.rightToBracket,
                      color: GrayDarkColor,
                      size: 0.05.sw,
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Text(
                      'دخول مجتمع جديد',
                      style: H4GrayTextStyle,
                    )
                  ],
                ),
              ),
              if (mainController.authUser.value?.can_create_group != true &&
                  mainController.authUser.value?.can_create_channel != true)
                PopupMenuItem(
                  value: '0',
                  child: Text(
                    'لا تملك صلاحية لإنشاء قناة أو مجموعة',
                    style: H4GrayTextStyle,
                  ),
                ),
              if (mainController.authUser.value?.can_create_channel == true)
                PopupMenuItem(
                  value: 'channel',
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.bullhorn,
                        color: GrayDarkColor,
                        size: 0.05.sw,
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Text(
                        'إنشاء قناة ',
                        style: H4GrayTextStyle,
                      )
                    ],
                  ),
                ),
              if (mainController.authUser.value?.can_create_group == true)
                PopupMenuItem(
                  value: 'group',
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.users,
                        color: GrayDarkColor,
                        size: 0.05.sw,
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Text(
                        'إنشاء مجموعة',
                        style: H4GrayTextStyle,
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
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
                        switch (logic.communities[index].type) {
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
                        height: 0.097.sh,
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
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 0.1.sw,
                                      height: 0.1.sw,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  "${logic.communities[index]
                                                      .type == 'chat' ? friend
                                                      ?.image : logic
                                                      .communities[index].image}"),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle),

                                    ),
                                    Positioned(
                                      bottom:0,
                                      left: 0,
                                      child: Transform.translate(
                                        offset: Offset(0, 0.01.sh),
                                        child:  (friend?.is_verified == true &&
                                            logic.communities[index].type == 'chat')?
                                        Container(
                                          width: 0.05.sw, // أو 0.04.sw إذا أردت نسبي
                                          height: 0.05.sw,
                                          margin: EdgeInsets.only(left: 2), // فقط إذا أردت مسافة صغيرة
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: Svg("assets/images/svg/verified.svg"),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ):null,
                                      ),
                                    ),
                                  ],
                                ),
                                10.horizontalSpace,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(builder: (context) {

                                      String? name = '';
                                      IconData icon = FontAwesomeIcons.comments;

                                      if (logic.communities[index].type ==
                                          'group') {
                                        icon = FontAwesomeIcons.users;
                                        name = logic.communities[index].name;
                                      } else if (logic
                                          .communities[index].type ==
                                          'channel') {
                                        icon = FontAwesomeIcons.hornbill;
                                        name = logic.communities[index].name;
                                      } else {
                                        name = friend?.seller_name!.length != 0
                                            ? friend?.seller_name
                                            : friend?.name;
                                      }
                                      return SizedBox(
                                        width: 0.6.sw,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "$name ",
                                                style: H3BlackTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),


                                            Text(
                                              " ${logic.communities[index].type!.communityType()}",
                                              style: H3OrangeTextStyle,
                                            ),
                                          ],
                                        ),
                                      )
                                      ;
                                    }),
                                    Text(
                                      'عدد المشتركين (${logic.communities[index]
                                          .users_count})',
                                      style: H4RegularDark,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // LastChange
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Builder(
                                  builder: (context) {
                                    IconData icon = FontAwesomeIcons.comments;
                                    bool is_verified =
                                        friend?.is_verified ?? false;
                                    if (logic.communities[index].type ==
                                        'group') {
                                      icon = FontAwesomeIcons.users;
                                    } else if (logic.communities[index].type ==
                                        'channel') {
                                      icon = FontAwesomeIcons.bullhorn;
                                    }
                                    return Icon(
                                      icon,
                                      color: OrangeColor,
                                    );
                                  },
                                ),
                                Text(
                                  '  ${logic.communities[index].lastChange}',
                                  style: H5RegularDark,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  if (logic.loading.value && logic.communities.length == 0)
                    ...List.generate(
                      4,
                          (index) =>
                          Shimmer.fromColors(
                              baseColor: GrayLightColor,
                              highlightColor: GrayWhiteColor,
                              child: Container(
                                margin: EdgeInsets.only(top: 0.01.sh),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.01.sw),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    // image
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                          width: 0.13.sw,
                                          height: 0.13.sw,
                                          decoration:
                                          BoxDecoration(shape: BoxShape.circle),
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
                                            padding: EdgeInsets.only(
                                                left: 0.01.sw),
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
                              )),
                    )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }

  _joinCommunity() {
    Get.dialog(AlertDialog(
      backgroundColor: WhiteColor,
      content: Obx(() {
        if (mainController.loading.value) {
          return ProgressLoading();
        }

        return Container(
          width: 0.8.sw,
          height: 0.3.sh,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 0.05.sh,
              ),
              Text(
                'أدخل كود القناة / المجموعة للدخول',
                style: H2BlackTextStyle,
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              TextField(
                controller: logic.codeCommunityController,
                decoration: InputDecoration(
                    label: Text(
                      'كود القناة / المجموعة',
                      style: H3RegularDark,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: GrayLightColor))),
              )
            ],
          ),
        );
      }),
      actions: [
        Obx(() {
          if (!mainController.loading.value) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await logic.accessCommunity();
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.01.sh, horizontal: 0.02.sw),
                    width: 0.3.sw,
                    child: Text(
                      'دخول',
                      style: H3WhiteTextStyle,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150.r),
                        color: Colors.green),
                  ),
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.01.sh, horizontal: 0.02.sw),
                    width: 0.3.sw,
                    child: Text(
                      'إلغاء',
                      style: H3WhiteTextStyle,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150.r),
                        color: RedColor),
                  ),
                )
              ],
            );
          }
          return Container();
        })
      ],
    ));
  }
}
