
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

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
            !logic.loadingProduct.value &&
            logic.hasMorePage.value) {
          logic.nextPage();
        }
        return true;
      },
      child: Column(
        children: [
        
          Obx(() {

            if (logic.loadingProduct.value && logic.products.length==0) {
              return Expanded(
                child: ListView(
                  children: [
                    ...List.generate(
                      1,
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

                    case "product":
                     return MinimizeDetailsProductComponent(post: logic.products[index],TitleColor: DarkColor,canEdit: true,onClick: (){
                       Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                     },);

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
              visible: logic.loadingProduct.value && logic.page.value > 1,
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
