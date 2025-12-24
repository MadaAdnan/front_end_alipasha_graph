import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/ProductSectionComponent.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/progress_loading.dart';
import '../../helpers/helper_class.dart';
import '../../helpers/style.dart';
import '../../models/advice_model.dart';
import '../../models/product_model.dart';
import '../../models/slider_model.dart';
import '../../routes/routes_url.dart';

class ProfilePage2 extends StatelessWidget {
  final ProfileLogic controller = Get.find<ProfileLogic>();
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    Color color =
        mainController.authUser.value?.id_color?.toColor() ?? Colors.red;
    return Scaffold(
      backgroundColor: Colors.white,

      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !controller.loadingProduct.value &&
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
                      Container(
                        padding: EdgeInsets.only(
                            top: 0.04.sh, right: 0.02.sw, bottom: 0.02.sh),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: mainController
                                      .authUser.value?.is_verified ==
                                      true
                                      ? [
                                    InkWell(
                                      onTap: () {
                                        if (mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.instagram
                                            ?.startsWith("https://") ==
                                            true) {
                                          openUrl(
                                              url:
                                              "${mainController.authUser.value
                                                  ?.social?.instagram}");
                                        }
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.instagram,
                                        color: mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.instagram
                                            ?.isURL ==
                                            true
                                            ? color
                                            : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.02.sh,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (mainController.authUser.value
                                            ?.social?.face?.startsWith(
                                            "https://") ==
                                            true) {
                                          openUrl(
                                              url:
                                              "${mainController.authUser.value
                                                  ?.social?.face}");
                                        }
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.facebook,
                                        color: mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.face
                                            ?.startsWith("https://") ==
                                            true
                                            ? color
                                            : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.02.sh,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.linkedin
                                            ?.startsWith("https://") ==
                                            true) {
                                          openUrl(
                                              url:
                                              "${mainController.authUser.value
                                                  ?.social?.linkedin}");
                                        }
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.linkedin,
                                        color: mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.linkedin
                                            ?.startsWith("https://") ==
                                            true
                                            ? color
                                            : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.02.sh,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (mainController.authUser.value
                                            ?.social?.tiktok?.startsWith(
                                            "https://") ==
                                            true) {
                                          openUrl(
                                              url:
                                              "${mainController.authUser.value
                                                  ?.social?.tiktok}");
                                        }
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.tiktok,
                                        color: mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.tiktok
                                            ?.startsWith("https://") ==
                                            true
                                            ? color
                                            : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.02.sh,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (mainController.authUser.value
                                            ?.full_phone?.length !=
                                            0) {
                                          openUrl(
                                              url:
                                              "https://wa.me/${mainController
                                                  .authUser.value
                                                  ?.full_phone}");
                                        }
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: mainController
                                            .authUser
                                            .value

                                            ?.full_phone
                                            ?.length !=
                                            0
                                            ? color
                                            : Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.02.sh,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.twitter
                                            ?.startsWith("https://") ==
                                            true) {
                                          openUrl(
                                              url:
                                              "${mainController.authUser.value
                                                  ?.social?.twitter}");
                                        }
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.xTwitter,
                                        color: mainController
                                            .authUser
                                            .value
                                            ?.social
                                            ?.twitter
                                            ?.startsWith("https://") ==
                                            true
                                            ? color
                                            : Colors.grey,
                                      ),
                                    ),
                                  ]
                                      : [],
                                ),
                                Expanded(
                                  child: Transform.translate(
                                    offset: mainController
                                        .authUser.value?.is_verified ==
                                        true
                                        ? Offset(0.04.sw, 0)
                                        : Offset(0, 0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                  Edit_PROFILE_PAGE);
                                            },
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: Alignment.center,
                                              children: [
                                                // الدائرة الخلفية مع التدرج
                                                Container(
                                                  width: 85,
                                                  height: 85,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        color,
                                                        color.withOpacity(0.7),
                                                      ],
                                                      begin: Alignment
                                                          .topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: CachedNetworkImageProvider(
                                                    "${mainController.authUser
                                                        .value?.image}",
                                                  ),
                                                ),


                                                // أيقونة القلم على يمين الصورة
                                                Positioned(
                                                  right: -13,
                                                  bottom: 3,
                                                  // على اليمين تمامًا
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    alignment: Alignment
                                                        .center,
                                                    margin: EdgeInsets.only(
                                                        right: 5),
                                                    // إبعاد بسيط عن الحافة إن رغبت
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: color,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      FontAwesomeIcons.pen,
                                                      size: 20,
                                                      // حجم مناسب داخل دائرة 35
                                                      color: color,
                                                    ),
                                                  )
                                                ),
                                              ],
                                            )),
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
                                                    "${mainController.authUser
                                                        .value?.seller_name ??
                                                        mainController.authUser
                                                            .value?.name}",
                                                    maxLines: 1,
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                      fontWeight:
                                                      FontWeight.w900,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      color: color,
                                                    )),
                                              ),
                                              if (mainController.authUser.value
                                                  ?.is_verified ==
                                                  true)
                                                Icon(
                                                  Icons.verified,
                                                  color: Colors.blue,
                                                ),
                                            ],
                                          ),
                                        ),
                                        if (mainController
                                            .authUser.value?.info?.length !=
                                            0)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.03.sw),
                                            child: Text(
                                              "${mainController.authUser.value
                                                  ?.info}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                overflow: TextOverflow.ellipsis,
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
                                                FontAwesomeIcons.locationDot,
                                                size: 30.r,
                                                color: color,
                                              ),
                                              Center(
                                                child: AutoSizeText(
                                                    "${mainController.authUser
                                                        .value?.address}",
                                                    style: TextStyle(
                                                        color: color,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            MaterialButton(
                                                color: color,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadiusGeometry
                                                        .circular(20.r)),
                                                onPressed: () {
                                                  Share.share(
                                                      'https://web.ali-pasha.com/profile?id=${mainController
                                                          .authUser.value
                                                          ?.id}');
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "مشاركة",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      width: 0.01.sw,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .shareNodes,
                                                      color: Colors.white,
                                                      size: 40.r,
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(width: 8),
                                            mainController.authUser.value
                                                ?.is_verified !=
                                                true
                                                ? MaterialButton(
                                                color: color,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadiusGeometry
                                                        .circular(
                                                        20.r)),
                                                onPressed: () {
                                                  Get.toNamed( CHOOSE_VERIFICATION_PAGE);
                                                  return;
                                                  HelperClass
                                                      .requestVerified(
                                                      onConfirm: () {
                                                        if (isAuth()) {

                                                          String message =
                                                              "ID:${mainController
                                                              .authUser.value
                                                              ?.id} - اسم المتجر : ${mainController
                                                              .authUser.value
                                                              ?.seller_name} - نوع الطلب توثيق الحساب";
                                                          openUrl(
                                                              url:
                                                              "https://wa.me/${mainController
                                                                  .settings
                                                                  .value.social
                                                                  ?.phone}?text=${Uri
                                                                  .encodeComponent(
                                                                  '${message!
                                                                      .toString()}')}");
                                                        }
                                                      });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    const Text(
                                                      "توثيق الحساب",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.white),
                                                    ),
                                                    SizedBox(
                                                      width: 0.01.sw,
                                                    ),
                                                    Icon(
                                                      Icons.verified,
                                                      color: Colors.white,
                                                      size: 40.r,
                                                    ),
                                                  ],
                                                ))
                                                : MaterialButton(
                                                color: color,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadiusGeometry
                                                        .circular(
                                                        20.r)),
                                                onPressed: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    const Text(
                                                      "حسابك موثق",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.white),
                                                    ),
                                                    SizedBox(
                                                      width: 0.01.sw,
                                                    ),
                                                    Icon(
                                                      Icons.verified,
                                                      color: Colors.white,
                                                      size: 40.r,
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 0.009.sh),
                                        Obx(() {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 0.009.sh),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(width: 0.06.sw),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${mainController.authUser
                                                          .value?.total_views ??
                                                          0}"
                                                          .toFormatNumberK(),
                                                      style: H1BlackTextStyle
                                                          .copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                          color: color),
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
                                                  onTap: () {
                                                    Get.toNamed(FOLLOWING_PAGE);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${mainController
                                                            .authUser.value
                                                            ?.followingCount ??
                                                            0}"
                                                            .toFormatNumberK(),
                                                        style: H1BlackTextStyle
                                                            .copyWith(
                                                            fontWeight:
                                                            FontWeight
                                                                .w900,
                                                            color: color),
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
                                                  onTap: () {
                                                    Get.toNamed(FOLLOWERS_PAGE);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${mainController
                                                            .authUser.value
                                                            ?.followers
                                                            ?.length ?? 0}"
                                                            .toFormatNumberK(),
                                                        style: H1BlackTextStyle
                                                            .copyWith(
                                                            fontWeight:
                                                            FontWeight
                                                                .w900,
                                                            color: color),
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
                                            ),
                                          );
                                        }),
                                        SizedBox(height: 0.009.sh),
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
                                    onSelected: (value) {
                                      switch (value) {
                                        case 'profile':
                                          Get.toNamed(Edit_PROFILE_PAGE);
                                          break;
                                        case 'new-post':
                                          Get.toNamed(CREATE_PRODUCT_PAGE);
                                          break;
                                        case 'shipping':
                                          Get.toNamed(MY_ORDER_SHIPPING_PAGE);
                                          break;
                                        case 'plan':
                                          Get.toNamed(PLAN_PAGE);
                                          break;
                                        case 'invoice':
                                          Get.toNamed(INVOICE_PAGE);
                                          break;
                                        case 'advice':
                                          Get.toNamed(MY_ADVICE_PAGE);
                                          break;
                                        case 'statistics':
                                          Get.dialog(
                                            AlertDialog(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadiusGeometry
                                                      .circular(20.r)),
                                              title: Center(
                                                  child: Text(
                                                    "الإحصائيات",
                                                    style: H2BlackTextStyle,
                                                  )),
                                              content: Container(
                                                color: Colors.white,
                                                width: 0.7.sw,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      20.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          _buildWidget(
                                                              title:
                                                              'رصيد النقاط',
                                                              count:
                                                              "${controller
                                                                  .myPoint
                                                                  .value}"),
                                                          _buildWidget(
                                                              onTab: () {
                                                                Get.toNamed(
                                                                    BALANCES_PAGE);
                                                              },
                                                              title:
                                                              'الرصيد الحالي',
                                                              count:
                                                              "${controller
                                                                  .myBalance}",
                                                              symbol: '\$'),
                                                        ],
                                                      ),
                                                      20.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          _buildWidget(
                                                              title:
                                                              'عدد الإعلانات',
                                                              count:
                                                              "${controller
                                                                  .adviceCount}"),
                                                          _buildWidget(
                                                              title:
                                                              'الشريط الإعلاني',
                                                              count:
                                                              "${controller
                                                                  .sliderCount}"),
                                                        ],
                                                      ),
                                                      20.verticalSpace,
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          _buildWidget(
                                                              title:
                                                              'المشاهدات',
                                                              count: "${controller
                                                                  .views}"
                                                                  .toFormatNumberK()),
                                                          _buildWidget(
                                                              title:
                                                              'مسحوبات الأرباح',
                                                              count:
                                                              "${controller
                                                                  .myWins}"),
                                                        ],
                                                      ),
                                                      20.verticalSpace,
                                                      MaterialButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadiusGeometry
                                                                .circular(
                                                                30.r)),
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "إغلاق",
                                                          style:
                                                          H3WhiteTextStyle,
                                                        ),
                                                        color: PrimaryColor,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                          break;
                                      }
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                    ),
                                    itemBuilder: (context) =>
                                    [
                                      PopupMenuItem(
                                        value: 'profile',
                                        child: Text(
                                          "تعديل الملف الشخصي",
                                          style: H3BlackTextStyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'new-post',
                                        child: Text(
                                          "نشر جديد",
                                          style: H3BlackTextStyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'shipping',
                                        child: Text(
                                          "طلب خدمة شحن",
                                          style: H3BlackTextStyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'plan',
                                        child: Text(
                                          "ترقية الحساب",
                                          style: H3BlackTextStyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'invoice',
                                        child: Text(
                                          "مبيعاتي",
                                          style: H3BlackTextStyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'statistics',
                                        child: Text(
                                          "الإحصائيات",
                                          style: H3BlackTextStyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'advice',
                                        child: Text(
                                          "إعلانات ممولة",
                                          style: H3BlackTextStyle,
                                        ),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
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
                              color: color,
                            ),
                            child: DropdownButton(
                              elevation: 0,
                              underline: SizedBox(),
                              isExpanded: true,
                              menuMaxHeight: 0.4.sh,
                              value: controller.categoryId.value,
                              borderRadius: BorderRadius.circular(20.r),
                              padding:
                              EdgeInsets.symmetric(horizontal: 0.01.sw),
                              dropdownColor: color,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              items: [
                                ...List.generate(controller.categories.length,
                                        (index) {
                                      return DropdownMenuItem(
                                        value: controller.categories[index].id,
                                        child: Text(
                                          "${controller.categories[index]
                                              .name}",
                                          maxLines: 1,
                                          style: H3WhiteTextStyle.copyWith(
                                              fontWeight: FontWeight.w900,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      );
                                    })
                              ],
                              onChanged: (value) {
                                controller.categoryId.value = value!;
                                FocusScope.of(context).unfocus();
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
                              },
                              decoration: InputDecoration(
                                hintText: "ابحث عن منتج محدد",
                                prefixIcon: Icon(
                                  FontAwesomeIcons.search,
                                  color: color,
                                  size: 50.r,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: color),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: color),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: color),
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
                      ...List.generate(controller.products.length,
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
                return InkWell(
                  onTap: () {
                    Get.toNamed(CREATE_PRODUCT_PAGE);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('أضف منتجك الأول من هنا',
                        style: H3WhiteTextStyle.copyWith(fontSize: 50.sp,
                            fontWeight: FontWeight.w900,
                            color: color),),
                      Text('+', style: H3WhiteTextStyle.copyWith(fontSize: 200
                          .sp, fontWeight: FontWeight.w900, color: color),)
                    ],

                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWidget(
      {String? title, String? count, String? symbol, Function()? onTab}) {
    Color? color = mainController.authUser.value?.is_verified == true
        ? mainController.authUser.value?.id_color!.toColor()
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
            child: Text(
              "${product.name}",
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
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
                      "${product.user?.seller_name ?? product.user?.name}",
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
                    color: Colors.red,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      switch (product.type) {
                        case "product":
                          Get.toNamed(Edit_PRODUCT_PAGE, arguments: product.id);
                          break;
                        case "job":
                        case "search_job":
                          Get.toNamed(Edit_JOB_PAGE, arguments: product.id);
                          break;
                        case "tender":
                          Get.toNamed(Edit_TENDER_PAGE, arguments: product.id);
                          break;
                        case "service":
                          Get.toNamed(Edit_SERVICE_PAGE, arguments: product.id);
                          break;
                      }
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
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
