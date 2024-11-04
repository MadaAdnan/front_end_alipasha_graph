import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/slider_component/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'logic.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({Key? key}) : super(key: key);

  final logic = Get.find<ServicesLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          return true;
        },
        child: Column(
          children: [
            HomeAppBarComponent(selected: 'service',),
            Expanded(
                child: Container(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.02.sw,
                  vertical: 0.01.sh,
                ),
                controller: scrollController,
                children: [

                  Obx(() {
                    if (logic.sliders.length > 0) {
                      return SliderComponent(items: logic.sliders);
                    }
                    return Container();
                  }),
                  15.verticalSpace,
                  Obx(() {
                    if (logic.loading.value) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                              child: Container(
                                width: 0.31.sw,
                                height: 0.31.sw,
                                color: RedColor,
                              ),
                              baseColor: GrayDarkColor,
                              highlightColor: GrayLightColor),
                          Shimmer.fromColors(
                              child: Container(
                                width: 0.31.sw,
                                height: 0.31.sw,
                                color: RedColor,
                              ),
                              baseColor: GrayDarkColor,
                              highlightColor: GrayLightColor),
                          Shimmer.fromColors(
                              child: Container(
                                width: 0.31.sw,
                                height: 0.31.sw,
                                color: RedColor,
                              ),
                              baseColor: GrayDarkColor,
                              highlightColor: GrayLightColor),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 0.26.sw,
                          height: 0.25.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.008.sw, vertical: 0.002.sh),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: GrayWhiteColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              // Dollar
                              Container(
                                alignment: Alignment.center,
                                width: 0.09.sw,
                                height: 0.09.sw,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: WhiteColor,
                                ),
                                child: Text(
                                  '\$',
                                  style: H1RedTextStyle.copyWith(
                                      color: Colors.black,fontSize: 55.sp),
                                ),
                              ),
                              15.verticalSpace,
                              RichText(text: TextSpan(children:[
                                TextSpan(text:  'مبيع ',
                                  style: H2RegularDark,),
                                TextSpan(text:' ${logic.dollar.value?.idlib?.usd?.sale} \$',
                                  style: H2BlackTextStyle.copyWith(
                                      color: Colors.black), )
                              ] )),
                              15.verticalSpace,
                              RichText(text: TextSpan(children:[
                                TextSpan(text:  'شـراء ',
                                  style: H2RegularDark,),
                                TextSpan(text:' ${logic.dollar.value?.idlib?.usd?.bay} \$',
                                  style: H2BlackTextStyle.copyWith(
                                      color: Colors.black), )
                              ] )),


                            ],
                          ),
                        ),
                        Container(
                          width: 0.26.sw,
                          height: 0.25.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.008.sw, vertical: 0.002.sh),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: GrayWhiteColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 0.09.sw,
                                height: 0.09.sw,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: WhiteColor,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.gem,
                                  size: 0.06.sw,
                                  color: Colors.black,
                                ),
                              ),
                              15.verticalSpace,
                              RichText(text: TextSpan(children:[
                                TextSpan(text:  'ذهـب  ',
                                  style: H2RegularDark,),
                                TextSpan(text:'${double.tryParse("${logic.gold.value?.idlib?.gold21?.bay}")} \$',
                                    style: H2BlackTextStyle.copyWith(
                                        color: Colors.black) )
                              ]),),
                              15.verticalSpace,
                              RichText(text: TextSpan(children:[
                                TextSpan(text:  'فضـة  ',
                                  style: H2RegularDark,),
                                TextSpan(text:'${double.tryParse("${logic.gold.value?.idlib?.sliver?.bay}")} \$',
                                    style: H2BlackTextStyle.copyWith(
                                        color: Colors.black) )
                              ]),),


                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(WEATHER_PAGE);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.008.sw, vertical: 0.002.sh),
                            width: 0.4.sw,
                            height: 0.25.sw,
                            decoration: BoxDecoration(
                              color: GrayWhiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 0.17.sw,
                                      height: 0.17.sw,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              '${logic.idlibWeather.first.icon}',
                                            ),

                                            fit: BoxFit.fitHeight,
                                            scale: 2),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${'${logic.idlibWeather.first.text}'
                                                  .weatherType()} ',
                                              style: H4RegularDark,
                                            ),
                                            Text(
                                              '${logic.idlibWeather.first.temp_c}'
                                                  .weatherType(),
                                              style: H2BlackTextStyle.copyWith(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'سرعة الرياح : ',
                                              style: H6RegularDark,
                                            ),
                                            Text(
                                              '${logic.idlibWeather.first.wind} كم /  سا',
                                              style: H6BlackTextStyle.copyWith(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                     Transform.translate(offset: Offset(-0.02.sw, 0),child:  Text(
                                       'إدلب',
                                       style: H2RegularDark,
                                     ),),
                                      Transform.translate(
                                        offset: Offset(-0.025.sw, 0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.007.sw,
                                              horizontal: 0.02.sw),
                                          decoration: BoxDecoration(
                                              color: GrayLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(30.r)),
                                          child: Text(
                                            'عرض المزيد',
                                            style: H4RegularDark.copyWith(
                                              color: DarkColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                  15.verticalSpace,
                  Container(
                    width: 1.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(PRAYER_PAGE);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.03.sw),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: GrayWhiteColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.mosque,
                                  color: DarkColor,
                                ),
                                Text(
                                  'مواقيت الصلاة',
                                  style: H5BlackTextStyle,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(GOLD_PAGE, arguments: 2);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.03.sw),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: GrayWhiteColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.oilWell,
                                  color: DarkColor,
                                ),
                                Text(
                                  'أسعار المحروقات',
                                  style: H5BlackTextStyle,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(SELLERS_PAGE);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.03.sw),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: GrayWhiteColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.truck,
                                  color: DarkColor,
                                ),
                                Text(
                                  'تجار الجملة',
                                  style: H5BlackTextStyle,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(GOLD_PAGE, arguments: 1);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.03.sw),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: GrayWhiteColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.dollarSign,
                                  color: DarkColor,
                                ),
                                Text(
                                  'أسعار العملات',
                                  style: H5BlackTextStyle,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(GOLD_PAGE, arguments: 0);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.03.sw),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: GrayWhiteColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.gem,
                                  color: DarkColor,
                                ),
                                Text(
                                  'أسعار المعادن',
                                  style: H5BlackTextStyle,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.verticalSpace,
                  Obx(() {
                    return Column(
                      children: [

                        ...List.generate(
                          logic.categories.length,
                          (index) => Column(children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(SERVICE_PAGE,
                                    arguments: logic.categories[index]);
                              },
                              child: Container(

                                padding:
                                EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.007.sh),
                                width: 1.sw,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: GrayLightColor),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 0.08.sw,
                                          height: 0.08.sw,
                                          alignment: Alignment.center,

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: GrayWhiteColor,
                                          ),
                                          child: Text(
                                            "${logic.categories[index].name?.substring(0,1)}",
                                            style: H3BlackTextStyle.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        10.horizontalSpace,
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${logic.categories[index].name}",
                                            style: H2RegularDark,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                    Badge.count(count: int.tryParse('${logic.categories[index].products2Count}')??0)

                                  ],
                                ),
                              ),
                            ),
                            15.verticalSpace,
                          ],),
                        )
                      ],
                    );
                  })
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
