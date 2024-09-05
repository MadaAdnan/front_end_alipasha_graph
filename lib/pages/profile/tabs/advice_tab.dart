import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Global/main_controller.dart';
import '../../../models/advice_model.dart';
import '../../../models/slider_model.dart';
import '../logic.dart';

class AdviceTab extends StatelessWidget {
  AdviceTab({super.key});

  MainController mainController = Get.find<MainController>();
  final ProfileLogic logic = Get.find<ProfileLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logic.loading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView(
        children: [
          10.verticalSpace,
          Text(
            'المنتجات المميزة',
            style: H4GrayTextStyle,
          ),
          15.verticalSpace,
          ...List.generate(logic.myProducts.length, (index) {
            return Card(
              color: WhiteColor,
              child: ListTile(
                leading: Container(
                  width: 0.1.sw,
                  height: 0.1.sw,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          '${logic.myProducts[index].image}'),
                    ),
                  ),
                ),
                title: Text(
                  '${logic.myProducts[index].name}',
                  style: H4BlackTextStyle,
                ),
                subtitle: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '${logic.myProducts[index].category?.name}',
                      style: H4BlackTextStyle,
                    ),
                    TextSpan(
                      text: ' - ${logic.myProducts[index].sub1?.name}',
                      style: H4BlackTextStyle,
                    ),
                  ]),
                ),
              ),
            );
          }),
          10.verticalSpace,
          Divider(),
          10.verticalSpace,
          Container(
            width: 1.sw,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'الإعلانات بين المنتجات',
                  style: H4GrayTextStyle,
                ),
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
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          '${advice.image}',
                                        ),
                                        fit: BoxFit.cover)),
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
                      Text(
                        'إعلانات السلايدر',
                        style: H4GrayTextStyle,
                      ),
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
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          '${slider.image}',
                                        ),
                                        fit: BoxFit.cover)),
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
      );
    });
  }
}
