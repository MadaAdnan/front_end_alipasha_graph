import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import 'logic.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);

  final logic = Get.find<ProductsLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 0.1.sh,
              decoration: BoxDecoration(color: RedColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 0.1.sw,
                    height: 0.1.sw,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage("${logic.seller.logo}")),
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.7.sw,
                        child: Text(
                          "${logic.seller.seller_name}",
                          style: H3WhiteTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 0.7.sw,
                        child: Text(
                          "${logic.seller.name}",
                          style: H4GrayTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: Container(
              child: Obx(() {
                return ListView(
                  children: [
                    if (logic.products.length > 0)
                      ...List.generate(logic.products.length, (index) {
                        return Column(
                          children: [
                            if(logic.advices.length>0 && index%5==0)
                             AdviceComponent(advice: logic.advices[index%logic.advices.length])
                              ,
                            PostCard(
                              post: logic.products[index],
                            )
                          ],
                        );
                      }),
                    if (logic.loading.value)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'جاري جلب المزيد',
                              style: H3BlackTextStyle,
                            ),
                          ),
                          10.horizontalSpace,
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                  ],
                );
              }),
            ))
          ],
        ),
      ),
    );
  }
}
