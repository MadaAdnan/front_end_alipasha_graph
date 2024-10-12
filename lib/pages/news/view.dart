import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/components/product_components/post_card_loading.dart';
import 'package:ali_pasha_graph/components/single_news/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/progress_loading.dart';
import 'logic.dart';

class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key);

  final logic = Get.find<NewsLogic>();
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
          return true;
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 0.1.sw,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: GrayDarkColor))),
              child: Text(
                'خر الأخبار',
                style: H3BlackTextStyle,
              ),
            ),
            Expanded(
                child: Container(
                  child: Obx(() {
                    return ListView(
                      children: [
                        ...List.generate(logic.news.length, (index) {
                          return SingleNewsComponent(
                            post: logic.news[index],
                          );
                        }),
                        if (logic.loading.value && logic.page.value == 1)
                          ...List.generate(5, (index) {
                            return PostCardLoading();
                          }),
                        if (logic.loading.value && logic.page.value > 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Container(
                                      height: 0.06.sh,
                                      child: ProgressLoading())),
                              Flexible(
                                  child: Text(
                                    'جاري جلب المزيد',
                                    style: H4GrayTextStyle,
                                  ))
                            ],
                          ),
                        if (!logic.loading.value && logic.news.length==0)
                          Container(padding: EdgeInsets.only(top: 0.02.sh),alignment: Alignment.center,child: Text('لا يوجد نتائج ...',style: H3RegularDark,),)
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
