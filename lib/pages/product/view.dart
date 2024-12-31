import 'dart:ui';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:get/get.dart';

import '../../helpers/components.dart';
import 'logic.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);

  final logic = Get.find<ProductLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController controller = ScrollController();
  RxBool loadingFollow = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 0.07.sh),
        child: Obx(() {
          return Container(
            padding:
                EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.005.sh),
            width: 1.sw,
            height: 0.06.sh,
            decoration: const BoxDecoration(color: WhiteColor, boxShadow: [
              BoxShadow(
                color: Colors.black,
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(PRODUCTS_PAGE,
                        arguments: logic.product.value?.user);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 0.05.sh,
                        height: 0.05.sh,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "${logic.product.value?.user?.image}"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'منشور بواسطة :',
                                style: H4RegularDark,
                              ),
                              Icon(
                                FontAwesomeIcons.locationDot,
                                size: 0.02.sh,
                                color: GrayLightColor,
                              ),
                              Text(
                                "${logic.product.value?.city ?? ''}",
                                style: H4RegularDark,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.02.sw,
                          ),
                          Row(
                            children: [
                              Text(
                                "${logic.product.value?.user?.seller_name ?? ''}",
                                style: H4BlackTextStyle.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              if ((logic.product.value?.user?.is_verified ==
                                  true))
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                    "assets/images/svg/verified.svg",
                                    size: Size(0.01.sw, 0.01.sw),
                                  ))),
                                ),
                            ],
                          )
                          //Text('${logic.product.value?.user?.seller_name}')
                        ],
                      )
                    ],
                  ),
                ),
                if (isAuth())
                  Row(
                    children: [
                      Obx(() {
                        int index = mainController.authUser.value!.followers!
                            .indexWhere((el) =>
                                el.seller?.id == logic.product.value?.user?.id);
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.01.sh, horizontal: 0.04.sw),
                          decoration: BoxDecoration(
                            color: index > -1 ? RedColor : null,
                            border: Border.all(color: RedColor),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: InkWell(
                            onTap: () async {
                              loadingFollow.value = true;
                              if (logic.product.value?.user?.id != null &&
                                  isAuth() &&
                                  index == -1) {
                                await mainController.follow(
                                    sellerId: logic.product.value!.user!.id!);
                              }
                              loadingFollow.value = false;
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: loadingFollow.value
                                          ? AnimateIcon(
                                              key: UniqueKey(),
                                              onTap: () {},
                                              iconType:
                                                  IconType.continueAnimation,
                                              height: 0.03.sw,
                                              width: 0.03.sw,
                                              color: index > -1
                                                  ? WhiteColor
                                                  : RedColor,
                                              animateIcon: AnimateIcons.bell,
                                            )
                                          : Icon(
                                              FontAwesomeIcons.bell,
                                              color: index > -1
                                                  ? WhiteColor
                                                  : RedColor,
                                              size: 0.03.sw,
                                            )),
                                  TextSpan(
                                      text: index == -1 ? 'متابعة' : 'أتابعه',
                                      style: H5WhiteTextStyle.copyWith(
                                          color: index > -1
                                              ? WhiteColor
                                              : RedColor)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      PopupMenuButton<String>(
                        color: WhiteColor,
                        iconColor: GrayDarkColor,
                        onSelected: (value) async {
                          switch (value) {
                            case '2':
                              if (mainController.settings.value.support?.id !=
                                  null) {
                                mainController.createCommunity(
                                    sellerId: mainController
                                        .settings.value.support!.id!,
                                    message:
                                        ''' السلام عليكم ورحمة الله وبركاته 
                            إبلاغ  عن المنتج ${logic.product.value?.name} #${logic.product.value?.id}''');
                              } else {
                                openUrl(
                                    url:
                                        "https://wa.me/${mainController.settings.value.social?.phone}");
                              }

                              break;
                            case '1':
                              if (logic.product.value?.user?.id != null &&
                                  !mainController
                                      .createCommunityLodaing.value) {
                                mainController.createCommunity(
                                    sellerId: logic.product.value!.user!.id!,
                                    message:
                                        ''' السلام عليكم ورحمة الله وبركاته 
                            طلب المنتج ${logic.product.value?.name} #${logic.product.value?.id}''');
                              } else {
                                openUrl(
                                    url:
                                        "https://wa.me/${mainController.settings.value.social?.phone}");
                              }

                              break;

                            default:
                              print('default');
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem<String>(
                            value: '1',
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.basketShopping,
                                  color: GrayDarkColor,
                                  size: 0.04.sw,
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Text(
                                  "طلب المنتج",
                                  style: H3RegularDark,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: '2',
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.ban,
                                  color: GrayDarkColor,
                                  size: 0.04.sw,
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Text(
                                  "إبلاغ عن المنتج",
                                  style: H3RegularDark,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ],
            ),
          );
        }),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Obx(() {
        if (logic.product.value?.type == 'product') {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
            width: 1.sw,
            height: 0.07.sh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0.033.sw, 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.01.sh, horizontal: 0.02.sw),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Obx(() {
                      return Row(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(CART_SELLER);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(0.02.sw),
                                  decoration: const BoxDecoration(
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
                                  backgroundColor: RedColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 0.03.sw,
                          ),
                          InkWell(
                            onTap: () {
                              mainController.addToCart(
                                  product: logic.product.value!);
                            },
                            child: Container(
                              width: 0.35.sw,
                              height: 0.06.sh,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'إضافة إلى السلة',
                                    style: H3WhiteTextStyle,
                                  ),
                                  SizedBox(
                                    width: 0.02.sw,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.cartShopping,
                                    color: WhiteColor,
                                    size: 0.04.sw,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.03.sw,
                          ),
                          InkWell(
                            onTap: () {
                              if (logic.product.value?.user?.id != null &&
                                  !mainController
                                      .createCommunityLodaing.value) {
                                mainController.createCommunity(
                                    sellerId: logic.product.value!.user!.id!,
                                    message:
                                        """ المنتج ${logic.product.value!.name}   \n   معرف المنتج: ${logic.product.value!.id} """);
                              }
                            },
                            child: Container(
                              width: 0.35.sw,
                              height: 0.06.sh,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'مراسلة التاجر',
                                    style: H3WhiteTextStyle,
                                  ),
                                  SizedBox(
                                    width: 0.02.sw,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.comments,
                                    color: WhiteColor,
                                    size: 0.04.sw,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      }),
      backgroundColor: WhiteColor,
      body: Obx(
        () {
          if (logic.loading.value) {
            return Container(
              child: Center(
                child: ProgressLoading(
                  width: 0.3.sw,
                  height: 0.3.sw,
                ),
              ),
            );
          }
          List<String>? images =
              logic.product.value?.images.map((el) => "$el").toList();
          if (images?.length == 0 && logic.product.value?.user?.logo != null) {
            images?.add("${logic.product.value?.user?.logo}");
          }

          return ListView(
            children: [
              Container(
                child: FlutterCarousel(
                  items: [
                    if (logic.product.value?.video != '')
                      InkWell(
                        onTap: () {
                          Get.toNamed(VIDEO_PLAYER_POST_PAGE,
                              arguments: logic.product.value?.video);
                        },
                        child: Container(
                          width: 0.79.sw,
                          height: 0.79.sw,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Container(
                            child: Icon(
                              FontAwesomeIcons.play,
                              color: RedColor,
                              size: 0.2.sw,
                            ),
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: '${logic.product.value?.image}',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          child: Image(
                                            image: imageProvider,
                                          ),
                                        )),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    icon: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: WhiteColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: DarkColor,
                                                blurRadius: 0.02.sw)
                                          ]),
                                      child: const Icon(Icons.close,
                                          color: RedColor, size: 30),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    color: Colors.black.withOpacity(0.7),
                                    child: Text(
                                      'Image', // وصف الصورة
                                      style: H4BlackTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 0.79.sw,
                        height: 0.79.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "${logic.product.value?.image}"),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    ...List.generate(
                      logic.product.value?.images.length ?? 0,
                      (index) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                      imageUrl:
                                          '${logic.product.value?.images[index]}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            child: Image(
                                              image: imageProvider,
                                            ),
                                          )),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: WhiteColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: DarkColor,
                                                  blurRadius: 0.02.sw)
                                            ]),
                                        child: const Icon(Icons.close,
                                            color: RedColor, size: 30),
                                      ),
                                      onPressed: () => Get.back(),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      color: Colors.black.withOpacity(0.7),
                                      child: Text(
                                        'Image', // وصف الصورة
                                        style: H4BlackTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 0.79.sw,
                          height: 0.79.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "${logic.product.value?.images[index]}"),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    )
                  ],
                  options: FlutterCarouselOptions(
                      height: 0.79.sw,
                      initialPage: 0,
                      autoPlay: true,
                      aspectRatio: 1 / 1,
                      floatingIndicator: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      allowImplicitScrolling: true,
                      slideIndicator: CircularSlideIndicator(
                          slideIndicatorOptions: const SlideIndicatorOptions(
                        enableHalo: false,
                        currentIndicatorColor: RedColor,
                        indicatorBorderColor: RedColor,
                        enableAnimation: true,
                      ))),
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),

              // Header Product
              Container(
                height: 0.167.sh,
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AutoSizeText(
                              "${logic.product.value?.name}",
                              style: H1BlackTextStyle.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 0.01.sh,
                            ),
                            Text(
                              "منشور ${logic.product.value?.created_at}",
                              style: H4RegularDark,
                            ),
                          ],
                        )),
                        if (logic.product.value?.type == 'product')
                          Expanded(
                              child: RichText(
                                  text: TextSpan(children: [
                            if (logic.product.value?.is_discount == true)
                              WidgetSpan(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${logic.product.value?.price}",
                                        style: H4RegularDark.copyWith(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 0.02.sw,
                                        color: GrayDarkColor,
                                      ),
                                      Text(
                                        "${logic.product.value?.discount}",
                                        style: H2RedTextStyle,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 0.03.sw,
                                        color: RedColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.02.sh,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${logic.product.value?.turkey_price?.price?.toStringAsFixed(2)}",
                                        style: H4RegularDark.copyWith(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 0.02.sw,
                                        color: GrayDarkColor,
                                      ),
                                      Text(
                                        "${logic.product.value?.turkey_price?.discount?.toStringAsFixed(2)}",
                                        style: H2RedTextStyle,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 0.03.sw,
                                        color: RedColor,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            if (logic.product.value?.is_discount != true)
                              WidgetSpan(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${logic.product.value?.price?.toStringAsFixed(2)}",
                                        style: H2RedTextStyle,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 0.03.sw,
                                        color: RedColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${logic.product.value?.turkey_price?.price?.toStringAsFixed(2)}",
                                        style: H2RedTextStyle,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.turkishLiraSign,
                                        size: 0.03.sw,
                                        color: RedColor,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          ]))),
                      ],
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: GrayLightColor))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 0.4.sw,
                                child: FormBuilderRatingBar(
                                  onChanged: (value) =>
                                      logic.rate.value = value ?? 0,
                                  name: 'rate',
                                  maxRating: 5,
                                  minRating: 1,
                                  itemCount: 5,
                                  itemSize: 0.05.sw,
                                  initialRating: double.tryParse(
                                          "${logic.product.value?.vote_avg}") ??
                                      0,
                                  glowColor: OrangeColor,
                                  enabled: true,
                                  tapOnlyMode: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  ratingWidget: RatingWidget(
                                      full: const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: OrangeColor,
                                      ),
                                      half: const Icon(
                                        FontAwesomeIcons.starHalfStroke,
                                        color: OrangeColor,
                                      ),
                                      empty: const Icon(
                                        FontAwesomeIcons.star,
                                        color: GrayDarkColor,
                                      )),
                                  unratedColor: GrayDarkColor,
                                  glow: true,
                                  glowRadius: 0.4.r,
                                ),
                              ),
                              SizedBox(
                                width: 0.24.sw,
                                child: Obx(() {
                                  if (logic.loadingRate.value) {
                                    return InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(0.01.sw),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: RedColor,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: AutoSizeText(
                                              'جاري التقييم',
                                              style: H4WhiteTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                            SizedBox(
                                              width: 0.02.sw,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.voteYea,
                                              color: WhiteColor,
                                              size: 0.04.sw,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return InkWell(
                                    onTap: () {
                                      logic.rateProduct();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(0.01.sw),
                                      alignment: Alignment.center,
                                      width: 0.33.sw,
                                      decoration: BoxDecoration(
                                        color: RedColor,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (logic.product.value?.is_vote ==
                                              true)
                                            Text(
                                              'إعادة تقييم',
                                              style: H4WhiteTextStyle,
                                            )
                                          else
                                            Text(
                                              ' تقييم',
                                              style: H4WhiteTextStyle,
                                            ),
                                          SizedBox(
                                            width: 0.02.sw,
                                          ),
                                          if (logic.product.value?.is_vote ==
                                              true)
                                            Icon(
                                              FontAwesomeIcons.refresh,
                                              color: WhiteColor,
                                              size: 0.04.sw,
                                            )
                                          else
                                            Icon(
                                              FontAwesomeIcons.voteYea,
                                              color: WhiteColor,
                                              size: 0.04.sw,
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.truckFast,
                                  size: 0.04.sw,
                                  color:
                                      logic.product.value?.is_delivery == true
                                          ? Colors.green
                                          : RedColor),
                              Text(
                                logic.product.value?.is_delivery == true
                                    ? 'الشحن متوفر'
                                    : 'الشحن غير متوفر',
                                style: H5RegularDark.copyWith(
                                    color:
                                        logic.product.value?.is_delivery == true
                                            ? Colors.green
                                            : RedColor),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    // Colors
                    if (logic.product.value?.colors?.length != null &&
                        logic.product.value!.colors!.length > 0)
                      Expanded(
                          child: Container(
                        width: 1.sw,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                                logic.product.value?.colors?.length ?? 0,
                                (index) => Row(
                                      children: [
                                        Text(
                                          "${logic.product.value?.colors![index].name}",
                                          style: H4RegularDark,
                                        ),
                                        Container(
                                          width: 0.07.sw,
                                          height: 0.07.sw,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  "${logic.product.value?.colors![index].code}"
                                                      .toColor()),
                                        ),
                                        SizedBox(
                                          width: 0.03.sw,
                                        )
                                      ],
                                    ))
                          ],
                        ),
                      )),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                width: 1.sw,
                height: 0.05.sh,
                child: Row(
                  children: [
                    InkWell(
                      child: Container(
                        child: Text(
                          'الوصف',
                          style: logic.pageIndex.value == 0
                              ? H3RedTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: RedColor,
                                )
                              : H3RegularDark,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.03.sw,
                    ),
                    if (logic.product.value?.type == 'product' ||
                        logic.product.value?.type == 'news')
                      InkWell(
                        onTap: () {
                          Get.config(
                            defaultTransition: Transition.downToUp,
                            defaultDurationTransition:
                                const Duration(milliseconds: 500),
                          );
                          Get.toNamed(COMMENTS_PAGE,
                              parameters: {'id': "${logic.product.value?.id}"});
                        },
                        child: Container(
                          child: Text(
                            'التعليقات',
                            style: logic.pageIndex.value == 1
                                ? H3RedTextStyle.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: RedColor,
                                  )
                                : H3RegularDark,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Container(
                width: 1.sw,
                child: (logic.product.value != null)
                    ? Column(
                        children: [
                          Container(
                            width: 1.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.01.sh),
                            decoration: BoxDecoration(
                              color: GrayWhiteColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(children: [
                                ..."${logic.product.value?.info}"
                                    .split(' ')
                                    .map((el) {
                                  print(el);
                                  if (mainController.isURL("$el")) {
                                    return TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async =>
                                            await openUrl(url: '$el'),
                                      text: ' $el ',
                                      style:
                                          H3RedTextStyle.copyWith(height: 1.5),
                                    );
                                  } else {
                                    return TextSpan(
                                        text: ' $el ',
                                        style: H3RegularDark.copyWith(
                                            height: 1.5));
                                  }
                                })
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          if (logic.product.value?.type == 'job' ||
                              logic.product.value?.type == 'search_job' ||
                              logic.product.value?.type == 'tender' ||
                              logic.product.value?.type == 'service')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ...List.generate(
                                    logic.product.value?.docs.length ?? 0,
                                    (index) => InkWell(
                                          onTap: () {
                                            openUrl(
                                                url:
                                                    "${logic.product.value?.docs[index]}");
                                          },
                                          child: Text(
                                            "مرفق ${index + 1}",
                                            style: H3RedTextStyle.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: RedColor),
                                          ),
                                        ))
                              ],
                            ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          if (logic.product.value?.type == 'product')
                            Text(
                              'منتجات ذات صلة',
                              style: H3RedTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: RedColor),
                            ),
                          if (logic.product.value?.type == 'product')
                            SizedBox(
                              height: 0.01.sh,
                            ),
                          if (logic.product.value?.type == 'product')
                            ...List.generate(logic.products.length, (index) {
                              switch (logic.products[index].type) {
                                case 'product':
                                  return MinimizeDetailsProductComponent(
                                    post: logic.products[index],
                                    TitleColor: DarkColor,
                                    onClick: () {
                                      logic.productId.value =
                                          logic.products[index].id;
                                    },
                                  );

                                case 'service':
                                  return MinimizeDetailsServiceComponent(
                                    post: logic.products[index],
                                    TitleColor: DarkColor,
                                    onClick: () {
                                      logic.productId.value =
                                          logic.products[index].id;
                                    },
                                  );

                                case 'job':
                                case 'search_job':
                                  return MinimizeDetailsJobComponent(
                                    post: logic.products[index],
                                    TitleColor: DarkColor,
                                    onClick: () {
                                      logic.productId.value =
                                          logic.products[index].id;
                                    },
                                  );

                                default:
                                  return MinimizeDetailsTenderComponent(
                                    post: logic.products[index],
                                    TitleColor: DarkColor,
                                    onClick: () {
                                      logic.productId.value =
                                          logic.products[index].id;
                                    },
                                  );
                              }
                            })
                        ],
                      )
                    : null,
              )
            ],
          );
        },
      ),
    );
  }
}
