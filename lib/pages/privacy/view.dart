import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PrivacyPage extends StatelessWidget {
  PrivacyPage({Key? key}) : super(key: key);

  final logic = Get.find<PrivacyLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.07.sh,
            color: RedColor,
            child: Text('تطبيق علي باشا - سياسة الخصوصية', style: H3WhiteTextStyle),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sw),
            child: Obx(() {
              if (logic.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return HtmlWidget(
                "${logic.privacy.value}",
                textStyle: H3GrayTextStyle,
                onTapUrl: (String url) {
                  openUrl(url: url);
                  return Future.value(true);
                },
              );
            }),
          )),
        ],
      ),
    );
  }
}
