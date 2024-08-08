import 'dart:ui';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/pages/product/tabs/comment_page.dart';
import 'package:ali_pasha_graph/pages/product/tabs/product_detailes.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);

  final logic = Get.find<ProductLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController controller = ScrollController();
  RxInt pageIndex = RxInt(0);
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Obx(
            () {
          if (logic.loading.value) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
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
                alignment: Alignment.center,
                width: 1.sw,
                height: 0.5.sw,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: GrayLightColor))),
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      Image(
                        image: NetworkImage("${images?[index]}"),
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: images?.length,
                ),
              ),
              Container(
                width: 1.sw,
                height: 0.1.sh,
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                margin: EdgeInsets.only(bottom: 0.01.sh),
                decoration: BoxDecoration(
                    color: WhiteColor,
                    border: Border(bottom: BorderSide(color: GrayLightColor))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${logic.product.value?.user
                                              ?.logo}"))),
                            ),
                            Text(
                              "${logic.product.value?.user?.seller_name}",
                              style: H4BlackTextStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${logic.product.value?.views_count}",
                              style: H4BlackTextStyle,
                            ),
                            10.horizontalSpace,
                            Icon(
                              FontAwesomeIcons.eye,
                              size: 50.h,
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.caretLeft,
                              size: 40.h,
                              color: RedColor,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 0.7.sw,
                                  child: Text(
                                    "${logic.product.value?.name}",
                                    style: H2BlackTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                          '${logic.product.value?.city?.name}',
                                          style: H5GrayOpacityTextStyle),
                                      TextSpan(
                                          text:
                                          ' - ${logic.product.value?.category
                                              ?.name}',
                                          style: H5GrayOpacityTextStyle),
                                      TextSpan(
                                          text:
                                          '- ${logic.product.value?.sub1
                                              ?.name}',
                                          style: H5GrayOpacityTextStyle)
                                    ]))
                              ],
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "ID : ",
                                style: H3BlackTextStyle.copyWith(
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${logic.product.value?.id}",
                                style: H3BlackTextStyle.copyWith(
                                    fontWeight: FontWeight.bold)),
                          ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Container(
                  height: 0.08.sh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 0.3.sw,
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                              color:pageIndex.value==0? RedColor:GrayLightColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            'التفاصيل',
                            style:pageIndex.value==0? H3WhiteTextStyle:H3BlackTextStyle,
                          ),
                        ),
                      ),
                      if(logic.product.value?.type=='product')
                      InkWell(
                        onTap: () {
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 0.3.sw,
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                              color:pageIndex.value==1? RedColor:GrayLightColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            'التعليقات',
                            style:pageIndex.value==1? H3WhiteTextStyle:H3BlackTextStyle,
                          ),
                        ),
                      ),
                      if(logic.product.value?.type=='product')
                      InkWell(
                        onTap: () {
                          pageController.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 0.3.sw,
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                              color:pageIndex.value==2? RedColor:GrayLightColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            'الموقع',
                            style:pageIndex.value==2? H3WhiteTextStyle:H3BlackTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
              Container(
                width: 1.sw,
                height: 0.52.sh,
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: PageView(
                  onPageChanged: (index) {
                    pageIndex.value = index;
                  },
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  controller: pageController,
                  children: [
                    if(logic.product.value!=null)
                    ProductDetailes(
                      product: logic.product.value,
                      products: logic.products,
                    ),
                    if(logic.product.value?.type=='product')
                    Container(
                      child: CommentPage(),
                    ),
                    if(logic.product.value?.type=='product')
                    Container(
                      child: Text('Page3'),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
