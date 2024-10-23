import 'dart:ui';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';
import 'package:ali_pasha_graph/components/slider_component/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:ali_pasha_graph/pages/product/tabs/comment_page.dart';
import 'package:ali_pasha_graph/pages/product/tabs/product_detailes.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: (mainController.carts.length > 0)
          ? Stack(
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(CART_SELLER);
            },
            child: Container(
              padding: EdgeInsets.all(0.02.sw),
              decoration: BoxDecoration(
                color: RedColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FontAwesomeIcons.cartShopping,
                color: WhiteColor,
              ),
            ),
          ),
          Positioned(
            child: Badge.count(
              count: mainController.carts.length,
              backgroundColor: RedColor,
            ),
            top: 0,
            right: 0,
          )
        ],
      )
          : Container(),
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
                padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw, vertical: 0.005.sh),
                width: 1.sw,
                height: 0.06.sh,
                decoration: BoxDecoration(color: WhiteColor, boxShadow: [
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
                                    "${logic.product.value?.city}",
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
                                    "${logic.product.value?.user?.seller_name}",
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
                    if(isAuth())
                    Row(
                      children: [

                        Obx(() {
                          int index = mainController.authUser.value!.followers!
                              .indexWhere(
                                  (el) => el.seller?.id == logic.product.value?.user?.id);
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.01.sh, horizontal: 0.04.sw),
                            decoration: BoxDecoration(
                              color: RedColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: InkWell(
                              onTap: () async {
                                loadingFollow.value = true;
                                if (logic.product.value?.user?.id != null &&
                                    isAuth() && index==-1) {
                                 await mainController.follow(
                                     sellerId: logic.product.value!.user!.id!);
                                }
                                loadingFollow.value = false;
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text:index==-1? 'تابع ' : 'أتابعه',
                                        style: H5WhiteTextStyle),
                                    WidgetSpan(
                                        child: loadingFollow.value
                                            ? AnimateIcon(
                                          key: UniqueKey(),
                                          onTap: () {},
                                          iconType:
                                          IconType.continueAnimation,
                                          height: 0.03.sw,
                                          width: 0.03.sw,
                                          color: WhiteColor,
                                          animateIcon: AnimateIcons.bell,
                                        )
                                            : Icon(
                                          FontAwesomeIcons.bell,
                                          color: WhiteColor,
                                          size: 0.03.sw,
                                        ))
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
                            إبلاغ  عن المنتج ${logic.product.value
                                          ?.name} #${logic.product.value
                                          ?.id}''');
                                } else {
                                  openUrl(
                                      url:
                                      "https://wa.me/${mainController.settings
                                          .value.social?.phone}");
                                }

                                break;
                              case '1':
                                if (logic.product.value?.user?.id != null) {
                                  mainController.createCommunity(
                                      sellerId: logic.product.value!.user!.id!,
                                      message:
                                      ''' السلام عليكم ورحمة الله وبركاته 
                            طلب المنتج ${logic.product.value?.name} #${logic
                                          .product.value?.id}''');
                                } else {
                                  openUrl(
                                      url:
                                      "https://wa.me/${mainController.settings
                                          .value.social?.phone}");
                                }

                                break;

                              default:
                                print('default');
                            }
                          },
                          itemBuilder: (context) =>
                          [
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
              ),
              Container(
                child: FlutterCarousel(
                  items: [
                    Container(
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
                    ...List.generate(
                      logic.product.value?.images.length ?? 0,
                          (index) =>
                          Container(
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
                          slideIndicatorOptions: SlideIndicatorOptions(
                            enableHalo: false,
                            currentIndicatorColor: RedColor,
                            enableAnimation: true,
                          ))),
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),

              // Header Product
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: logic.product.value?.is_discount == true
                                ? 5
                                : 7,
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
                          Flexible(
                            flex: logic.product.value?.is_discount == true
                                ? 4
                                : 2,
                            child: RichText(
                                text: TextSpan(children: [
                                  if (logic.product.value?.is_discount == true)
                                    WidgetSpan(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${logic.product.value
                                                      ?.price}",
                                                  style: H4RegularDark.copyWith(
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough),
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.dollarSign,
                                                  size: 0.02.sw,
                                                  color: GrayDarkColor,
                                                ),
                                                Text(
                                                  "${logic.product.value
                                                      ?.discount}",
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
                                              mainAxisAlignment: MainAxisAlignment
                                                  .end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${logic.product.value
                                                      ?.turkey_price?.price
                                                      ?.toStringAsFixed(2)}",
                                                  style: H4RegularDark.copyWith(
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough),
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.dollarSign,
                                                  size: 0.02.sw,
                                                  color: GrayDarkColor,
                                                ),
                                                Text(
                                                  "${logic.product.value
                                                      ?.turkey_price?.discount
                                                      ?.toStringAsFixed(2)}",
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
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${logic.product.value?.price
                                                      ?.toStringAsFixed(2)}",
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
                                              mainAxisAlignment: MainAxisAlignment
                                                  .end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${logic.product.value
                                                      ?.turkey_price?.price
                                                      ?.toStringAsFixed(2)}",
                                                  style: H2RedTextStyle,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons
                                                      .turkishLiraSign,
                                                  size: 0.03.sw,
                                                  color: RedColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                ])),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    // Colors
                    if (logic.product.value?.colors?.length != null &&
                        logic.product.value!.colors!.length > 0)
                      Container(
                        width: 1.sw,
                        height: 0.05.sh,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                                logic.product.value?.colors?.length ?? 0,
                                    (index) =>
                                    Row(
                                      children: [
                                        Text(
                                          "${logic.product.value?.colors![index]
                                              .name}",
                                          style: H4RegularDark,
                                        ),
                                        Container(
                                          width: 0.07.sw,
                                          height: 0.07.sw,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                              "${logic.product.value
                                                  ?.colors![index].code}"
                                                  .toColor()),
                                        ),
                                        SizedBox(
                                          width: 0.03.sw,
                                        )
                                      ],
                                    ))
                          ],
                        ),
                      ),
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
                      onTap: () {
                        logic.pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.bounceIn);
                      },
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
                          logic.pageController.animateToPage(1,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.bounceIn);
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
                height: 0.4.sh,
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: PageView(
                  onPageChanged: (index) {
                    logic.pageIndex.value = index;
                  },
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  controller: logic.pageController,
                  children: [
                    if (logic.product.value != null)
                      ProductDetailes(
                        product: logic.product.value,
                        products: logic.products,
                      ),
                    if (logic.product.value?.type == 'product' ||
                        logic.product.value?.type == 'news')
                      Container(
                        child: CommentPage(),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
