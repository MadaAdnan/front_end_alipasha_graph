import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/weather_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({Key? key}) : super(key: key);

  final logic = Get.find<WeatherLogic>();
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: 0.07.sh,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: RedColor,
            ),
            child: Text(
              'تطبيق علي باشا - حالة الطقس ',
              style: H2WhiteTextStyle,
            ),
          ),
          30.verticalSpace,
          Expanded(
            child: Obx(() {
              if (logic.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return PageView(
                pageSnapping: true,
                controller: pageController,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
                    width: 0.8.sw,
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0.02.sh),
                          width: 0.7.sw,
                          height: 0.08.sh,
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            width: 0.5.sw,
                            height: 0.08.sh,
                            decoration: BoxDecoration(
                              color: GrayWhiteColor,
                              border: Border.all(color: GrayDarkColor),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text(
                              'مدينة إدلب',
                              style: H1RegularDark.copyWith(fontSize: 45.sp),
                            ),
                          ),
                        ),
                        15.verticalSpace,
                        ...List.generate(
                            logic.idlibWeather.length,
                            (index) => _buildToday(
                                weather: logic.idlibWeather[index],
                                index: index))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
                    width: 0.8.sw,
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 0.02.sh),
                          width: 0.7.sw,
                          height: 0.08.sh,
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            width: 0.5.sw,
                            height: 0.08.sh,
                            decoration: BoxDecoration(
                              color: GrayWhiteColor,
                              border: Border.all(color: GrayDarkColor),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text(
                              'مدينة إعزاز',
                              style: H1RegularDark.copyWith(fontSize: 45.sp),
                            ),
                          ),
                        ),
                        15.verticalSpace,
                        ...List.generate(
                            logic.izazWeather.length,
                            (index) => _buildToday(
                                weather: logic.izazWeather[index],
                                index: index)),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  _buildToday({required WeatherModel weather, int? index}) {
    print('INDEX IS $index');
    return Container(
      padding: EdgeInsets.only(top: 0.02.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: GrayWhiteColor.withOpacity(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.015.sh),
                  decoration: BoxDecoration(
                      color: WhiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r),topRight: Radius.circular(30.r)),
                      boxShadow:[BoxShadow(color: Colors.black,spreadRadius: 1.r,blurStyle: BlurStyle.inner,blurRadius: 10.r)],
                      border: Border(bottom: BorderSide(color: DarkColor),
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (index == 0)
                        Text(
                          "اليوم :",
                          style: H1BlackTextStyle.copyWith(
                              color: Colors.black, fontSize: 40.sp),
                        ),
                      if (index == 1)
                        Text(
                          "غداً :",
                          style: H1BlackTextStyle.copyWith(
                              color: Colors.black, fontSize: 40.sp),
                        ),
                      if (index == 2)
                        Text(
                          "بعد غد :",
                          style: H1BlackTextStyle.copyWith(
                              color: Colors.black, fontSize: 40.sp),
                        ),
                      Text(
                        "${weather.date}",
                        style: H1BlackTextStyle.copyWith(
                            color: Colors.black, fontSize: 40.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.02.sw, vertical: 0.01.sh),
                  width: 0.8.sw,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(-0.02.sw, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${weather.text}".weatherType(),
                              style: H1BlackTextStyle.copyWith(fontSize: 60.sp),
                            ),
                            CachedNetworkImage(
                              imageUrl: "${weather.icon}",
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 0.4.sw,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("درجة الحرارة : ", style: H1BlackTextStyle),
                            15.horizontalSpace,
                            Text("${weather.temp_c} \u00B0C",
                                style: H1BlackTextStyle.copyWith(
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                      Container(
                        width: 0.4.sw,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("سرعة الرياح :", style: H1BlackTextStyle),
                            10.horizontalSpace,
                            Text("${weather.wind} ",
                                style: H1BlackTextStyle.copyWith(
                                    color: Colors.black)),
                            Text("كم / سا",
                                style: H5BlackTextStyle.copyWith(
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
