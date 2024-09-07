import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeSliverAppBarComponent extends StatelessWidget {
  HomeSliverAppBarComponent({Key? key,required this.child}) : super(key: key);
  MainController mainController = Get.find<MainController>();
final Widget child;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0.197.sh,
      expandedHeight: 0.22.sh,
      collapsedHeight: 0.197.sh,
      floating: true,
      pinned: false,
      centerTitle: true,
      leading: Container(),
      primary: true,
      foregroundColor: WhiteColor,
      backgroundColor: WhiteColor,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.fadeTitle],
        collapseMode: CollapseMode.parallax,
        expandedTitleScale: 1,
        titlePadding: EdgeInsets.only(bottom: 55),
        title: Container(
          color: WhiteColor,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 1.sw,
                color: WhiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 0.4.sw,
                      child: Image(
                        image: Svg(
                            'assets/images/svg/ali-pasha-horizantal-logo.svg',
                            color: RedColor,
                            source: SvgSource.asset),
                        color: RedColor,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.008.sw),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(FILTER_PAGE);
                            },
                            child: Icon(
                              FontAwesomeIcons.search,
                              size: 55.w,
                              color: RedColor,
                            ),
                          ),
                          20.horizontalSpace,
                          MaterialButton(
                            color: RedColor,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  FontAwesomeIcons.towerCell,
                                  color: WhiteColor,
                                  size: 45.w,
                                ),
                                10.horizontalSpace,
                                Text(
                                  'Live',
                                  style: H4WhiteTextStyle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              10.verticalSpace,
              Container(
                width: 0.4.sw,
                height: 0.052.sh,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Get.currentRoute == HOME_PAGE
                            ? Border(
                                bottom: BorderSide(
                                  color: RedColor,
                                  style: BorderStyle.solid,
                                  width: 0.002.sh,
                                ),
                              )
                            : null,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.offAndToNamed(HOME_PAGE);
                        },
                        icon: Icon(
                          FontAwesomeIcons.home,
                          size: 55.w,
                          color:
                              Get.currentRoute == HOME_PAGE ? RedColor : null,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Get.currentRoute == SERVICES_PAGE
                            ? Border(
                                bottom: BorderSide(
                                  color: RedColor,
                                  style: BorderStyle.solid,
                                  width: 0.002.sh,
                                ),
                              )
                            : null,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(SERVICES_PAGE);
                        },
                        icon: Icon(
                          FontAwesomeIcons.bookOpen,
                          size: 55.w,
                          color: Get.currentRoute == SERVICES_PAGE? RedColor : null,
                          //color: RedColor,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Get.currentRoute == JOBS_PAGE
                            ? Border(
                                bottom: BorderSide(
                                  color: RedColor,
                                  style: BorderStyle.solid,
                                  width: 0.002.sh,
                                ),
                              )
                            : null,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.offAndToNamed(JOBS_PAGE);
                        },
                        icon: Icon(
                          FontAwesomeIcons.headset,
                          size: 55.w,
                          color:
                              Get.currentRoute == JOBS_PAGE ? RedColor : null,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Get.currentRoute == TENDERS_PAGE
                            ? Border(
                                bottom: BorderSide(
                                  color: RedColor,
                                  style: BorderStyle.solid,
                                  width: 0.002.sh,
                                ),
                              )
                            : null,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.offAndToNamed(TENDERS_PAGE);
                        },
                        icon: Icon(FontAwesomeIcons.arrowTrendDown,
                            size: 55.w,
                            color: Get.currentRoute == TENDERS_PAGE
                                ? RedColor
                                : null),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Get.currentRoute == COMMUNITIES_PAGE
                            ? Border(
                                bottom: BorderSide(
                                  color: RedColor,
                                  style: BorderStyle.solid,
                                  width: 0.002.sh,
                                ),
                              )
                            : null,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(COMMUNITIES_PAGE);
                        },
                        icon: Icon(FontAwesomeIcons.comments,
                            size: 55.w,
                            color: Get.currentRoute == COMMUNITIES_PAGE
                                ? RedColor
                                : null),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(MENU_PAGE);
                      },
                      icon: Icon(
                        FontAwesomeIcons.bars,
                        size: 75.w,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: GrayDarkColor,
                height: 0.0017.sh,
              ),
            ],
          ),
        ),
        centerTitle: true,
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            Divider(
              color: GrayDarkColor,
              height: 0.0017.sh,
            ),
          ],
        ),
      ),
    );
  }
}
