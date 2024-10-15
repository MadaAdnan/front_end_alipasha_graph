import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/seller_name_component.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/curve_profile.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);

  final logic = Get.find<ProductsLogic>();
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

          if (scrollInfo is ScrollUpdateNotification) {
            if (scrollInfo.metrics.pixels >
                scrollInfo.metrics.minScrollExtent) {
              mainController.is_show_home_appbar(false);
            } else {
              mainController.is_show_home_appbar(true);
            }
          }
          return true;
        },
        child: Obx(() {
          Color? color=logic.seller.value?.is_verified==true ? logic.seller.value?.id_color!.toColor():DarkColor;
          if (logic.loading.value)
            return ListView(
              children: [
                Shimmer.fromColors(
                    child: Container(
                      width: 1.sw,
                      height: 0.2.sh,
                      color: Colors.red,
                    ),
                    baseColor: GrayLightColor,
                    highlightColor: GrayWhiteColor),
                Shimmer.fromColors(
                    child: Container(
                      width: 1.sw,
                      height: 0.2.sh,
                      color: Colors.red,
                    ),
                    baseColor: GrayLightColor,
                    highlightColor: GrayWhiteColor),
                ...List.generate(
                    3, (index) => MinimizeDetailsProductComponentLoading())
              ],
            );
          return Stack(
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
                                "${logic.seller.value?.logo}"),
                            fit: BoxFit.cover)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Container(
                            width: 0.07.sw,
                            padding: EdgeInsets.symmetric(
                                vertical: 0.03.sw, horizontal: 0.01.sw),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: WhiteColor),
                            child: Icon(
                              FontAwesomeIcons.shareNodes,
                              color:
                                  color,
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
                              "${logic.seller.value?.image}"),
                          fit: BoxFit.contain)),
                ),
              ),
              if (logic.seller.value?.is_verified == true)
                Positioned(
                  top: 0.23.sh,
                  child: Container(
                    width: 1.sw,
                    height: 0.35.sh,
                    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 0.1.sw,
                              alignment: Alignment.centerRight,
                              child: Transform.translate(
                                offset: Offset(0, -0.03.sh),
                                child: Obx(() {
                                  return Column(
                                    children: [
                                      if (logic.seller.value?.social
                                                  ?.instagram !=
                                              null &&
                                          logic.seller.value?.social
                                                  ?.instagram !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.instagram}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.instagram,
                                              color:
                                                 color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.social?.face !=
                                              null &&
                                          logic.seller.value?.social?.face !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                              onTap: () {
                                                openUrl(
                                                    url:
                                                        "${logic.seller.value?.social?.face}");
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.facebook,
                                                color:
                                                    color,
                                                size: 0.06.sw,
                                              )),
                                        ),
                                      if (logic.seller.value?.social
                                                  ?.linkedin !=
                                              null &&
                                          logic.seller.value?.social
                                                  ?.linkedin !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.linkedin}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.linkedin,
                                              color:
                                                 color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.social
                                                  ?.linkedin !=
                                              null &&
                                          logic.seller.value?.social
                                                  ?.linkedin !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.linkedin}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.tiktok,
                                              color:
                                                  color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.phone != null &&
                                          logic.seller.value?.phone != '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "https://wa.me/${logic.seller.value?.phone}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.whatsapp,
                                              color:
                                                  color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.social?.twitter !=
                                              null &&
                                          logic.seller.value?.social?.twitter !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.twitter}");
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
                                  );
                                }),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, 0.02.sh),
                              child: Container(
                                width: 0.85.sw,
                                padding: EdgeInsets.only(top: 0.02.sh),
                                alignment: Alignment.center,
                                child: Transform.translate(
                                  offset: Offset(0.025.sw, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 0.03.sw),
                                        width: 0.9.sw,
                                        height: 0.05.sh,
                                        alignment: Alignment.center,

                                        child: SellerNameComponent(
                                          alignment: MainAxisAlignment.center,
                                          white: false,
                                          color:color,
                                          isVerified:
                                              logic.seller.value?.is_verified ??
                                                  false,
                                          seller:
                                              logic.seller.value,
                                        ),
                                      ),
                                      if ((logic.seller.value?.is_verified ==
                                          true))
                                        Container(
                                          height: 0.05.sh,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.01.sh),
                                          child: Text(
                                            "${logic.seller.value?.info}",
                                            style: H4GrayTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      if ((logic.seller.value?.address !=
                                              null &&
                                          logic.seller.value?.address != ''))
                                        Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${logic.seller.value?.address}",
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
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.02.sh),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              child: Column(
                                                children: [
                                                  Obx(() {
                                                    return Text(
                                                      '${logic.seller.value?.followingCount}'
                                                          .toFormatNumberK(),
                                                      style: H0RegularDark.copyWith(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                             color),
                                                      textDirection:
                                                          TextDirection.ltr,
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
                                             onTap: (){

                                             },
                                             child:  Column(
                                               children: [
                                                 Text(
                                                   "${logic.seller.value?.total_views}"
                                                       .toFormatNumberK(),
                                                   style: H0RegularDark.copyWith(
                                                       fontWeight:
                                                       FontWeight.w900,
                                                       color:
                                                       color),
                                                   textDirection:
                                                   TextDirection.ltr,
                                                 ),
                                                 Text(
                                                   "مشاهدات",
                                                   style: H4RegularDark,
                                                 )
                                               ],
                                             ),
                                           ),
                                            InkWell(
                                              child: Column(
                                                children: [
                                                  Obx(() {
                                                    return Text(
                                                      '${logic.seller.value?.followers!.length}'
                                                          .toFormatNumberK(),
                                                      style: H0RegularDark.copyWith(
                                                          fontWeight:
                                                          FontWeight.w900,
                                                          color:
                                                          color),
                                                      textDirection:
                                                      TextDirection.ltr,
                                                    );
                                                  }),
                                                  Text(
                                                    "أتابعه",
                                                    style: H4RegularDark,
                                                  )
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      10.verticalSpace,
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        30.verticalSpace,
                        Transform.translate(
                          offset: Offset(0, -0.02.sh),
                          child: Container(
                            width: 1.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (logic.seller.value?.is_verified != true)
                Positioned(
                  top: 0.25.sh,
                  child: Container(
                    width: 1.sw,
                    height: 0.35.sh,
                    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(logic.seller.value?.is_verified==true)
                            Container(
                              width: 0.1.sw,
                              alignment: Alignment.centerRight,
                              child: Transform.translate(
                                offset: Offset(0, -0.03.sh),
                                child: Obx(() {
                                  return Column(
                                    children: [
                                      if (logic.seller.value?.social
                                                  ?.instagram !=
                                              null &&
                                          logic.seller.value?.social
                                                  ?.instagram !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.instagram}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.instagram,
                                              color:
                                                 color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.social?.face !=
                                              null &&
                                          logic.seller.value?.social?.face !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                              onTap: () {
                                                openUrl(
                                                    url:
                                                        "${logic.seller.value?.social?.face}");
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.facebook,
                                                color:
                                                    color,
                                                size: 0.06.sw,
                                              )),
                                        ),
                                      if (logic.seller.value?.social
                                                  ?.linkedin !=
                                              null &&
                                          logic.seller.value?.social
                                                  ?.linkedin !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.linkedin}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.linkedin,
                                              color:
                                                 color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.social
                                                  ?.linkedin !=
                                              null &&
                                          logic.seller.value?.social
                                                  ?.linkedin !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.linkedin}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.tiktok,
                                              color:
                                                  color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.phone != null &&
                                          logic.seller.value?.phone != '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "https://wa.me/${logic.seller.value?.phone}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.whatsapp,
                                              color:
                                                  color,
                                              size: 0.06.sw,
                                            ),
                                          ),
                                        ),
                                      if (logic.seller.value?.social?.twitter !=
                                              null &&
                                          logic.seller.value?.social?.twitter !=
                                              '')
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sh),
                                          child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.twitter}");
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
                                  );
                                }),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, 0.01.sh),
                              child: Container(
                                width: 0.85.sw,
                                padding: EdgeInsets.only(top: 0.02.sh),
                                alignment: Alignment.center,
                                child: Transform.translate(
                                  offset: Offset(0.025.sw, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(

                                        width: 1.sw,
                                        height: 0.05.sh,
                                        alignment: Alignment.center,

                                        child: SellerNameComponent(
                                          alignment: MainAxisAlignment.center,
                                          white: false,
                                          color: color,
                                          isVerified:
                                              logic.seller.value?.is_verified ??
                                                  false,
                                          seller:
                                             logic.seller.value,
                                        ),
                                      ),
                                      if ((logic.seller.value?.is_verified ==
                                          true))
                                        Container(
                                          height: 0.05.sh,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.01.sh),
                                          child: Text(
                                            "${logic.seller.value?.info}",
                                            style: H4GrayTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      if ((logic.seller.value?.address !=
                                              null &&
                                          logic.seller.value?.address != ''))
                                        Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${logic.seller.value?.address}",
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
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.02.sh),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (logic.seller.value?.id ==
                                                    mainController
                                                        .authUser.value?.id) {}
                                              },
                                              child: Column(
                                                children: [
                                                  Obx(() {
                                                    return Text(
                                                      '${logic.seller.value?.followingCount}'
                                                          .toFormatNumberK(),
                                                      style: H0RegularDark.copyWith(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              color),
                                                      textDirection:
                                                          TextDirection.ltr,
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
                                                  "${logic.seller.value?.total_views}"
                                                      .toFormatNumberK(),
                                                  style: H0RegularDark.copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color:
                                                          color),
                                                  textDirection:
                                                      TextDirection.ltr,
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
                                                      '${logic.seller.value?.followers!.length}'
                                                          .toFormatNumberK(),
                                                      style: H0RegularDark.copyWith(
                                                          fontWeight:
                                                          FontWeight.w900,
                                                          color:
                                                          color),
                                                      textDirection:
                                                      TextDirection.ltr,
                                                    );
                                                  }),
                                                  Text(
                                                    "أتابعه",
                                                    style: H4RegularDark,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      10.verticalSpace,
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        Transform.translate(
                          offset: Offset(0, 0.02.sh),
                          child: Container(
                            width: 1.sw,
                            height: 0.04.sh,
                            child: Obx(() {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      logic.categoryId.value = null;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 0.02.sw),
                                      alignment: Alignment.center,
                                      height: 0.02.sh,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0.002.sh,
                                          horizontal: 0.07.sw),
                                      child: Text(
                                        'الكل',
                                        style: H4WhiteTextStyle,
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                          logic.seller.value?.is_verified==true ? logic.seller.value?.id_color!.toColor():RedColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                    ),
                                  ),

                                  ...List.generate(
                                      logic.categories.length,
                                      (index) => InkWell(
                                            onTap: () {
                                              logic.categoryId.value =
                                                  logic.categories[index].id;
                                            },
                                            child: Container(
                                              width: 0.25.sw,
                                              margin: EdgeInsets.only(
                                                  right: 0.02.sw),
                                              alignment: Alignment.center,
                                              height: 0.02.sh,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.002.sh,
                                                  horizontal: 0.02.sw),
                                              child: Text(
                                                '${logic.categories[index].name}',
                                                style: H4WhiteTextStyle,
                                              ),
                                              decoration: BoxDecoration(
                                                  color:color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r)),
                                            ),
                                          ))
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                top: 0.51.sh,
                child: Container(
                  width: 1.sw,
                  height: 0.43.sh,
                  child: Obx(() {
                    return ListView(
                      padding: EdgeInsets.only(
                          bottom: 0.18.sh, left: 0.02.sw, right: 0.02.sw),
                      children: [
                        ...List.generate(
                          logic.products.length,
                          (index) => Column(
                            children: [
                              if (logic.advices.length > 0 && index % 5 == 0)
                                AdviceComponent(
                                    advice: logic
                                        .advices[index % logic.advices.length]),
                              Obx(() {
                                return MinimizeDetailsProductComponent(
                                  post: logic.products[index],
                                  cartLoading: mainController.cartLoading.value,
                                  TitleColor: color,
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
