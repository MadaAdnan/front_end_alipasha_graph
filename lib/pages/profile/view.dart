import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/curve_profile.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/pages/profile/tabs/advice_tab.dart';
import 'package:ali_pasha_graph/pages/profile/tabs/tab_chart.dart';
import 'package:ali_pasha_graph/pages/profile/tabs/tab_product.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../components/expand_search.dart';
import 'logic.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  MainController mainController = Get.find<MainController>();
  final ProfileLogic logic = Get.find<ProfileLogic>();
  List<Widget> pages = [
    TabProduct(),
    AdviceTab(),
    TabChart(),
  ];

  @override
  Widget build(BuildContext context) {
    Color? color=mainController
        .authUser.value?.is_verified==true ? mainController
        .authUser.value?.id_color!.toColor():DarkColor;
    return Scaffold(
      backgroundColor: WhiteColor,

      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: CurveClipper(),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 0.02.sw, horizontal: 0.02.sw),
                width: 1.sw,
                height: 0.25.sh,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            "${mainController.authUser.value?.logo}"),
                        fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 0.85.sw,
                        height: 0.06.sh,
                        child: Obx(() {
                          return Visibility(child: ExpandSearch(
                            controller: logic.searchController,
                            onEditDone: () {
                              logic.search.value = logic.searchController.text;
                              return logic.searchController.text;
                            },
                          ),visible: logic.pageSelected.value==0,);
                        })),
                    InkWell(
                      child: Container(
                        width: 0.07.sw,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.03.sw, horizontal: 0.01.sw),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: WhiteColor),
                        child: Icon(
                          FontAwesomeIcons.shareNodes,
                          color: color,
                          size: 0.05.sw,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.16.sh,
            left: 0,
            child: Container(
              width: 1.sw,
              height: 0.12.sh,
              decoration: BoxDecoration(
                  border: Border.all(color: WhiteColor),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "${mainController.authUser.value?.image}"),
                      fit: BoxFit.fitHeight)),
            ),
          ),
          Positioned(
            top: 0.25.sh,
            left: 0,
            child: Container(
              width: 1.sw,
              height: 0.35.sh,

              padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(mainController.authUser.value
                          ?.is_verified==true)
                      Container(
                        width: 0.1.sw,
                        alignment: Alignment.centerRight,
                        child: Obx(() {
                          return Transform.translate(
                            offset: Offset(0, -0.03.sh), child: Column(
                            children: [
                              if (mainController
                                  .authUser.value?.social?.instagram !=
                                  null &&
                                  mainController
                                      .authUser.value?.social?.instagram !=
                                      '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.007.sh),
                                  child: InkWell(
                                    onTap: () {
                                      openUrl(
                                          url:
                                          "${mainController.authUser.value
                                              ?.social?.instagram}");
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.instagram,
                                      color:
                                      color,
                                      size: 0.06.sw,
                                    ),
                                  ),
                                ),
                              if (mainController.authUser.value?.social?.face !=
                                  null &&
                                  mainController.authUser.value?.social?.face !=
                                      '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.007.sh),
                                  child: InkWell(
                                      onTap: () {
                                        openUrl(
                                            url:
                                            "${mainController.authUser.value
                                                ?.social?.face}");
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.facebook,
                                        color:
                                        color,
                                        size: 0.06.sw,
                                      )),
                                ),
                              if (mainController.authUser.value?.social
                                  ?.linkedin !=
                                  null &&
                                  mainController.authUser.value?.social
                                      ?.linkedin !=
                                      '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.007.sh),
                                  child: InkWell(
                                    onTap: () {
                                      openUrl(
                                          url:
                                          "${mainController.authUser.value
                                              ?.social?.linkedin}");
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.linkedin,
                                      color:
                                      color,
                                      size: 0.06.sw,
                                    ),
                                  ),
                                ),
                              if (mainController.authUser.value?.social
                                  ?.linkedin !=
                                  null &&
                                  mainController.authUser.value?.social
                                      ?.linkedin !=
                                      '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.007.sh),
                                  child: InkWell(
                                    onTap: () {
                                      openUrl(
                                          url:
                                          "${mainController.authUser.value
                                              ?.social?.linkedin}");
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.tiktok,
                                      color:
                                      color,
                                      size: 0.06.sw,
                                    ),
                                  ),
                                ),
                              if (mainController.authUser.value?.phone !=
                                  null &&
                                  mainController.authUser.value?.phone != '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.007.sh),
                                  child: InkWell(
                                    onTap: () {
                                      openUrl(
                                          url:
                                          "https://wa.me/${mainController
                                              .authUser.value?.phone}");
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color:
                                      color,
                                      size: 0.06.sw,
                                    ),
                                  ),
                                ),
                              if (mainController.authUser.value?.social
                                  ?.twitter !=
                                  null &&
                                  mainController.authUser.value?.social
                                      ?.twitter !=
                                      '')
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.007.sh),
                                  child: InkWell(
                                    onTap: () {
                                      openUrl(
                                          url:
                                          "${mainController.authUser.value
                                              ?.social?.twitter}");
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.xTwitter,
                                      color:
                                      color,
                                      size: 0.06.sw,
                                    ),
                                  ),
                                ),
                            ],
                          ),);
                        }),
                      ),
                      Obx(() {
                        return Transform.translate(offset: Offset(0, 0.01.sh),child:  Container(
                          width: 0.86.sw,
                          padding: EdgeInsets.only(top: 0.02.sh),
                          alignment: Alignment.center,
                          child: Transform.translate(
                            offset: Offset(0.025.sw, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 0.03.sw),
                                  width: 0.9.sw,

                                  alignment: Alignment.center,
                                  child: SellerNameComponent(
                                    alignment: MainAxisAlignment.center,
                                    color: color,
                                    white: false,
                                    isVerified: mainController
                                        .authUser.value?.is_verified ??
                                        false,
                                    sellerName:
                                    "${mainController.authUser.value
                                        ?.seller_name}",
                                  ),
                                ),
                                if ((mainController.authUser.value
                                    ?.is_verified ==
                                    true))
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 0.01.sh),
                                    child: Text(
                                      "${mainController.authUser.value?.info}",
                                      style: H4GrayTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                if ((mainController.authUser.value?.address !=
                                    null &&
                                    mainController.authUser.value?.address !=
                                        ''))
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          "${mainController.authUser.value
                                              ?.address}",
                                          style: H4GrayTextStyle,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.locationDot,
                                          color: GrayDarkColor,
                                          size: 0.04.sw,
                                        ),
                                      ],
                                    ),
                                  ),
                                Obx(() {
                                  return Container(

                                    width: 0.75.sw,
                                    padding:
                                    EdgeInsets.symmetric(vertical: 0.02.sh),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [

                                        InkWell(
                                          child: Column(
                                            children: [
                                              Obx(() {
                                                return Text(
                                                  '${mainController.authUser.value?.followingCount}'
                                                      .toFormatNumberK(),
                                                  style: H0RegularDark
                                                      .copyWith(
                                                      fontWeight: FontWeight.w900,
                                                      color:
                                                      color),
                                                  textDirection: TextDirection
                                                      .ltr,
                                                );
                                              }),
                                              Text(
                                                "متابعين",
                                                style: H4RegularDark,
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${mainController.authUser.value?.total_views}"
                                                  .toFormatNumberK(),
                                              style: H0RegularDark
                                                  .copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                  color),
                                              textDirection: TextDirection.ltr,
                                            ),
                                            Text(
                                              "مشاهدات",
                                              style: H4RegularDark,
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(FOLLOWERS_PAGE);
                                          },
                                          child: Column(
                                            children: [
                                              Obx(() {
                                                return Text(
                                                  '${mainController.authUser.value?.followers?.length}'
                                                      .toFormatNumberK(),
                                                  style: H0RegularDark
                                                      .copyWith(
                                                      fontWeight: FontWeight.w900,
                                                      color:
                                                      color),
                                                  textDirection: TextDirection
                                                      .ltr,
                                                );
                                              }),
                                              Text(
                                                "أتابعه",
                                                style: H4RegularDark,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),

                                30.verticalSpace,

                              ],
                            ),
                          ),
                        ),);
                      })
                    ],
                  ),

                  Transform.translate(offset: Offset(0, 0),child: Container(
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          if (mainController
                              .authUser.value?.is_verified !=
                              true)
                            InkWell(
                                onTap: () {
                                  openUrl(url: "https://wa.me/${mainController.settings.value.social?.phone}");
                                },
                                child: Container(
                                  width:0.35.sw,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.01.sh,
                                      horizontal: 0.02.sw),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15.r),
                                      color:
                                      mainController
                                          .authUser.value?.is_verified==true ? color:Colors.blue),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'تـوثيق الحسـاب ',
                                          style: H4WhiteTextStyle,
                                        ),
                                      ),
                                      Container(
                                        width: 0.04.sw,
                                        height: 0.04.sw,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: Svg(
                                                  "assets/images/svg/verified_white.svg",
                                                  color: WhiteColor,
                                                ),
                                                fit: BoxFit
                                                    .cover)),
                                      )
                                    ],
                                  ),
                                )),
                          if (mainController
                              .authUser.value?.is_verified ==
                              true)
                            Container(
                              width:0.35.sw,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.01.sh,
                                  horizontal: 0.02.sw),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(15.r),
                                  color:
                                  mainController
                                      .authUser.value?.is_verified==true ? color:Colors.blue),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(

                                    child: Text(
                                      'الحسـاب مـوثق',
                                      style: H4WhiteTextStyle,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Container(
                                    width: 0.04.sw,
                                    height: 0.04.sw,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: Svg(
                                              "assets/images/svg/verified_white.svg",
                                              color: WhiteColor,
                                            ),
                                            fit: BoxFit.cover)),
                                  )
                                ],
                              ),
                            ),
                          InkWell(
                              onTap: () {
                                Get.toNamed(Edit_PROFILE_PAGE);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.01.sh,
                                    horizontal: 0.02.sw),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                    color:
                                    mainController
                                        .authUser.value?.is_verified==true ? color:Colors.blue),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'تعديل الملف الشخصي ',
                                        style: H4WhiteTextStyle,
                                      ),
                                    ),
                                    Container(
                                      width: 0.04.sw,
                                      height: 0.04.sw,
                                      child: Icon(
                                        FontAwesomeIcons.edit,
                                        size: 0.04.sw,
                                        color: WhiteColor,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      );
                    }),
                  ),),
                  30.verticalSpace,
                  Transform.translate(offset: Offset(0, 0),child: Container(
                    width: 1.sw,
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                logic.pageSelected.value = 0;
                                logic.pageController.animateToPage(0,
                                    duration: Duration(microseconds: 400),
                                    curve: Curves.bounceInOut);
                              },
                              child: Container(
                                width: 0.28.sw,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.01.sh,
                                    horizontal: 0.02.sw),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                    color: logic.pageSelected.value == 0 ?
                                    (mainController.authUser.value?.is_verified==true ?"${mainController.authUser.value?.id_color}"
                                        .toColor():RedColor ): GrayLightColor),
                                child: Text('المنتجات',
                                  style: logic.pageSelected.value == 0
                                      ? H4WhiteTextStyle
                                      : H4BlackTextStyle,),
                              )),

                          InkWell(
                              onTap: () {
                                logic.pageSelected.value = 1;
                                logic.pageController.animateToPage(1,
                                    duration: Duration(microseconds: 400),
                                    curve: Curves.bounceInOut);
                              },
                              child: Container(
                                width: 0.28.sw,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.01.sh,
                                    horizontal: 0.02.sw),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                    color: logic.pageSelected.value == 1 ?
                                    (mainController.authUser.value?.is_verified==true ?"${mainController.authUser.value?.id_color}"
                                        .toColor():RedColor ): GrayLightColor),
                                child: Text('الإعلانات الممولة',
                                  style: logic.pageSelected.value == 1
                                      ? H4WhiteTextStyle
                                      : H4BlackTextStyle,),
                              )),

                          InkWell(
                              onTap: () {
                                logic.pageSelected.value = 2;
                                logic.pageController.animateToPage(2,
                                    duration: Duration(microseconds: 400),
                                    curve: Curves.bounceInOut);
                              },
                              child: Container(
                                width: 0.28.sw,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.01.sh,
                                    horizontal: 0.02.sw),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                    color: logic.pageSelected.value == 2 ?
                                    (mainController.authUser.value?.is_verified==true ?"${mainController.authUser.value?.id_color}"
                                        .toColor():RedColor ): GrayLightColor),
                                child: Text('الإحصائيات',
                                  style: logic.pageSelected.value == 2
                                      ? H4WhiteTextStyle
                                      : H4BlackTextStyle,),
                              )),
                        ],
                      );
                    }),
                  ),),
                ],
              ),

            ),
          ),
          Positioned(
            top: 0.57.sh,
            child: Container(
              width: 1.sw,
              height: 0.43.sh,
              padding: EdgeInsets.only(bottom: 0.01.sh),
              child: PageView(
                controller: logic.pageController,
                onPageChanged: (index) {
                  logic.pageSelected.value = index;
                  logic.pageController.animateToPage(index,
                      duration: Duration(microseconds: 400),
                      curve: Curves.bounceInOut);
                },
                children: pages,
              ),
            ),
          )
        ],
      ),
    );
  }




}
