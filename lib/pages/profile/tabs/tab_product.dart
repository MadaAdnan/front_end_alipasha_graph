import 'dart:ffi';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/product_components/mini_post_card.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/progress_loading.dart';
import '../../../helpers/style.dart';

class TabProduct extends StatelessWidget {
  TabProduct({super.key});

  final ProfileLogic logic = Get.find<ProfileLogic>();
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent * 0.80 &&
            !mainController.loading.value &&
            logic.hasMorePage.value) {
          logic.nextPage();
        }

        if (scrollInfo is ScrollUpdateNotification) {
          if (scrollInfo.metrics.pixels > scrollInfo.metrics.minScrollExtent) {
            mainController.is_show_home_appbar(false);
          } else {
            mainController.is_show_home_appbar(true);
          }
        }
        return true;
      },
      child: Column(
        children: [
          /*  Container(
            color: WhiteColor,
            padding: EdgeInsets.symmetric(
                vertical: 0.004.sh, horizontal: 0.02.sw),
            child: InputComponent(
              fill: WhiteColor,
              width: 1.sw,
              height: 0.055.sh,
              hint: 'ابحث عن منتج',
              controller: logic.searchController,
              onEditingComplete: () {
                logic.search.value = logic.searchController.text;
              },
            ),
          ),*/
          Obx(() {
            if ((logic.loading.value && logic.page.value == 1)) {
              return Expanded(
                child: ListView(
                  children: [
                    ...List.generate(
                      4,
                      (i) => MinimizeDetailsProductComponentLoading(),
                    )
                  ],
                ),
              );
            }
            return Flexible(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                itemBuilder: (context, index) {
                  switch (logic.products[index].type) {
                    case "service":
                      return MinimizeDetailsServiceComponent(post: logic.products[index],TitleColor: DarkColor,canEdit: true,onClick: (){
                        Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                      },);
                    case "tender":
                      return MinimizeDetailsTenderComponent(post: logic.products[index],TitleColor: DarkColor,canEdit: true,onClick: (){
                        Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                      },);
                    case "job":
                    case "search_job":
                      return MinimizeDetailsJobComponent(post: logic.products[index],TitleColor: DarkColor,canEdit: true,onClick: (){
                        Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                      },);
                      break;
                    case "product":
                     return MinimizeDetailsProductComponent(post: logic.products[index],TitleColor: DarkColor,canEdit: true,onClick: (){
                       Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                     },);
                      break;
                    default:
                      return MinimizeDetailsServiceComponent(post: logic.products[index],TitleColor: DarkColor,onClick: (){
                        Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                      },);
                  }

                },
                itemCount: logic.products.length,
              ),
            );
          }),
          Obx(() {
            return Visibility(
              visible: mainController.loading.value && logic.page.value > 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child:
                          Container(height: 0.06.sh, child: ProgressLoading())),
                  Flexible(
                      child: Text(
                    'جاري جلب المزيد',
                    style: H4GrayTextStyle,
                  ))
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
