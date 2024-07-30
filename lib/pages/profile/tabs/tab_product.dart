import 'dart:ffi';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/product_components/mini_post_card.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
          Container(
            color: WhiteColor,
            padding: EdgeInsets.symmetric(
                vertical: 0.004.sh, horizontal: 0.02.sw),
            child: InputComponent(
              fill: WhiteColor,
              width: 1.sw,
              height: 0.07.sh,
              hint: 'ابحث عن منتج',
              controller: logic.searchController,
              onEditingComplete: () {
                logic.search.value = logic.searchController.text;
              },
            ),
          ),
          Obx(() {
            if (logic.loading.value && logic.page.value == 1) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    MiniPostCard(
                      post: logic.products[index],
                    ),
                itemCount: logic.products.length,
              ),
            );
          }),
          Obx(() {
            return Visibility(
              child: Center(child: CircularProgressIndicator(),),
              visible: mainController.loading.value && logic.page.value > 1,);
          })
        ],
      ),
    );
  }
}
