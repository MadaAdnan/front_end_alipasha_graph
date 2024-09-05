import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../helpers/style.dart';
import 'logic.dart';

class AskPage extends StatelessWidget {
  AskPage({Key? key}) : super(key: key);

  final logic = Get.find<AskLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.1.sh,
            color: RedColor,
            child: Text(
              'تطبيق علي باشا - الاسئلة',
              style: H3WhiteTextStyle,
            ),
          ),
          Expanded(child: Obx(() {
            if (logic.loading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 0.02.sh,horizontal: 0.02.sw),
              children: [
                Container(
                  width: 1.sw,
                  height: 0.5.sw,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "${logic.ask.value?.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                20.verticalSpace,
                Container(
                  child: Text(
                    "${logic.ask.value?.ask}",
                    style: H2RedTextStyle,
                  ),
                ),
                20.verticalSpace,
                HtmlWidget(
                  "${logic.ask.value?.answer}",
                  textStyle: H2RegularDark,
                  onTapUrl: (url) {
                    openUrl(url: url);
                    return true;
                  },
                ),
              ],
            );
          }))
        ],
      ),
    );
  }
}
