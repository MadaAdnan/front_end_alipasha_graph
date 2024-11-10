import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class SectionPage extends StatelessWidget {
  SectionPage({Key? key}) : super(key: key);

  final logic = Get.find<SectionLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Row(
        children: [
          if (mainController.carts.length > 0)
            Stack(
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
                  top: 0,
                  right: 0,
                  child: Badge.count(
                    count: mainController.carts.length,
                    backgroundColor: RedColor,
                  ),
                )
              ],
            ),
          Container(
            width: 0.1.sw,
            height: 0.1.sw,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.black.withOpacity(0.6)),
            child: PopupMenuButton(
              iconColor: WhiteColor,
              color: WhiteColor,
              offset: Offset(0, -0.25.sh),
              icon: Icon(FontAwesomeIcons.arrowDownAZ),
              onSelected: (value) {
                switch (value) {
                  case 'price_up':
                    logic.orderBy(['price', 'desc']);
                    break;
                  case 'price_down':
                    logic.orderBy(['price', 'asc']);
                    break;
                  case 'created_up':
                    logic.orderBy(['created_at', 'desc']);
                    break;
                  case 'created_down':
                    logic.orderBy(['created_at', 'asc']);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'price_up',
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.arrowDownWideShort),
                      SizedBox(
                        width: 0.01.sw,
                      ),
                      Text(
                        'فرز حسب الأعلى سعراً',
                        style: H4BlackTextStyle,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'price_down',
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.arrowUpWideShort),
                      SizedBox(
                        width: 0.01.sw,
                      ),
                      Text(
                        'فرز حسب الأقل سعراً',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'created_up',
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.arrowDownWideShort),
                      SizedBox(
                        width: 0.01.sw,
                      ),
                      Text(
                        'فرز حسب الاحدث',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'created_down',
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.arrowUpWideShort),
                      SizedBox(
                        width: 0.01.sw,
                      ),
                      Text(
                        'فرز حسب الأقدم',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: WhiteColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !mainController.loading.value &&
              logic.hasMorePage.value &&
              _scrollController.position.context.notificationContext ==
                  scrollInfo.context) {
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
            Container(
              width: 1.sw,
              height: 0.05.sh,
              margin: EdgeInsets.symmetric(vertical: 0.01.sh),
              padding: EdgeInsets.symmetric(vertical: 0.003.sh),
              decoration: BoxDecoration(
                  color: WhiteColor,
                  border: Border(bottom: BorderSide(color: GrayDarkColor))),
              child: Obx(() {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (logic.loadingProduct.value)
                      ...List.generate(4, (index) {
                        return Shimmer.fromColors(
                            baseColor: GrayLightColor,
                            highlightColor: GrayWhiteColor,
                            child: _loadingbuildSubSection());
                      }),
                    if (!logic.loadingProduct.value)
                      ...List.generate(logic.category.value!.children!.length,
                          (index) {
                        return _buildSubSection(
                            category: logic.category.value!.children![index]);
                      })
                  ],
                );
              }),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: Obx(() {
                  return Column(
                    children: [
                      ...List.generate(logic.products.length, (index) {
                        return Column(
                          children: [
                            MinimizeDetailsProductComponent(
                              TitleColor: DarkColor,
                              post: logic.products[index],
                              onClick: () => Get.toNamed(PRODUCT_PAGE,
                                  arguments: logic.products[index].id),
                            ),
                            if (logic.advices.length > 0 && index % 5 == 0)
                              AdviceComponent(
                                  advice: logic.advices[int.parse(
                                      "${index % logic.advices.length}")])
                          ],
                        );
                      }),
                      if (logic.loading.value && logic.page.value == 1)
                        ...List.generate(
                            4,
                            (index) => Shimmer.fromColors(
                                baseColor: GrayLightColor,
                                highlightColor: GrayWhiteColor,
                                child:
                                    MinimizeDetailsProductComponentLoading())),
                      if (logic.loading.value && logic.page.value > 1)
                        Container(
                          alignment: Alignment.center,
                          width: 0.1.sw,
                          child: ProgressLoading(),
                        ),
                      if (!logic.hasMorePage.value && !logic.loading.value)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'لا يوجد مزيد من النتائج',
                            style: H3GrayTextStyle,
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSubSection({required CategoryModel category}) {
    return InkWell(
      onTap: () {
        logic.categoryId.value = category.id;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.01.sw),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 0.001.sh, horizontal: 0.05.sw),
        decoration: BoxDecoration(
            color: logic.categoryId.value == category.id
                ? RedColor
                : GrayLightColor,
            borderRadius: BorderRadius.circular(15.r)),
        child: Text(
          "${category.name}",
          style: logic.categoryId.value != category.id
              ? H3BlackTextStyle
              : H3WhiteTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  _loadingbuildSubSection() {
    return InkWell(
      child: Container(
        width: 1.sw / 4.5,
        margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 0.001.sh, horizontal: 0.02.sw),
        decoration: BoxDecoration(
            color: GrayLightColor, borderRadius: BorderRadius.circular(15.r)),
        child: Text(
          "القسم",
          style: H3WhiteTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
