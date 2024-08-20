import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/home_app_bar/custom_sliver_app_bar.dart';
import '../../components/product_components/job_card.dart';
import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class TendersPage extends StatelessWidget {
  TendersPage({Key? key}) : super(key: key);

  final logic = Get.find<TendersLogic>();
  MainController mainController =Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GrayLightColor,
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
          child: CustomScrollView(
            slivers: [
              HomeSliverAppBarComponent(),
              Obx(() {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if (index < logic.tenders.length) {
                        return JobCard(post: logic.tenders[index]);
                      }
                      if (logic.mainController.loading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return null;
                    },
                    childCount: logic.tenders.length +
                        (logic.mainController.loading.value ? 1 : 0),
                  ),
                );
              }),
              if (!logic.hasMorePage.value)
                SliverToBoxAdapter(
                  child: Center(
                      child: Padding(

                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'لا يوجد مزيد من النتائج',
                          style: H3GrayTextStyle,
                        ),
                      )),
                ),

            ],
          ),
        ));
  }
}
