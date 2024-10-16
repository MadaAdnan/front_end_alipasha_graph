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
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);

  final logic = Get.find<ProductLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                width: 1.sw,
                height: 0.06.sh,
                color: WhiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                    Container()
                  ],
                ),
              ),
              if (logic.product.value?.images.length != null &&
                  logic.product.value?.images.length != 0)
                // Carousel
                Container(
                  child: FlutterCarousel(
                    items: logic.product.value?.images
                        .map(
                          (el) => Container(
                            width: 0.79.sw,
                            height: 0.79.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider("${el}"),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        )
                        .toList(),
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
              if (logic.product.value?.images.length == 0)
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
                                  "${logic.product.value!.image}"),
                              fit: BoxFit.contain),
                        ),
                      ),
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
              if (logic.product.value?.type == 'product')
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
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
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
                          Flexible(
                            flex: 2,
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
                        ),
                    ],
                  ),
                ),

              if (logic.product.value?.type != 'product')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
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
                        ),
                    ],
                  ),
                ),
              if (logic.product.value?.type == 'product' || logic.product.value?.type == 'news' )
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
                            style: logic.pageIndex.value==0? H3RedTextStyle.copyWith(decoration:TextDecoration.underline,decorationColor: RedColor,):H3RegularDark,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                      InkWell(
                        onTap: () {
                          logic.pageController.animateToPage(1,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.bounceIn);
                        },
                        child: Container(
                          child: Text(
                            'التعليقات',
                            style: logic.pageIndex.value==1? H3RedTextStyle.copyWith(decoration:TextDecoration.underline,decorationColor: RedColor,):H3RegularDark,
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
                    if (logic.product.value?.type == 'product' || logic.product.value?.type == 'news' )
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
