import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeSliverAppBarComponent extends StatelessWidget {
  HomeSliverAppBarComponent({super.key});
  MainController mainController = Get.find<MainController>();


  @override

  Widget build(BuildContext context) {
    return SliverAppBar(

      pinned: true,
      floating: false,
      expandedHeight: 0.22.sh,
      toolbarHeight: 0.099.sh,
      backgroundColor: Colors.white,
      primary: true,
      leading: Container(height: 0,padding: EdgeInsets.zero,margin:EdgeInsets.zero ,),
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        titlePadding: EdgeInsets.symmetric(horizontal: 0.0001.sw),
        stretchModes: const [StretchMode.fadeTitle,StretchMode.zoomBackground],
        expandedTitleScale: 1.2,
        title: Container(
          width: 1.sw,
          height: 0.13.sh,
          color: WhiteColor,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    width: 0.29.sw,padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    child: Image(
                      image: const Svg('assets/images/svg/ali-pasha-horizantal-logo.svg',
                          color: RedColor, source: SvgSource.asset),
                      width: 0.27.sw,
                      height: 0.03.sh,
                      color: RedColor,
                    ),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: RedColor,

                    ),
                    onPressed: () {
                      Get.toNamed(FILTER_PAGE);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.live_tv,
                      color: RedColor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(MENU_PAGE);
                    },
                    icon: Icon(
                      FontAwesomeIcons.bars,
                      size: 0.04.sw,
                    ),
                  )
                ],
              ),
             Container(
               height: 0.034.sh,
               decoration: const BoxDecoration(
                 border:Border(bottom: BorderSide(color: GrayLightColor))
               ),
               child:  Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                         Get.offAndToNamed(HOME_PAGE);
                       },
                       icon: Icon(
                         FontAwesomeIcons.home,
                         size: 0.04.sw,
                         color: Get.currentRoute == HOME_PAGE ? RedColor : null,
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
                         FontAwesomeIcons.bookOpen,
                         size: 0.04.sw,
                         color: Get.currentRoute == SERVICES_PAGE ? RedColor : null,
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
                         Get.offAndToNamed(JOBS_PAGE);
                       },
                       icon: Icon(
                         FontAwesomeIcons.headset,
                         size: 0.04.sw,
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
                         Get.offAndToNamed(TENDERS_PAGE);
                       },
                       icon: Icon(FontAwesomeIcons.arrowTrendDown,
                           size: 0.04.sw,
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
                     child: IconButton(
                       onPressed: () {
                         Get.toNamed(COMMUNITIES_PAGE);
                       },
                       icon: Icon(FontAwesomeIcons.comments,
                           size: 0.04.sw,
                           color: Get.currentRoute == COMMUNITIES_PAGE
                               ? RedColor
                               : null),
                     ),
                   ),

                 ],
               ),
             ),


            ],
          ),
        ),
      ),

    );
  }

/*SliverAppBar(
      toolbarHeight: 0.1.sh, // تعديل الارتفاع حسب الحاجة
      expandedHeight: 0.19.sh, // تعديل الارتفاع حسب الحاجة
      collapsedHeight: 0.1.sh, // تعديل الارتفاع حسب الحاجة
      floating: true,
      pinned: true,
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
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
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
        background:  child!=null? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child!,
            Divider(
              color: GrayDarkColor,
              height: 0.0017.sh,
            ),
          ],
        ):Container(height: 0,),
      ),
    )*/
}
