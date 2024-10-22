import 'dart:math';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/home_app_bar/custom_sliver_app_bar.dart';

import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/components/product_components/post_card_loading.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/components/sections_components/section_home_card.dart';
import 'package:ali_pasha_graph/components/seller_component/seller_home_page_card.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/components.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final mainController = Get.find<MainController>();
  final logic = Get.find<HomeLogic>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              InkWell(
                onTap: () {
                  Get.toNamed(CREATE_PRODUCT_PAGE);
                },
                child: Container(
                  padding: EdgeInsets.all(0.02.sw),
                  decoration:  BoxDecoration(
                    color: RedColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(FontAwesomeIcons.plus, color: WhiteColor,),
                ),
              ),
              if(mainController.carts.length > 0)
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(CART_SELLER);
                      },
                      child: Container(
                        padding: EdgeInsets.all(0.02.sw),
                        decoration:  BoxDecoration(
                          color: RedColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FontAwesomeIcons.cartShopping, color: WhiteColor,),
                      ),
                    ),
                    Positioned(child: Badge.count(
                      count: mainController.carts.length,
                      backgroundColor: RedColor,), top: 0, right: 0,)
                  ],
                ),
              SizedBox(height: 0.02.sh,),
            ],
          ),
        );
      }),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
        child: Column(
          children: [
            HomeAppBarComponent(),
            Expanded(child: Container(
              child: Obx(() {
                return ListView(
                  controller: _scrollController,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(PROFILE_PAGE);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                        width: 1.sw,
                        height: 0.06.sh,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(0.002.sw),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: GrayDarkColor,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(0.002.sw),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: WhiteColor,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(0.002.sw),
                                  decoration:
                                  BoxDecoration(shape: BoxShape.circle),
                                  child: Obx(() {
                                    return Container(
                                      width: 0.1.sw,
                                      height: 0.1.sw,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: getLogo() != null
                                                  ? NetworkImage(
                                                  '${getLogo()}')
                                                  : getUserImage())),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(CREATE_PRODUCT_PAGE);
                                },
                                child: Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 0.02.sw),
                                  alignment: Alignment.centerRight,
                                  height: 0.05.sh,
                                  decoration: BoxDecoration(
                                    color: WhiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: GrayDarkColor,
                                          blurRadius: 3),
                                      BoxShadow(
                                          color: GrayDarkColor.withOpacity(
                                              0.4),
                                          blurRadius: 3),
                                    ],
                                    borderRadius: BorderRadius.circular(50.w),
                                  ),
                                  child: Text(
                                    'ماذا تفكر أن تنشر ...',
                                    style: H3GrayTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: WhiteColor,
                      height: 0.103.sh,
                      padding: EdgeInsets.symmetric(vertical: 0.002.sh),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (mainController.categories.length == 0)
                            ...List.generate(4, (index) => _buildSection()),
                          ...List.generate(
                              mainController.categories
                                  .where((el) => el.type == 'product')
                                  .length >
                                  4
                                  ? 4
                                  : mainController.categories
                                  .where((el) => el.type == 'product')
                                  .length,
                                  (index) =>
                                  SectionHomeCard(
                                      section: mainController.categories
                                          .where((el) => el.type == 'product')
                                          .toList()[index])),
                          _viewMoreButton(
                              title: 'عرض المزيد',
                              color: ShowMoreColor,
                              img: "assets/images/png/show_more.jpg"),
                        ],
                      ),
                    ),
                    // seller
                    Container(
                      height: 0.157.sh,
                      width: double.infinity,
                      color: WhiteColor,
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        semanticChildCount: 4,
                        scrollDirection: Axis.horizontal,
                        children: [
                          if (logic.sellers.length == 0)
                            ...List.generate(6, (i) {
                              return _buildSeller();
                            })
                          else
                            ...List.generate(logic.sellers.length, (index) {
                              return SellerHomePageCard(
                                seller: logic.sellers[index],
                              );
                            }),
                        ],
                      ),
                    ),
                    Divider(
                      color: GrayDarkColor,
                      height: 0.0017.sh,
                    ),
                    if (logic.loading.value && logic.products.length==0)
                      ...List.generate(4, (index) => PostCardLoading()),
                    ...List.generate(
                      logic.products.length + (logic.loading.value ? 1 : 0),
                          (index) {
                        int i = 0;
                        if (mainController.advices.length > 0) {
                          i = index % mainController.advices.length;
                        }

                        if (index < logic.products.length) {
                          switch (logic.products[index].type) {
                            case 'job':
                            case 'search_job':
                            case "tender":
                              return Column(
                                children: [
                                  JobCard(post: logic.products[index]),
                                  if (index % 5 == 0 &&
                                      i < mainController.advices.length)
                                    AdviceComponent(
                                      advice: mainController.advices[i],
                                    )
                                ],
                              );
                            default:
                              return Column(
                                children: [
                                  PostCard(post: logic.products[index]),
                                  if (index % 5 == 0 &&
                                      i < mainController.advices.length)
                                    AdviceComponent(
                                      advice: mainController.advices[i],
                                    )
                                ],
                              );
                          }
                        }
                        if (logic.loading.value) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Container(
                                      height: 0.06.sh,
                                      child: ProgressLoading())),
                              Flexible(
                                  child: Text(
                                    'جاري جلب المزيد',
                                    style: H4GrayTextStyle,
                                  ))
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    if (!logic.hasMorePage.value)
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0),
                            child: Text(
                              'لا يوجد مزيد من النتائج',
                              style: H3GrayTextStyle,
                            ),
                          )),
                  ],
                );
              }),
            ))
          ],
        ),
      ),
    );
  }

  Widget _viewMoreButton(
      {required Color color, required String title, String? img}) {
    return InkWell(
      onTap: () {
        Get.toNamed(SECTIONS_PAGE);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.001.sw),
        height: 0.096.sh,
        width: 0.185.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 0.0059.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // padding: EdgeInsets.all(0.007.sw),
              height: 0.150.sw,
              width: 0.150.sw,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(150.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150.r),
                  image: DecorationImage(
                    image: AssetImage("${img}"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Text(
              title!,
              overflow: TextOverflow.ellipsis,
              style: H4BlackTextStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection() {
    return Shimmer.fromColors(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0.001.sw),
          height: 0.096.sh,
          width: 0.185.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
          ),
          margin: EdgeInsets.symmetric(horizontal: 0.0059.sw),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(0.02.sw),
                  height: 0.150.sw,
                  width: 0.150.sw,
                  decoration: BoxDecoration(
                    color: GrayLightColor,
                    borderRadius: BorderRadius.circular(0.03.sw),
                  ),
                  child: Container(
                    color: GrayLightColor,
                  ),
                ),
              ]),
        ),
        baseColor: GrayLightColor,
        highlightColor: GrayWhiteColor);
  }

  Widget _buildSeller() {
    return Shimmer.fromColors(
        child: Container(
          width: 0.27.sw,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: GrayLightColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20.h, right: 20.w),
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: WhiteColor,
              radius: 40.r,
            ),
          ),
        ),
        baseColor: GrayLightColor,
        highlightColor: GrayWhiteColor);
  }
}
