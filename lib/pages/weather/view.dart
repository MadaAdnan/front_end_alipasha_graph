import 'package:ali_pasha_graph/Global/main_controller.dart';
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
      PageController(initialPage: 0, viewportFraction: 0.8,keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                   child:  ListView(
                     children: [
                       Container(
                         width: 0.7.sw,
                         height: 0.08.sh,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           color:GrayWhiteColor,
                           border: Border.all(color: GrayDarkColor),
                           borderRadius: BorderRadius.circular(15.r),
                         ),
                         child: Text('مدينة إدلب',style: H2RegularDark,),
                       ),
                       15.verticalSpace,
                       ...List.generate(
                           logic.idlibWeather.length,
                               (index) =>
                               _buildToday(weather: logic.idlibWeather[index]))
                     ],
                   ),
                 ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
                    width: 0.8.sw,
                    child:  ListView(

                      children: [
                        Container(
                          width: 0.7.sw,
                          height: 0.08.sh,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:GrayWhiteColor,
                            border: Border.all(color: GrayDarkColor),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text('مدينة إعزاز',style: H2RegularDark,),
                        ),
                        15.verticalSpace,
                        ...List.generate(
                            logic.izazWeather.length,
                                (index) =>
                                _buildToday(weather: logic.izazWeather[index])),
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

  _buildToday({required WeatherModel weather}) {
    return Column(
      children: [
        Card(
          child: Container(
            alignment: Alignment.center,
            padding:
                EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.03.sh),
            width: 0.8.sw,
            child: Column(
              children: [
                Text("${weather.date}",style: H4BlackTextStyle,),
                CachedNetworkImage(imageUrl: "${weather.icon}"),
                Text("${weather.text}".weatherType(),style: H3BlackTextStyle,),
                RichText(text: TextSpan(children: [
                  TextSpan(text: " درجة الحرارة : ",style: H3BlackTextStyle),
                  TextSpan(text: "${weather.temp_c}  ",style: H3RedTextStyle),
                  TextSpan(text: "\u00B0C",style: H1RedTextStyle),
                ])),
                RichText(text: TextSpan(children: [
                  TextSpan(text: " سرعة الرياح : ",style: H3BlackTextStyle),
                  TextSpan(text: "${weather.wind} ",style: H2RedTextStyle),
                  TextSpan(text: " كم / سا ",style: H6RedTextStyle),
                ]))
              ],
            ),
          ),
        ),
        Card(),
      ],
    );
  }
}
