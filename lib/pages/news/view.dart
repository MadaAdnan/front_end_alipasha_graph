import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/components/single_news/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key);

  final logic = Get.find<NewsLogic>();
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
        return true;
      }, child: Obx(() {
        return ListView(
          children: [
            ...List.generate(logic.news.length, (index) {
              return SingleNewsComponent(
                post: logic.news[index],
              );
            }),
            if (logic.loading.value)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      })),
    );
  }
}
