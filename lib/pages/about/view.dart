import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final logic = Get.find<AboutLogic>();

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
            child: Text('تطبيق علي باشا - من نحن', style: H3WhiteTextStyle),
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
                    "${logic.about.value}",
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
