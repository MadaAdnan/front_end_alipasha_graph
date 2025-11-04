import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

import 'logic.dart';

class ServicePage extends StatelessWidget {
  ServicePage({Key? key}) : super(key: key);

  final logic = Get.find<ServiceLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !logic.loading.value &&
              logic.hasMorePage.value &&
              scrollInfo.context ==
                  _scrollController.position.context.notificationContext) {
            logic.nextPage();
          }

          return true;
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 1.sw,
              height: 0.05.sh,
              decoration: BoxDecoration(
                color: PrimaryColor,
              ),
              child: Text(
                '${logic.categoryModel.name}',
                style: H4WhiteTextStyle,
              ),
            ),
            Container(
              width: 1.sw,
              padding:
                  EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: WhiteColor,
                border: Border(
                  bottom: BorderSide(color: GrayLightColor, width: 1),
                ),
              ),
              child: Obx(() {
                return PopupMenuButton<dynamic>(
                  offset: Offset(0, 0.05.sh),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.04.sw, vertical: 0.015.sh),
                    decoration: BoxDecoration(
                      color: WhiteColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: GrayLightColor, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          logic.selectedCity.value == null
                              ? 'كل المدن'
                              : '${logic.selectedCity.value?.name}',
                          style: H3RegularDark,
                        ),
                        Icon(Icons.arrow_drop_down, color: DarkColor),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: null,
                      child: Row(
                        children: [
                          Container(
                            width: 0.08.sw,
                            height: 0.08.sw,
                            margin: EdgeInsets.only(left: 0.02.sw),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: GrayWhiteColor,
                            ),
                            child: Text(
                              'ك',
                              style: H3BlackTextStyle.copyWith(
                                  color: Colors.black),
                            ),
                          ),
                          Text('كل المدن', style: H3RegularDark),
                        ],
                      ),
                    ),
                    ...List.generate(
                      logic.cities.length,
                      (index) => PopupMenuItem(
                        value: logic.cities[index],
                        child: Row(
                          children: [
                            Container(
                              width: 0.08.sw,
                              height: 0.08.sw,
                              margin: EdgeInsets.only(left: 0.02.sw),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: GrayWhiteColor,
                              ),
                              child: Text(
                                "${logic.cities[index].name?.substring(0, 1)}",
                                style: H3BlackTextStyle.copyWith(
                                    color: Colors.black),
                              ),
                            ),
                            Text('${logic.cities[index].name}',
                                style: H3RegularDark),
                          ],
                        ),
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    logic.selectedCity.value = value;
                  },
                );
              }),
            ),
            Expanded(
              child: Obx(
                () {
                  return ListView(
                    key: Key('list1'),
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.005.sh, horizontal: 0.02.sw),
                    children: [
                      if (logic.loading.value && logic.page.value == 1)
                        ...List.generate(
                            4,
                            (index) =>
                                MinimizeDetailsProductComponentLoading()),
                      ...List.generate(logic.products.length, (index) {
                        return MinimizeDetailsServiceComponent(
                          post: logic.products[index],
                          TitleColor: DarkColor,
                          onClick: () {
                            if (logic.products[index].url != null &&
                                logic.products[index].url!.startsWith('http') &&
                                !logic.products[index].url!.endsWith('pdf')) {
                              openUrl(url: "${logic.products[index].url}");
                            } else if (logic.products[index].url != null &&
                                logic.products[index].url!.startsWith('http') &&
                                logic.products[index].url!.endsWith('pdf')) {
                              // openUrl(url: "${logic.products[index].url}");
                              Get.toNamed(PDF_PAGE,
                                  arguments: logic.products[index].url);
                            } else {
                              Get.toNamed(SERVICE_DETAILS,
                                  arguments: logic.products[index].id,
                                  parameters: {
                                    "id": "${logic.products[index].id}"
                                  });
                            }
                          },
                        );
                      }),
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
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
