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
    return Scaffold(
      backgroundColor: WhiteColor,
      /*appBar: PreferredSize(
        preferredSize: Size(1.sw, 0.35.sh),
        child: Container(
          color: WhiteColor,
          child: Column(
            children: [
              Container(
                width: 1.sw,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.all(0.005.sw),
                      decoration: BoxDecoration(
                        color: GrayDarkColor,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(top: 0.05.sh),
                      child: CircleAvatar(
                        backgroundColor: WhiteColor,
                        minRadius: 0.1.sw,
                        maxRadius: 0.12.sw,
                        child: Container(
                          padding: EdgeInsets.all(0.008.sw),
                          decoration: BoxDecoration(
                              color: GrayDarkColor, shape: BoxShape.circle,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  '${mainController.authUser.value?.logo}',
                                ),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.004.sh,
                        left: 0.01.sw,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Edit_PROFILE_PAGE);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 0.35.sw,
                            height: 0.05.sh,
                            decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Text(
                              'تعديل الحساب',
                              style: H3WhiteTextStyle,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Text(
                '${mainController.authUser.value?.seller_name}',
                style: H1BlackTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildWidget(
                      title: 'أتابعه',
                      count:
                          mainController.authUser.value?.followers?.length ?? 0,
                      onTap: () {
                        Get.toNamed(FOLLOWERS_PAGE);
                      }),
                  _buildWidget(title: 'يتابعني', count:  mainController.authUser.value?.followingCount ?? 0),
                //  _buildWidget(title: 'تسجيلات الإعجاب', count: 1000),
                ],
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _pageButton(
                      title: 'منشوراتي',
                      icon: FontAwesomeIcons.newspaper,
                      index: 0),
                  _pageButton(
                      title: 'إعلانات ممولة',
                      icon: FontAwesomeIcons.rectangleAd,
                      index: 1),
                  _pageButton(
                      title: 'الإحصائيات',
                      index: 2,
                      icon: FontAwesomeIcons.chartBar),
                ],
              )
            ],
          ),
        ),
      ),*/
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*  InkWell(
                      onTap: () {
                        Get.toNamed(Edit_PROFILE_PAGE);
                      },
                      child: Container(
                        width: 0.07.sw,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.01.sw, horizontal: 0.01.sw),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: WhiteColor),
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: "${mainController.authUser.value?.id_color}"
                              .toColor(),
                          size: 0.05.sw,
                        ),
                      ),
                    ),*/
                    InkWell(
                      child: Container(
                        width: 0.07.sw,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.01.sw, horizontal: 0.01.sw),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: WhiteColor),
                        child: Icon(
                          FontAwesomeIcons.shareNodes,
                          color: "${mainController.authUser.value?.id_color}"
                              .toColor(),
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
            top: 0.165.sh,
            left: 0,
            child: Container(
              width: 1.sw,
              height: 0.1.sh,
              decoration: BoxDecoration(
                  border: Border.all(color: WhiteColor),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "${mainController.authUser.value?.logo}"),
                      fit: BoxFit.contain)),
            ),
          ),
          Positioned(
            top: 0.22.sh,
            left: 0,
            child: Container(
              width: 1.sw,
              height: 0.27.sh,
              padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 0.1.sw,
                    alignment: Alignment.centerRight,
                    child: Obx(() {
                      return Column(
                        children: [
                          if (mainController
                              .authUser.value?.social?.instagram !=
                              null &&
                              mainController
                                  .authUser.value?.social?.instagram !=
                                  '')
                            Container(
                              child: InkWell(
                                onTap: () {
                                  openUrl(
                                      url:
                                      "${mainController.authUser.value?.social
                                          ?.instagram}");
                                },
                                child: Icon(
                                  FontAwesomeIcons.instagram,
                                  color:
                                  "${mainController.authUser.value?.id_color}"
                                      .toColor(),
                                  size: 0.06.sw,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 0.007.sh),
                            ),
                          if (mainController.authUser.value?.social?.face !=
                              null &&
                              mainController.authUser.value?.social?.face != '')
                            Container(
                              child: InkWell(
                                  onTap: () {
                                    openUrl(
                                        url:
                                        "${mainController.authUser.value?.social
                                            ?.face}");
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.facebook,
                                    color:
                                    "${mainController.authUser.value?.id_color}"
                                        .toColor(),
                                    size: 0.06.sw,
                                  )),
                              padding: EdgeInsets.symmetric(vertical: 0.007.sh),
                            ),
                          if (mainController.authUser.value?.social?.linkedin !=
                              null &&
                              mainController.authUser.value?.social?.linkedin !=
                                  '')
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.007.sh),
                              child: InkWell(
                                onTap: () {
                                  openUrl(
                                      url:
                                      "${mainController.authUser.value?.social
                                          ?.linkedin}");
                                },
                                child: Icon(
                                  FontAwesomeIcons.linkedin,
                                  color:
                                  "${mainController.authUser.value?.id_color}"
                                      .toColor(),
                                  size: 0.06.sw,
                                ),
                              ),
                            ),
                          if (mainController.authUser.value?.social?.linkedin !=
                              null &&
                              mainController.authUser.value?.social?.linkedin !=
                                  '')
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.007.sh),
                              child: InkWell(
                                onTap: () {
                                  openUrl(
                                      url:
                                      "${mainController.authUser.value?.social
                                          ?.linkedin}");
                                },
                                child: Icon(
                                  FontAwesomeIcons.tiktok,
                                  color:
                                  "${mainController.authUser.value?.id_color}"
                                      .toColor(),
                                  size: 0.06.sw,
                                ),
                              ),
                            ),
                          if (mainController.authUser.value?.phone != null &&
                              mainController.authUser.value?.phone != '')
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.007.sh),
                              child: InkWell(
                                onTap: () {
                                  openUrl(
                                      url:
                                      "https://wa.me/${mainController.authUser
                                          .value?.phone}");
                                },
                                child: Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color:
                                  "${mainController.authUser.value?.id_color}"
                                      .toColor(),
                                  size: 0.06.sw,
                                ),
                              ),
                            ),
                          if (mainController.authUser.value?.social?.twitter !=
                              null &&
                              mainController.authUser.value?.social?.twitter !=
                                  '')
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.007.sh),
                              child: InkWell(
                                onTap: () {
                                  openUrl(
                                      url:
                                      "${mainController.authUser.value?.social
                                          ?.twitter}");
                                },
                                child: Icon(
                                  FontAwesomeIcons.xTwitter,
                                  color:
                                  "${mainController.authUser.value?.id_color}"
                                      .toColor(),
                                  size: 0.06.sw,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  Obx(() {
                    return Container(
                      width: 0.85.sw,
                      padding: EdgeInsets.only(top: 0.02.sh),
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(0.025.sw, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SellerNameComponent(isVerified:mainController.authUser.value?.is_verified??false ,sellerName: "${mainController.authUser.value?.seller_name}",),
                            if ((mainController.authUser.value?.is_verified ==
                                true))
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.01.sh),
                                child: Text(
                                  "${mainController.authUser.value
                                      ?.info}",
                                  style: H4GrayTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if ((mainController.authUser.value?.address !=
                                null &&
                                mainController.authUser.value?.address != ''))
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.02.sh),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "${mainController.authUser.value
                                              ?.total_views}"
                                              .toFormatNumberK(),
                                          style: H2RedTextBoldStyle.copyWith(
                                              color:
                                              "${mainController.authUser.value
                                                  ?.id_color}"
                                                  .toColor()),
                                          textDirection: TextDirection.ltr,
                                        ),
                                        Text(
                                          "مشاهدات",
                                          style: H4RegularDark,
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      child: Column(
                                        children: [
                                          Obx(() {
                                            return Text(
                                              '${mainController.authUser.value
                                                  ?.followingCount}'
                                                  .toFormatNumberK(),
                                              style: H2RedTextBoldStyle
                                                  .copyWith(
                                                  color:
                                                  "${mainController.authUser
                                                      .value
                                                      ?.id_color}"
                                                      .toColor()),
                                              textDirection: TextDirection.ltr,
                                            );
                                          }),
                                          Text(
                                            "متابعين",
                                            style: H4RegularDark,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(FOLLOWERS_PAGE);
                                      },
                                      child: Column(
                                        children: [
                                          Obx(() {
                                            return Text(
                                              '${mainController.authUser.value
                                                  ?.followers!.length}'
                                                  .toFormatNumberK(),
                                              style: H2RedTextBoldStyle
                                                  .copyWith(
                                                  color:
                                                  "${mainController.authUser
                                                      .value
                                                      ?.id_color}"
                                                      .toColor()),
                                              textDirection: TextDirection.ltr,
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
                            Container(

                              child: Obx(() {
                                mainController.logger.e(
                                    mainController.authUser.value
                                        ?.is_verified);
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    if(mainController.authUser.value
                                        ?.is_verified != true)
                                      InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0.01.sh,
                                                horizontal: 0.02.sw),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(15.r),
                                                color: RedColor),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'توثيق الحساب ',
                                                    style: H4WhiteTextStyle,
                                                  ),
                                                ),
                                                Container(
                                                  width: 0.04.sw,
                                                  height: 0.04.sw,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: Svg(
                                                            "assets/images/svg/verified.svg",
                                                            color: WhiteColor,
                                                          ),
                                                          fit: BoxFit.cover)),
                                                )
                                              ],
                                            ),
                                          )),
                                    if(mainController.authUser.value
                                        ?.is_verified == true)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.01.sh,
                                            horizontal: 0.02.sw),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                15.r), color: RedColor),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                'الحساب موثق',
                                                style: H4WhiteTextStyle,
                                              ),
                                            ),
                                            Container(
                                              width: 0.04.sw,
                                              height: 0.04.sw,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Svg(
                                                        "assets/images/svg/verified.svg",
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
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  15.r), color: RedColor),
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
                                                  color: WhiteColor,),
                                              )
                                            ],
                                          ),
                                        )),

                                  ],
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.475.sh,
            child: Container(
              width: 1.sw,
              height: 0.7.sh,
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

  Widget _pageButton({String? title, IconData? icon, int? index}) {
    return InkWell(
      onTap: () {
        logic.pageSelected.value = index!;
        logic.pageController.animateToPage(index,
            duration: Duration(microseconds: 400), curve: Curves.bounceInOut);
      },
      child: Obx(() {
        return Container(
          alignment: Alignment.center,
          width: 0.31.sw,
          height: 0.045.sh,
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
          decoration: BoxDecoration(
              color: logic.pageSelected == index ? RedColor : GrayLightColor,
              borderRadius: BorderRadius.circular(0.02.sw)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$title',
                style: logic.pageSelected == index
                    ? H4WhiteTextStyle
                    : H4BlackTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              20.horizontalSpace,
              SizedBox(
                  width: 0.05.sw,
                  child: Icon(
                    icon,
                    color: logic.pageSelected == index ? WhiteColor : IconColor,
                  ))
            ],
          ),
        );
      }),
    );
  }

  Widget _buildWidget({String? title, int? count, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 0.3.sw,
        height: 0.08.sh,
        decoration: BoxDecoration(
          border: Border.all(color: GrayDarkColor),
          borderRadius: BorderRadius.circular(15.r),
          color: WhiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$count",
              style: H3BlackTextStyle,
            ),
            15.verticalSpace,
            Text(
              "$title",
              style: H4BlackTextStyle.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
