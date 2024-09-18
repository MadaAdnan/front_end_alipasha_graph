import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class SectionPage extends StatelessWidget {
  SectionPage({Key? key}) : super(key: key);

  final logic = Get.find<SectionLogic>();
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
            Container(
              width: 1.sw,
              height: 0.05.sh,
              margin: EdgeInsets.symmetric(vertical: 0.01.sh),
              color: WhiteColor,
              child: Obx(() {
                if (logic.loading.value && logic.category.value == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (logic.loading.value == false &&
                        logic.category.value == null ||
                    logic.category.value?.children?.length == 0) {
                  return Text('لا يوجد أقسام فرعية');
                }
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
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
                child: Obx(() {
                  return Column(
                    children: [
                      ...List.generate(logic.products.length, (index) {
                        return Column(
                          children: [
                            MinimizeDetailsProductComponent(post: logic.products[index],onClick: ()=>Get.toNamed(PRODUCT_PAGE,arguments: logic.products[index].id),),
                            if (logic.advices.length > 0 && index % 5 == 0)
                              AdviceComponent(
                                  advice: logic.advices[int.parse(
                                      "${index % logic.advices.length}")])
                          ],
                        );
                      }),
                      if (logic.loading.value)
                        Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (!logic.hasMorePage.value)
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
        width: 1.sw / 4.5,
        margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 0.001.sh, horizontal: 0.02.sw),
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
}
