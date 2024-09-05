import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../helpers/style.dart';
import 'logic.dart';

class AsksPage extends StatelessWidget {
  AsksPage({Key? key}) : super(key: key);

  final logic = Get.find<AsksLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
              width: 1.sw,
              height: 0.1.sh,
              color: RedColor,
              alignment: Alignment.center,
              child: Text(
                'تطبيق علي باشا - الاسئلة',
                style: H3WhiteTextStyle,
              )),
          Expanded(
            child: Obx(() {
              if (logic.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: [
                  ...List.generate(logic.asks.length, (index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${logic.asks[index].ask}',
                          style: H3BlackTextStyle,
                        ),
                        subtitle: HtmlWidget(
                          "${logic.asks[index].answer?.substring(0, 70)} ...",
                          textStyle: H4GrayTextStyle,
                        ),
                        onTap: () {
                          Get.toNamed(ASK_PAGE,arguments: logic.asks[index]);
                        },
                      ),
                      color: WhiteColor,
                    );
                  })
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
