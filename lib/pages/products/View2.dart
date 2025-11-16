import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/pages/products/logic.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import '../../helpers/style.dart';
import '../../models/product_model.dart';
import '../../routes/routes_url.dart';

class ProductsPage2 extends StatelessWidget {
  final ProductsLogic controller = Get.find<ProductsLogic>();
  final MainController mainController = Get.find<MainController>();
  RxBool followLoading = RxBool(false);
  Rx<Color> color = Rx<Color>(Colors.red);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Obx(() => Visibility(
            visible: mainController.carts.isNotEmpty,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(CART_SELLER);
                  },
                  child: Container(
                    padding: EdgeInsets.all(0.02.sw),
                    decoration: BoxDecoration(
                      color: PrimaryColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FontAwesomeIcons.cartShopping,
                      color: WhiteColor,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Badge.count(
                    count: mainController.carts.length,
                    backgroundColor: PrimaryColor,
                  ),
                )
              ],
            ),
          )),
      body: Obx(() {
        color.value =
            controller.seller.value?.id_color?.toColor() ?? Colors.red;
        if (controller.loading.value == true) {
          return Container(
            child: Center(
              child: ProgressLoading(),
            ),
          );
        }
        return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent * 0.80 &&
                  !controller.loadingProducts.value &&
                  controller.hasMorePage.value) {
                controller.nextPage();
              }
              return true;
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 373,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Container(
                              padding: EdgeInsets.only(
                                  top: 0.04.sh,
                                  right: 0.02.sw,
                                  bottom: 0.02.sh),
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: controller.seller.value
                                                    ?.is_verified ==
                                                true
                                            ? [
                                                InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .seller
                                                            .value
                                                            ?.social
                                                            ?.instagram
                                                        ?.startsWith("https://") ==
                                                        true) {
                                                      openUrl(
                                                          url:
                                                              "${controller.seller.value?.social?.instagram}");
                                                    }
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.instagram,
                                                    color: controller
                                                                .seller
                                                                .value
                                                                ?.social
                                                                ?.instagram
                                                        ?.startsWith("https://") ==
                                                        true
                                                        ? color.value
                                                        : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.02.sh,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .seller
                                                            .value
                                                            ?.social
                                                            ?.face
                                                        ?.startsWith("https://") ==
                                                        true) {
                                                      openUrl(
                                                          url:
                                                              "${controller.seller.value?.social?.face}");
                                                    }
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.facebook,
                                                    color: controller
                                                                .seller
                                                                .value
                                                                ?.social
                                                                ?.face
                                                        ?.startsWith("https://") ==
                                                        true
                                                        ? color.value
                                                        : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.02.sh,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .seller
                                                            .value
                                                            ?.social
                                                            ?.linkedin
                                                        ?.startsWith("https://") ==
                                                        true) {
                                                      openUrl(
                                                          url:
                                                              "${controller.seller.value?.social?.linkedin}");
                                                    }
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.linkedin,
                                                    color: controller
                                                                .seller
                                                                .value
                                                                ?.social
                                                                ?.linkedin
                                                        ?.startsWith("https://") ==
                                                        true
                                                        ? color.value
                                                        : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.02.sh,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .seller
                                                            .value
                                                            ?.social
                                                            ?.tiktok
                                                        ?.startsWith("https://") ==
                                                        true) {
                                                      openUrl(
                                                          url:
                                                              "${controller.seller.value?.social?.tiktok}");
                                                    }
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.tiktok,
                                                    color: controller
                                                                .seller
                                                                .value
                                                                ?.social
                                                                ?.tiktok
                                                        ?.startsWith("https://") ==
                                                        true
                                                        ? color.value
                                                        : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.02.sh,
                                                ),
                                                InkWell(
                                                  onTap: () {

                                                    if (controller
                                                            .seller
                                                            .value

                                                            ?.full_phone
                                                            ?.length !=
                                                        0) {
                                                      openUrl(
                                                          url:
                                                              "https://wa.me/${controller.seller.value?.full_phone}");
                                                    }
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.whatsapp,
                                                    color: controller
                                                                .seller
                                                                .value

                                                                ?.full_phone
                                                                ?.length !=
                                                            0
                                                        ? color.value
                                                        : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.02.sh,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .seller
                                                            .value
                                                            ?.social
                                                            ?.twitter
                                                        ?.startsWith("https://") ==
                                                        true) {
                                                      openUrl(
                                                          url:
                                                              "${controller.seller.value?.social?.twitter}");
                                                    }
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.xTwitter,
                                                    color: controller
                                                                .seller
                                                                .value
                                                                ?.social
                                                                ?.twitter
                                                        ?.startsWith("https://") ==
                                                        true
                                                        ? color.value
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      Expanded(
                                        child: Transform.translate(
                                          offset: controller.seller.value
                                                      ?.is_verified ==
                                                  true
                                              ? Offset(0.04.sw, 0)
                                              : Offset(0, 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.all(0.01.sw),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        color.value,
                                                        color.value
                                                            .withOpacity(0.7),
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    )),
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          "${controller.seller.value?.image}"),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.03.sw),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                          "${controller.seller.value?.seller_name ?? controller.seller.value?.name}",
                                                          maxLines: 1,
                                                          style:
                                                              H2BlackTextStyle
                                                                  .copyWith(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: color.value,
                                                          )),
                                                    ),
                                                    if (controller.seller.value
                                                            ?.is_verified ==
                                                        true)
                                                      Icon(
                                                        Icons.verified,
                                                        color: Colors.blue,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              if (controller.seller.value?.info
                                                      ?.length !=
                                                  0)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0.03.sw),
                                                  child: Text(
                                                    "${controller.seller.value?.info}",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.03.sw),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .locationDot,
                                                      size: 30.r,
                                                      color: color.value,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                          maxLines: 1,
                                                          "${controller.seller.value?.address}",
                                                          style: TextStyle(
                                                              color:
                                                                  color.value,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Obx(() {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    if ((mainController
                                                                .authUser
                                                                .value
                                                                ?.followers!
                                                                .indexWhere((el) =>
                                                                    el.seller?.id !=
                                                                        null &&
                                                                    el.seller?.id ==
                                                                        controller
                                                                            .seller
                                                                            .value
                                                                            ?.id) !=
                                                            -1) ||
                                                        followLoading.value ==
                                                            true)
                                                      PopupMenuButton(
                                                        child: Container(
                                                         padding: EdgeInsets.symmetric(vertical: 0.007.sh,horizontal: 0.06.sw),
                                                          child: Text('أتابعه',style: H2WhiteTextStyle.copyWith(fontWeight: FontWeight.w100),),
                                                          decoration: BoxDecoration(
                                                            color: PrimaryColor,
                                                            borderRadius: BorderRadius.circular(20.r),
                                                          ),
                                                        ),
                                                          color: color.value,
                                                          style: ButtonStyle(
                                                              iconColor: MaterialStateProperty.all(
                                                                  Colors.white),
                                                              side:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                BorderSide(),
                                                              ),
                                                              shape:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  side:
                                                                      BorderSide(
                                                                    color: color
                                                                        .value,
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  MaterialStateProperty.all(PrimaryColor)),
                                                          onSelected: (value) async {
                                                            if (value ==
                                                                'unfollow') {
                                                              await mainController.unFollowers(

                                                                      controller
                                                                          .seller
                                                                          .value!
                                                                          .id!);
                                                            }
                                                          },
                                                          itemBuilder: (context) {
                                                            return [
                                                              PopupMenuItem(
                                                                value:
                                                                    'unfollow',
                                                                child: Text(
                                                                    "إلغاء المتابعة",style: H2WhiteTextStyle,),
                                                                onTap:
                                                                    () async {},
                                                              )
                                                            ];
                                                          })
                                                    else
                                                      MaterialButton(
                                                          elevation: 0,
                                                          color: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadiusGeometry
                                                                    .circular(
                                                              20.r,
                                                            ),
                                                            side: BorderSide(
                                                              color:
                                                                  color.value,
                                                              width: 1.r,
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            followLoading
                                                                .value = true;
                                                            await mainController.follow(
                                                                sellerId:
                                                                    controller
                                                                        .seller
                                                                        .value!
                                                                        .id!);
                                                            followLoading
                                                                .value = false;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "متابعة",
                                                                style: TextStyle(
                                                                    color: color
                                                                        .value),
                                                              ),
                                                              SizedBox(
                                                                width: 0.01.sw,
                                                              ),
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .solidHeart,
                                                                color:
                                                                    color.value,
                                                                size: 40.r,
                                                              ),
                                                            ],
                                                          )),
                                                    const SizedBox(width: 8),
                                                    MaterialButton(
                                                        color: color.value,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadiusGeometry
                                                                    .circular(
                                                                        20.r)),
                                                        onPressed: () {
                                                          Share.share(
                                                              'https://web.ali-pasha.com/profile?id=${controller.seller.value?.id}');
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              "مشاركة",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                              width: 0.01.sw,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .shareNodes,
                                                              color:
                                                                  Colors.white,
                                                              size: 40.r,
                                                            ),
                                                          ],
                                                        )),
                                                    const SizedBox(width: 8),
                                                    MaterialButton(
                                                        color: color.value,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadiusGeometry
                                                                    .circular(
                                                                        20.r)),
                                                        onPressed: () {
                                                          Get.dialog(
                                                            AlertDialog(
                                                              title: Text(
                                                                "أرسل رسالة",
                                                                style:
                                                                    H3RegularDark,
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.r)),
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  SizedBox(
                                                                      width:
                                                                          1.sw,
                                                                      child:
                                                                          MaterialButton(
                                                                        onPressed:
                                                                            () {

                                                                          openUrl(
                                                                              url: "https://wa.me/${controller.seller.value!.full_phone}");
                                                                        },
                                                                        color: Colors
                                                                            .green,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              FontAwesomeIcons.whatsapp,
                                                                              color: Colors.white,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 0.02.sw,
                                                                            ),
                                                                            Text(
                                                                              'واتسأب',
                                                                              style: H4WhiteTextStyle,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                  if (isAuth())
                                                                    SizedBox(
                                                                        width: 1
                                                                            .sw,
                                                                        child:
                                                                            MaterialButton(
                                                                          onPressed:
                                                                              () {
                                                                            mainController.createCommunity(sellerId: controller.seller.value!.id!);
                                                                          },
                                                                          color:
                                                                              PrimaryColor,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                FontAwesomeIcons.comments,
                                                                                color: Colors.white,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 0.02.sw,
                                                                              ),
                                                                              Text(
                                                                                'إذهب إلى المحادثة',
                                                                                style: H4WhiteTextStyle,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                  SizedBox(
                                                                    height:
                                                                        0.03.sh,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          1.sw,
                                                                      child:
                                                                          MaterialButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        color: Colors
                                                                            .grey,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              FontAwesomeIcons.close,
                                                                              color: Colors.white,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 0.02.sw,
                                                                            ),
                                                                            Text(
                                                                              'إغلاق',
                                                                              style: H4WhiteTextStyle,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              "مراسلة",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                              width: 0.01.sw,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .comments,
                                                              color:
                                                                  Colors.white,
                                                              size: 40.r,
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                );
                                              }),
                                              SizedBox(height: 0.009.sh),
                                              Obx(() {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(width: 0.06.sw),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "${controller.seller.value?.total_views ?? 0}"
                                                              .toFormatNumberK(),
                                                          style: H1BlackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: color
                                                                      .value),
                                                        ),
                                                        Text(
                                                          "مشاهدات",
                                                          style: H3BlackTextStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black38),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 0.04.sw),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${controller.seller.value?.followingCount ?? 0}"
                                                                .toFormatNumberK(),
                                                            style: H1BlackTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: color
                                                                        .value),
                                                          ),
                                                          Text(
                                                            "متابعين",
                                                            style: H3BlackTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black38),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 0.04.sw),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${controller.seller.value?.followers?.length ?? 0}"
                                                                .toFormatNumberK(),
                                                            style: H1BlackTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: color
                                                                        .value),
                                                          ),
                                                          Text(
                                                            "أتابعه",
                                                            style: H3BlackTextStyle
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black38),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 0.06.sw),
                                                  ],
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0.0001.sh,
                                    left: 0.01.sw,
                                    child: Container(
                                      width: 0.1.sw,
                                      child: PopupMenuButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.black,
                                          ),
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Share.share(
                                                          'https://web.ali-pasha.com/profile?id=${controller.seller.value?.id}');
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "مشاركة الملف الشخصي",
                                                      style: H3BlackTextStyle,
                                                    ),
                                                  ),
                                                ),
                                                if (isAuth() &&
                                                    mainController.authUser
                                                            .value?.followers
                                                            ?.firstWhereOrNull(
                                                                (el) =>
                                                                    el.seller
                                                                        ?.id ==
                                                                    controller
                                                                        .seller
                                                                        .value!
                                                                        .id!) ==
                                                        null)
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (mainController
                                                                .authUser
                                                                .value
                                                                ?.followers
                                                                ?.firstWhereOrNull((el) =>
                                                                    el.seller
                                                                        ?.id ==
                                                                    controller
                                                                        .seller
                                                                        .value!
                                                                        .id!) ==
                                                            null) {
                                                          followLoading.value =
                                                              true;
                                                          await mainController
                                                              .follow(
                                                                  sellerId:
                                                                      controller
                                                                          .seller
                                                                          .value!
                                                                          .id!);
                                                          followLoading.value =
                                                              false;
                                                        }
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "متابعة المتجر",
                                                        style: H3BlackTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                if (isAuth())
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (controller
                                                                .seller.value !=
                                                            null) {
                                                          mainController
                                                              .createCommunity(
                                                                  sellerId:
                                                                      controller
                                                                          .seller
                                                                          .value!
                                                                          .id!);
                                                        }

                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "رسالة خاصة",
                                                        style: H3BlackTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                if (isAuth())
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                      onTap: () {
                                                        String? msg =
                                                            'إبلاغ عن المتجر : ${controller.seller.value?.seller_name} - تم الإبلاغ عن من قبل المستخدم : ${mainController.authUser.value?.name}';
                                                        if (mainController
                                                                .settings
                                                                .value
                                                                .support
                                                                ?.id !=
                                                            null) {
                                                          mainController.createCommunity(
                                                              sellerId:
                                                                  mainController
                                                                      .settings
                                                                      .value
                                                                      .support!
                                                                      .id!,
                                                              message: msg);
                                                        } else {
                                                          openUrl(
                                                              url:
                                                                  "https://wa.me/${mainController.settings.value.social?.phone}?text=${Uri.encodeComponent(msg)}");
                                                        }
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        "إبلاغ عن الملف الشخصي",
                                                        style: H3BlackTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                              ]),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(80),
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 0.1),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.04.sw, vertical: 0.01.sh),
                        child: Row(
                          children: [
                            Obx(() {
                              return Container(
                                width: 0.4.sw,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: color.value,
                                ),
                                child: DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  elevation: 0,
                                  menuMaxHeight: 0.4.sh,
                                  value: controller.categoryId.value,
                                  borderRadius: BorderRadius.circular(20.r),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.01.sw),
                                  dropdownColor: color.value,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  items: [
                                    ...List.generate(
                                        controller.categories.length, (index) {
                                      return DropdownMenuItem(
                                        value: controller.categories[index].id,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "${controller.categories[index].name}",
                                            maxLines: 1,
                                            style: H3WhiteTextStyle.copyWith(
                                                fontWeight: FontWeight.w900,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                  onChanged: (value) {
                                    controller.categoryId.value = value!;
                                  },
                                ),
                              );
                            }),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SizedBox(
                                height: 0.055.sh,
                                child: TextField(
                                  controller: controller.searchController,
                                  onEditingComplete: () {
                                    controller.search.value =
                                        controller.searchController.text;
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: "ابحث عن منتج محدد",
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.search,
                                      color: color.value,
                                      size: 50.r,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: color.value),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: color.value),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: color.value),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Obx(
                () {
                  if (controller.products.length > 0 &&
                      controller.loading.value == false) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.04.sw, vertical: 0.01.sh),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // عدد الأعمدة
                          crossAxisSpacing: 0.03.sw,
                          mainAxisSpacing: 0.03.sh,
                          childAspectRatio: 0.5, // للتحكم في طول/عرض البطاقة
                        ),
                        children: [
                          ...List.generate(
                              controller.products.length,
                              (i) =>
                                  _ProductCard(product: controller.products[i]))
                        ],
                      ),
                    );
                  } else if (controller.loading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Text("لا يوجد منتجات"),
                    );
                  }
                },
              ),
            ));
      }),
    );
  }

  Widget _buildWidget(
      {String? title, String? count, String? symbol, Function()? onTab}) {
    Color? color = controller.seller.value?.is_verified == true
        ? controller.seller.value?.id_color!.toColor()
        : DarkColor;
    return InkWell(
      onTap: onTab,
      child: Container(
        width: 0.3.sw,
        height: 0.2.sw,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: DarkColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "$count",
                    style: H2RedTextStyle.copyWith(color: color)),
                if (symbol != null)
                  TextSpan(
                      text: " $symbol ",
                      style: H2RedTextStyle.copyWith(color: color)),
              ]),
            ),
            Text(
              "$title",
              style: H3BlackTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  _ProductCard({required ProductModel product}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF6F3F3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(PRODUCT_PAGE, arguments: product.id);
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: 1.sw,
                    height: 0.45.sw, // نفس العرض = الطول
                    child: Image.network(
                      "${product.image}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.visibility, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "${product.views_count}".toFormatNumberK(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (product.active != 'active')
                    Positioned(
                      bottom: 0,
                      child: Align(
                        alignment: AlignmentGeometry.center,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
                          alignment: Alignment.center,
                          width: 0.4.sw,
                          height: 0.04.sh,
                          child: Text(
                            "${product.active}".active2ArabicProduct(),
                            style: H3WhiteTextStyle,
                          ),
                          decoration: BoxDecoration(
                            color: "${product.active}"
                                .active2ColoProduct()
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.grey,
                      size: 30.r,
                    ),
                    Text(
                      " ${product.created_at}",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.grey,
                      size: 30.r,
                    ),
                    Text(
                      "${product.city?.name}",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                Get.offNamed(PRODUCT_PAGE, arguments: product.id);
              },
              child: Text(
                "${product.name}",
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "${product.expert}",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                Get.offNamed(PRODUCTS_PAGE,
                    parameters: {"id": "${product.user?.id}"});
              },
              child: Row(
                children: [
                  if (product.user?.is_verified == true) SizedBox(width: 4),
                  Expanded(
                    child: AutoSizeText(
                      "${product.user?.seller_name}",
                      maxLines: 1,
                      style: H4RedTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  if (product.user?.is_verified == true)
                    Icon(Icons.verified, color: Colors.blue, size: 16),
                ],
              ),
            ),
          ),

          const Spacer(),

          // السعر وزر الإضافة
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 0.1.sw,
                  height: 0.1.sw,
                  decoration: BoxDecoration(
                    color: color.value,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      switch (product.type) {
                        case "product":
                          mainController.addToCart(product: product);

                      }
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                ),
                2.horizontalSpace,
                if (product.is_discount == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          AutoSizeText(
                            "${product.price}\$",
                            style: H7GrayOpacityTextStyle,
                          ),
                          Positioned(
                            top: 0.02.sw,
                            height: 0.005.sw,
                            width: 0.11.sw,
                            child: Transform.rotate(
                              angle: -0.3, // زاوية الميلان (بالتقدير الرادياني)
                              child: Container(
                                height: 0.07.sw,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      15.horizontalSpace,
                      AutoSizeText(
                        "${product.discount} \$",
                        softWrap: false,
                        style: H5BlackTextStyle.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                const SizedBox(width: 8),
                if (product.is_discount != true)
                  AutoSizeText(
                    "\$ ${product.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
