import 'dart:math';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TabChart extends StatelessWidget {
  TabChart({super.key});

  MainController mainController = Get.find<MainController>();
  ProfileLogic logic = Get.find<ProfileLogic>();

  @override
  Widget build(BuildContext context) {
    Color? color=mainController
        .authUser.value?.is_verified==true ? mainController
        .authUser.value?.id_color!.toColor():DarkColor;
    return Container(
      color: WhiteColor,
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'الرصيد والإحصاء',
              style: H1BlackTextStyle,
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWidget(title: 'رصيد النقاط', count: logic.myPoint.value),
              _buildWidget(
                  title: 'عدد الإعلانات', count: logic.adviceCount.toDouble()),
              _buildWidget(
                  title: 'الشريط الإعلاني',
                  count: logic.sliderCount.toDouble()),
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWidget(title: 'المشاهدات', count: logic.views.toDouble()),
              _buildWidget(
                  onTab: () {
                    Get.toNamed(BALANCES_PAGE);
                  },
                  title: 'الرصيد الحالي',
                  count: logic.myBalance.toDouble(),
                  symbol: '\$'),
              _buildWidget(
                  title: 'مسحوبات الأرباح', count: logic.myWins.toDouble()),
            ],
          ),
          20.verticalSpace,
          const Divider(
            color: GrayDarkColor,
          ),
          Container(
            width: 1.sw,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('الإعلانات بين المنتجات',style: H4GrayTextStyle,),
                15.verticalSpace,
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 0.001.sh),
                      alignment: Alignment.center,
                      width: 0.33.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                          border: Border.all(color: DarkColor),
                          color: GrayLightColor),
                      child: Text(
                        'الإعلان',
                        style: H2BlackTextStyle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 0.001.sh),
                      alignment: Alignment.center,
                      width: 0.33.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                          border: Border.all(color: DarkColor),
                          color: GrayLightColor),
                      child: Text(
                        'مرات الظهور',
                        style: H2BlackTextStyle,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 0.001.sh),
                      width: 0.33.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                          border: Border.all(color: DarkColor),
                          color: GrayLightColor),
                      child: Text(
                        'تاريخ الإنتهاء',
                        style: H2BlackTextStyle,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (mainController.loading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      ...List.generate(
                        logic.myAdvices.length,
                        (index) {
                          var format = DateFormat.yMd();
                          AdviceModel advice = logic.myAdvices[index];
                          var expired_date =
                              DateTime.tryParse("${advice.expired_date}");
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 0.001.sh),
                                alignment: Alignment.center,
                                width: 0.33.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  border: Border.all(color: DarkColor),
                                  image: DecorationImage(image: CachedNetworkImageProvider('${advice.image}',),fit: BoxFit.cover)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 0.001.sh),
                                alignment: Alignment.center,
                                width: 0.33.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                    border: Border.all(color: DarkColor)),
                                child: Text(
                                  '${advice.views_count}'.toFormatNumber(),
                                  style: H2BlackTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 0.001.sh),
                                width: 0.33.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                    border: Border.all(color: DarkColor)),
                                child: Text(
                                  '${expired_date != null ? format.format(expired_date) : ''}',
                                  style: H2BlackTextStyle,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      15.verticalSpace,
                      Text('إعلانات السلايدر',style: H4GrayTextStyle,),
                      15.verticalSpace,
                      ...List.generate(
                        logic.sliders.length,
                            (index) {
                          var format = DateFormat.yMd();
                          SliderModel slider = logic.sliders[index];
                          var expired_date =
                          DateTime.tryParse("${slider.expired_date}");
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 0.001.sh),
                                alignment: Alignment.center,
                                width: 0.33.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                    border: Border.all(color: DarkColor),
                                    image: DecorationImage(image: CachedNetworkImageProvider('${slider.image}',),fit: BoxFit.cover)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 0.001.sh),
                                alignment: Alignment.center,
                                width: 0.33.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                    border: Border.all(color: DarkColor)),
                                child: Text(
                                  '${slider.views_count}'.toFormatNumber(),
                                  style: H2BlackTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 0.001.sh),
                                width: 0.33.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                    border: Border.all(color: DarkColor)),
                                child: Text(
                                  '${expired_date != null ? format.format(expired_date) : ''}',
                                  style: H2BlackTextStyle,
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidget(
      {String? title, double? count, String? symbol, Function()? onTab}) {
    Color? color=mainController
        .authUser.value?.is_verified==true ? mainController
        .authUser.value?.id_color!.toColor():DarkColor;
    return InkWell(
      onTap: onTab,
      child: Container(
        width: 0.3.sw,
        height: 0.2.sw,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: DarkColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(text: "$count", style: H2RedTextStyle.copyWith(color:color)),
                if (symbol != null)
                  TextSpan(text: " $symbol ", style: H2RedTextStyle.copyWith(color:color)),
              ]),
            ),
            Text(
              "$title",
              style: H3BlackTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
