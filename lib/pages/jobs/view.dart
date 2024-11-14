import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../components/progress_loading.dart';
import '../../helpers/colors.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          width: 0.1.sw,
          height: 0.1.sw,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
          child: PopupMenuButton(
            onSelected: (value) => logic.typeJob.value=value??'',
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'الكل',
                  style: H4RegularDark,
                ),
                value: '',
              ),
              PopupMenuItem(
                child: Text(
                  'شاغر وظيفي',
                  style: H4RegularDark,
                ),
                value: 'job',
              ),
              PopupMenuItem(
                child: Text(
                  'يبحث عن عمل',
                  style: H4RegularDark,
                ),
                value: 'search_job',
              ),
            ],
            icon: Transform.rotate(
              angle: 1.57,
              child: Icon(
                FontAwesomeIcons.sliders,
                size: 0.05.sw,
                color: WhiteColor,
              ),
            ),
            offset: Offset(0, -0.2.sh),
          ),
        ),
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
              HomeAppBarComponent(
                selected: 'job',
              ),
              Expanded(child: Container(
                child: Obx(() {
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    children: [
                      ...List.generate(logic.jobs.length, (index) {
                        return MinimizeDetailsJobComponent(
                          post: logic.jobs[index],
                          TitleColor: DarkColor,
                          onClick: () {
                            Get.toNamed(PRODUCT_PAGE,
                                arguments: logic.jobs[index].id);
                          },
                        );
                      }),
                      if (logic.loading.value &&
                          logic.page.value == 1)
                        ...List.generate(
                            5,
                            (index) =>
                                MinimizeDetailsProductComponentLoading()),
                      if (logic.loading.value && logic.page.value > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Container(
                                    height: 0.06.sh, child: ProgressLoading())),
                            Flexible(
                                child: Text(
                              'جاري جلب المزيد',
                              style: H4GrayTextStyle,
                            ))
                          ],
                        ),
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
