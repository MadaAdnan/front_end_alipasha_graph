import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../helpers/style.dart';
import '../../routes/routes_url.dart';

class HomeAppBarComponent extends StatelessWidget
    implements PreferredSizeWidget {
  HomeAppBarComponent({
    Key? key,
    this.search,
    this.selected,
  }) : super(key: key);

  MainController mainController = Get.find<MainController>();
  Function()? search;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.001.sh),
      width: 1.sw,
      height: 0.11.sh,
      color: WhiteColor,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                width: 0.29.sw,
                child: Image(
                  image: const Svg(
                      'assets/images/svg/ali-pasha-horizantal-logo.svg',
                      color: PrimaryColor,
                      source: SvgSource.asset),
                  width: 0.27.sw,
                  height: 0.03.sh,
                  color: PrimaryColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              ),
              Expanded(child: Container()),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: PrimaryColor,
                ),
                onPressed: search ??
                    () => Get.toNamed(FILTER_PAGE,
                        arguments: selected ?? 'product'),
              ),
              10.horizontalSpace,
              Obx(() {
                if (mainController.settings.value.active_live == true) {
                  return IconButton(
                    icon: Icon(
                      Icons.live_tv,
                      color: PrimaryColor,
                    ),
                    onPressed: () {
                      Get.toNamed(LIVE_PAGE);
                    },
                  );
                } else {
                  return SizedBox(
                    width: 0,
                    height: 0,
                  );
                }
              }),
              10.horizontalSpace,
              IconButton(
                onPressed: () {
                  Get.toNamed(MENU_PAGE);
                },
                icon: Obx(() {
                  return Badge.count(
                    count: mainController.authUser.value != null
                        ? mainController.carts.length
                        : (mainController.carts.length) +
                            (mainController.authUser.value
                                    ?.unread_notifications_count.value ??
                                0),
                    backgroundColor: PrimaryColor,
                    alignment: Alignment(-0.006.sw, -0.0015.sh),
                    isLabelVisible: mainController.carts.length > 0,
                    child: Icon(
                      FontAwesomeIcons.bars,
                      size: 0.06.sw,
                    ),
                  );
                }),
              )
            ],
          ),
          Container(
            height: 0.043.sh,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: GrayLightColor))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == HOME_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    key: mainController.homeKey,
                    onPressed: () {
                      Get.toNamed(HOME_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.home,
                      size: 60.sp,
                      color:
                          Get.currentRoute == HOME_PAGE ? PrimaryColor : null,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == SECTIONS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    key: mainController.sectionKey,
                    onPressed: () {
                      Get.toNamed(SECTIONS_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.layerGroup,
                      size: 60.sp,
                      color: Get.currentRoute == SECTIONS_PAGE
                          ? PrimaryColor
                          : null,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == SERVICES_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    key: mainController.serviceKey,
                    onPressed: () {
                      Get.toNamed(SERVICES_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.locationDot,
                      size: 60.sp,
                      color: Get.currentRoute == SERVICES_PAGE
                          ? PrimaryColor
                          : null,
                      //color: RedColor,
                    ),
                  ),
                ),
                /*Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == JOBS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    key: jobKey,
                    onPressed: () {
                      Get.toNamed(JOBS_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.briefcase,
                      size: 60.sp,
                      color: Get.currentRoute == JOBS_PAGE ? PrimaryColor : null,
                    ),
                  ),
                ),*/
                // ... existing code ...
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == NOTIFICATION_PAGE
                        ? Border(
                      bottom: BorderSide(
                        color: PrimaryColor,
                        style: BorderStyle.solid,
                        width: 0.001.sw,
                      ),
                    )
                        : null,
                  ),
                  child: Obx(() {
                    return mainController.authUser.value==null || mainController.authUser.value!.unread_notifications_count.value == 0
                        ? IconButton(
                      key: mainController.notificationKey,
                      onPressed: () {
                        Get.toNamed(NOTIFICATION_PAGE);
                      },
                      icon: Icon(FontAwesomeIcons.bell,
                          size: 0.06.sw,
                          color: Get.currentRoute == NOTIFICATION_PAGE
                              ? PrimaryColor
                              : null),
                    )
                        : Badge.count(
                      count: mainController.authUser.value!.unread_notifications_count.value,
                      child: IconButton(
                        key: mainController.notificationKey,
                        onPressed: () {
                          Get.toNamed(NOTIFICATION_PAGE);
                        },
                        icon: Icon(FontAwesomeIcons.bell,
                            size: 60.sp,
                            color: Get.currentRoute == NOTIFICATION_PAGE
                                ? PrimaryColor
                                : null),
                      ),
                    );
                  }),
                ),
// ... existing code ...

                /*  Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == TENDERS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    key: tenderKey,
                    onPressed: () {
                      Get.toNamed(TENDERS_PAGE);
                    },
                    icon: Icon(FontAwesomeIcons.arrowTrendDown,
                        size: 60.sp,
                        color:
                            Get.currentRoute == TENDERS_PAGE ? PrimaryColor : null),
                  ),
                ),*/
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == COMMUNITIES_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: Obx(() {
                    return mainController.communityNotification.value == 0
                        ? IconButton(
                            key: mainController.communityKey,
                            onPressed: () {
                              Get.toNamed(COMMUNITIES_PAGE);
                            },
                            icon: Icon(FontAwesomeIcons.comments,
                                size: 0.06.sw,
                                color: Get.currentRoute == COMMUNITIES_PAGE
                                    ? PrimaryColor
                                    : null),
                          )
                        : Badge.count(
                            count: mainController.communityNotification.value,
                            child: IconButton(
                              key: mainController.communityKey,
                              onPressed: () {
                                Get.toNamed(COMMUNITIES_PAGE);
                              },
                              icon: Icon(FontAwesomeIcons.comments,
                                  size: 60.sp,
                                  color: Get.currentRoute == COMMUNITIES_PAGE
                                      ? PrimaryColor
                                      : null),
                            ),
                          );
                  }),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == PROFILE_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    key: mainController.profileKey,
                    onPressed: () {
                      Get.toNamed(PROFILE_PAGE);
                    },
                    icon: Icon(FontAwesomeIcons.solidUser,
                        size: 60.sp,
                        color: Get.currentRoute == PROFILE_PAGE
                            ? PrimaryColor
                            : null),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size(double.infinity, 0.12.sh);
  }
}

class AppBarComponent2 extends StatelessWidget implements PreferredSizeWidget {
  AppBarComponent2({
    Key? key,
    this.search,
    this.selected,
  }) : super(key: key);

  MainController mainController = Get.find<MainController>();
  Function()? search;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.001.sh),
      width: 1.sw,
      height: 0.11.sh,
      color: WhiteColor,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                width: 0.29.sw,
                child: Image(
                  image: const Svg(
                      'assets/images/svg/ali-pasha-horizantal-logo.svg',
                      color: PrimaryColor,
                      source: SvgSource.asset),
                  width: 0.27.sw,
                  height: 0.03.sh,
                  color: PrimaryColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              ),
              Expanded(child: Container()),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: PrimaryColor,
                ),
                onPressed: search ??
                    () => Get.toNamed(FILTER_PAGE,
                        arguments: selected ?? 'product'),
              ),
              10.horizontalSpace,
              Obx(() {
                if (mainController.settings.value.active_live == true) {
                  return IconButton(
                    icon: Icon(
                      Icons.live_tv,
                      color: PrimaryColor,
                    ),
                    onPressed: () {
                      Get.toNamed(LIVE_PAGE);
                    },
                  );
                } else {
                  return SizedBox(
                    width: 0,
                    height: 0,
                  );
                }
              }),
              10.horizontalSpace,
              IconButton(
                onPressed: () {
                  Get.toNamed(MENU_PAGE);
                },
                icon: Obx(() {
                  return Badge.count(
                    count: mainController.authUser.value != null
                        ? mainController.carts.length
                        : (mainController.carts.length) +
                            (mainController.authUser.value
                                    ?.unread_notifications_count.value ??
                                0),
                    backgroundColor: PrimaryColor,
                    alignment: Alignment(-0.006.sw, -0.0015.sh),
                    isLabelVisible: mainController.carts.length > 0,
                    child: Icon(
                      FontAwesomeIcons.bars,
                      size: 0.06.sw,
                    ),
                  );
                }),
              )
            ],
          ),
          Container(
            height: 0.043.sh,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: GrayLightColor))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == HOME_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(HOME_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.home,
                      size: 60.sp,
                      color:
                          Get.currentRoute == HOME_PAGE ? PrimaryColor : null,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == SECTIONS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(SECTIONS_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.layerGroup,
                      size: 60.sp,
                      color: Get.currentRoute == SECTIONS_PAGE
                          ? PrimaryColor
                          : null,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == SERVICES_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(SERVICES_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.locationDot,
                      size: 60.sp,
                      color: Get.currentRoute == SERVICES_PAGE
                          ? PrimaryColor
                          : null,
                      //color: RedColor,
                    ),
                  ),
                ),
                /*Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == JOBS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(

                    onPressed: () {
                      Get.toNamed(JOBS_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.briefcase,
                      size: 60.sp,
                      color: Get.currentRoute == JOBS_PAGE ? PrimaryColor : null,
                    ),
                  ),
                ),*/
                // ... existing code ...
                Container(
                  width: 0.15.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == NOTIFICATION_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed(NOTIFICATION_PAGE);
                        },
                        icon: Icon(
                          FontAwesomeIcons.bell,
                          size: 60.sp,
                          color: Get.currentRoute == NOTIFICATION_PAGE
                              ? PrimaryColor
                              : null,
                          //color: RedColor,
                        ),
                      ),
                      Obx(() {
                        return Positioned(
                          top: 0,
                          right: 0.1.sw,
                          child: Visibility(
                            visible:
                                mainController.communityNotification.value > 0,
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                color: PrimaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${mainController.communityNotification.value}",
                                style: H6WhiteTextStyle,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
// ... existing code ...

                /*  Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == TENDERS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(

                    onPressed: () {
                      Get.toNamed(TENDERS_PAGE);
                    },
                    icon: Icon(FontAwesomeIcons.arrowTrendDown,
                        size: 60.sp,
                        color:
                            Get.currentRoute == TENDERS_PAGE ? PrimaryColor : null),
                  ),
                ),*/
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == COMMUNITIES_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: Obx(() {
                    return mainController.communityNotification.value == 0
                        ? IconButton(
                            onPressed: () {
                              Get.toNamed(COMMUNITIES_PAGE);
                            },
                            icon: Icon(FontAwesomeIcons.comments,
                                size: 0.06.sw,
                                color: Get.currentRoute == COMMUNITIES_PAGE
                                    ? PrimaryColor
                                    : null),
                          )
                        : Badge.count(
                            count: mainController.communityNotification.value,
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(COMMUNITIES_PAGE);
                              },
                              icon: Icon(FontAwesomeIcons.comments,
                                  size: 60.sp,
                                  color: Get.currentRoute == COMMUNITIES_PAGE
                                      ? PrimaryColor
                                      : null),
                            ),
                          );
                  }),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == PROFILE_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: PrimaryColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(PROFILE_PAGE);
                    },
                    icon: Icon(FontAwesomeIcons.solidUser,
                        size: 60.sp,
                        color: Get.currentRoute == PROFILE_PAGE
                            ? PrimaryColor
                            : null),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size(double.infinity, 0.12.sh);
  }
}
