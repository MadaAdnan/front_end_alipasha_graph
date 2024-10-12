import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/home_app_bar/custom_sliver_app_bar.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class JobsPage extends StatelessWidget {
  JobsPage({Key? key}) : super(key: key);

  final logic = Get.find<JobsLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    children: [
                      ...List.generate(
                          logic.jobs.length,
                          (index) {

                          return MinimizeDetailsJobComponent(post: logic.jobs[index],TitleColor: DarkColor,onClick: (){
                            Get.toNamed(PRODUCT_PAGE,arguments: logic.jobs[index].id);
                          },);



                      }),
                  if (logic.mainController.loading.value)
                   ...List.generate(5, (index)=>MinimizeDetailsProductComponentLoading()),

                      if (!logic.hasMorePage.value && !logic.loading.value)
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
        ));
  }
}
