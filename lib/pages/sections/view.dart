import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/sections_components/section_home_card.dart';
import 'logic.dart';

class SectionsPage extends StatelessWidget {
  SectionsPage({Key? key}) : super(key: key);

  final logic = Get.find<SectionsLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 0.02.sh),
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.15.sh,
            color: GrayLightColor,
            child: Text('جميع التصنيفات',style: H1BlackTextStyle,),
          ),
          Obx(() {
            if (logic.loading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Wrap(
             crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 0.04.sw,
              spacing: 0.04.sw,
              children: [
                ...List.generate(
                    logic.categories.length,
                    (index) => SectionHomeCard(
                          section: logic.categories[index],
                        ))
              ],
            );
          }),
        ],
      ),
    );
  }

  _buildSection() {}
}
