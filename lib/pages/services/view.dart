import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/slider_component/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/home_app_bar/custom_sliver_app_bar.dart';
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
            HomeAppBarComponent(),
            Expanded(
                child: Container(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.02.sw,
                  vertical: 0.02.sh,
                ),
                controller: scrollController,
                children: [

                  Container(
                    height: 0.06.sh,
                    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    child: FormBuilderTextField(
                      name: 'section',
                      onChanged: (value) => logic.search.value = value,
                      decoration: InputDecoration(
                        labelText: 'بحث',
                        labelStyle: H3GrayTextStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  15.verticalSpace,
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
                          Shimmer.fromColors(child:Container(
                            width: 0.31.sw,
                            height: 0.31.sw,
                            color: RedColor,
                          ) , baseColor: GrayDarkColor, highlightColor: GrayLightColor),
                          Shimmer.fromColors(child:Container(
                            width: 0.31.sw,
                            height: 0.31.sw,
                            color: RedColor,
                          ) , baseColor: GrayDarkColor, highlightColor: GrayLightColor),
                          Shimmer.fromColors(child:Container(
                            width: 0.31.sw,
                            height: 0.31.sw,
                            color: RedColor,
                          ) , baseColor: GrayDarkColor, highlightColor: GrayLightColor),

                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 0.24.sw,
                          height: 0.24.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.008.sw, vertical: 0.002.sh),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: RedColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'مبيع',
                                      style: H2RegularDark.copyWith(
                                          color: WhiteColor),
                                    ),
                                    20.horizontalSpace,
                                    Container(
                                      alignment: Alignment.center,
                                      width: 0.05.sw,
                                      height: 0.05.sw,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: WhiteColor,
                                      ),
                                      child: Text(
                                        '\$',
                                        style: H2RedTextStyle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              15.verticalSpace,
                              Text(
                                '${logic.dollar.value?.idlib?.usd?.sale} \$',
                                style: H2WhiteTextStyle,
                              ),
                              15.verticalSpace,
                              Text(
                                'شراء',
                                style: H2RegularDark.copyWith(
                                    color: WhiteColor),
                              ),
                              15.verticalSpace,
                              Text(
                                '${logic.dollar.value?.idlib?.usd?.bay} \$',
                                style: H2WhiteTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 0.24.sw,
                          height: 0.24.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.008.sw, vertical: 0.002.sh),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: GoldColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ذهب',
                                      style: H2RegularDark.copyWith(
                                          color: WhiteColor),
                                    ),
                                    20.horizontalSpace,
                                    Container(
                                      alignment: Alignment.center,
                                      width: 0.05.sw,
                                      height: 0.05.sw,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: WhiteColor,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.gem,
                                        size: 0.04.sw,
                                        color: GoldColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              15.verticalSpace,
                              Text(
                                '${logic.gold.value?.idlib?.gold21?.bay} \$',
                                style: H2WhiteTextStyle,
                              ),
                              15.verticalSpace,
                              Text(
                                'فضة',
                                style: H2RegularDark.copyWith(
                                    color: WhiteColor),
                              ),
                              15.verticalSpace,
                              Text(
                                '${logic.gold.value?.idlib?.sliver?.bay} \$',
                                style: H2WhiteTextStyle,
                              ),
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
                            height: 0.24.sw,
                            decoration: BoxDecoration(
                              color: RedColor,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        '${logic.idlibWeather.first.icon}',
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${logic.idlibWeather.first.text}'
                                                  .weatherType(),
                                              style: H5WhiteTextStyle,
                                            ),
                                            Text(
                                              '${logic.idlibWeather.first.temp_c}'
                                                  .weatherType(),
                                              style: H1WhiteTextStyle,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'سرعة الرياح : ',
                                              style: H6WhiteTextStyle,
                                            ),
                                            Text(
                                              '${logic.idlibWeather.first.wind} كم /  سا',
                                              style: H6WhiteTextStyle,
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
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'إدلب',
                                        style: H2RegularDark.copyWith(
                                          color: WhiteColor,
                                        ),
                                      ),
                                      Text(
                                        'عرض المزيد',
                                        style: H2RegularDark.copyWith(
                                          color: WhiteColor,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
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
                        ... List.generate(logic.filterCategory.length,
                              ( index) => InkWell(
                            onTap: () {
                              Get.toNamed(SERVICE_PAGE,
                                  arguments: logic.filterCategory[index]);
                            },
                            child: Container(
                              margin:
                              EdgeInsets.symmetric(vertical: 0.02.sh),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.02.sw),
                              width: 1.sw,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(color: GrayLightColor),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0.05.sw,
                                            vertical: 0.05.sw),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                          RedColor.withOpacity(0.3),
                                        ),
                                        child: Text(
                                          "${logic.filterCategory[index].name?[0]}",
                                          style: H3RedTextStyle,
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${logic.filterCategory[index].name}",
                                          style: H2RegularDark,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '${logic.filterCategory[index].products2Count}',
                                    style: H2RegularDark,
                                  )
                                ],
                              ),
                            ),
                          ),
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
