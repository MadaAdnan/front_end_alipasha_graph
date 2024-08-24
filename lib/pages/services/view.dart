import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({Key? key}) : super(key: key);

  final logic = Get.find<ServicesLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 1.sw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(PRAYER_PAGE);
                  },
                  child: Container(
                    alignment: Alignment.center,
                   padding: EdgeInsets.symmetric(horizontal: 0.03.sw,vertical: 0.03.sw),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: DarkColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.mosque,
                          color: GoldColor,
                        ),
                        Text(
                          'مواقيت الصلاة',
                          style: H3BlackTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(GOLD_PAGE);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 0.03.sw,vertical: 0.03.sw),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: DarkColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.coins,
                          color:GoldColor,
                        ),
                        Text(
                          'أسعار الذهب والعملات',
                          style: H4BlackTextStyle,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
