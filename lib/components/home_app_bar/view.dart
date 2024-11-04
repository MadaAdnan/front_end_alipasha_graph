import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../routes/routes_url.dart';



class HomeAppBarComponent extends StatelessWidget
    implements PreferredSizeWidget {
  HomeAppBarComponent({Key? key, this.search, this.selected}) : super(key: key);

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
                  image: const Svg('assets/images/svg/ali-pasha-horizantal-logo.svg',
                      color: RedColor, source: SvgSource.asset),
                  width: 0.27.sw,
                  height: 0.03.sh,
                  color: RedColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              ),
              Expanded(child: Container()),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: RedColor,
                ),
                onPressed: search ??
                    () => Get.toNamed(FILTER_PAGE,
                        arguments: selected ?? 'product'),
              ),
              Obx(() {
                return IconButton(
                  icon: Icon(
                    Icons.live_tv,
                    color: mainController.settings.value.active_live == true
                        ? RedColor
                        : GrayLightColor,
                  ),
                  onPressed: () {
                    if (mainController.settings.value.active_live == true) {
                      Get.toNamed(LIVE_PAGE);
                    }
                  },
                );
              }),
              IconButton(
                onPressed: () {
                  Get.toNamed(MENU_PAGE);
                },
                icon: Obx(() {
                  return Badge.count(
                    count: mainController.carts.length,
                    backgroundColor: RedColor,
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
                              color: RedColor,
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
                      size: 0.06.sw,
                      color: Get.currentRoute == HOME_PAGE ? RedColor : null,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == SECTIONS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: RedColor,
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
                      size: 0.06.sw,
                      color:
                          Get.currentRoute == SECTIONS_PAGE ? RedColor : null,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == SERVICES_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: RedColor,
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
                      size: 0.06.sw,
                      color:
                          Get.currentRoute == SERVICES_PAGE ? RedColor : null,
                      //color: RedColor,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == JOBS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: RedColor,
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
                      size: 0.06.sw,
                      color: Get.currentRoute == JOBS_PAGE ? RedColor : null,
                    ),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == TENDERS_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: RedColor,
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
                        size: 0.06.sw,
                        color:
                            Get.currentRoute == TENDERS_PAGE ? RedColor : null),
                  ),
                ),
                Container(
                  width: 0.1.sw,
                  decoration: BoxDecoration(
                    border: Get.currentRoute == COMMUNITIES_PAGE
                        ? Border(
                            bottom: BorderSide(
                              color: RedColor,
                              style: BorderStyle.solid,
                              width: 0.001.sw,
                            ),
                          )
                        : null,
                  ),
                  child: Obx(() {
                    return mainController.communityNotification.value ==0
                        ? IconButton(
                            onPressed: () {
                              Get.toNamed(COMMUNITIES_PAGE);
                            },
                            icon: Icon(FontAwesomeIcons.comments,
                                size: 0.06.sw,
                                color: Get.currentRoute == COMMUNITIES_PAGE
                                    ? RedColor
                                    : null),
                          )
                        : Badge.count(
                            count: mainController.communityNotification.value,
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(COMMUNITIES_PAGE);
                              },
                              icon: Icon(FontAwesomeIcons.comments,
                                  size: 0.06.sw,
                                  color: Get.currentRoute == COMMUNITIES_PAGE
                                      ? RedColor
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
                              color: RedColor,
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
                        size: 0.06.sw,
                        color:
                            Get.currentRoute == PROFILE_PAGE ? RedColor : null),
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
