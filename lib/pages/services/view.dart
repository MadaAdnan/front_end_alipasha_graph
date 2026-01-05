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
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

import 'logic.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({Key? key}) : super(key: key);

  final logic = Get.find<ServicesLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController scrollController = ScrollController();
  bool exit = false;

  @override
  Widget build(BuildContext context) {
    exit = false;
    return WillPopScope(
      child: Scaffold(
        floatingActionButton: _buildFloatingActions(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        backgroundColor: WhiteColor,
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            return true;
          },
          child: Column(
            children: [
              AppBarComponent2(
                selected: 'service',
              ),
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
                                    baseColor: GrayDarkColor,
                                    highlightColor: GrayLightColor,
                                    child: Container(
                                      width: 0.31.sw,
                                      height: 0.31.sw,
                                      color: PrimaryColor,
                                    )),
                                Shimmer.fromColors(
                                    baseColor: GrayDarkColor,
                                    highlightColor: GrayLightColor,
                                    child: Container(
                                      width: 0.31.sw,
                                      height: 0.31.sw,
                                      color: PrimaryColor,
                                    )),
                                Shimmer.fromColors(
                                    baseColor: GrayDarkColor,
                                    highlightColor: GrayLightColor,
                                    child: Container(
                                      width: 0.31.sw,
                                      height: 0.31.sw,
                                      color: PrimaryColor,
                                    )),
                              ],
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.005.sw),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 31,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(GOLD_PAGE, arguments: 1);
                                    },
                                    child: Container(
                                      height: 0.35.sw,
                                      padding: EdgeInsets.all(0.02.sw),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            16.r),
                                        color: GrayWhiteColor,
                                        border: Border.all(
                                            color: GrayLightColor, width: 1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 0.11.sw,
                                            height: 0.11.sw,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green.shade50,
                                            ),
                                            child: Text(
                                              '\$',
                                              style: H1BlackTextStyle.copyWith(
                                                  color: Colors.green.shade700,
                                                  fontSize: 0.07.sw),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'مبيع',
                                                style: H5RegularDark.copyWith(
                                                    fontSize: 0.028.sw),
                                              ),
                                              SizedBox(height: 0.002.sh),
                                              Text(
                                                '${logic.dollar.value?.idlib
                                                    ?.syr?.sale} ل.س',
                                                style: H3BlackTextStyle
                                                    .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 0.032.sw),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'شراء',
                                                style: H5RegularDark.copyWith(
                                                    fontSize: 0.028.sw),
                                              ),
                                              SizedBox(height: 0.002.sh),
                                              Text(
                                                '${logic.dollar.value?.idlib
                                                    ?.syr?.bay} ل.س',
                                                style: H3BlackTextStyle
                                                    .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 0.032.sw),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 0.015.sw),
                                Expanded(
                                  flex: 31,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(GOLD_PAGE, arguments: 0);
                                    },
                                    child: Container(
                                      height: 0.35.sw,
                                      padding: EdgeInsets.all(0.02.sw),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            16.r),
                                        color: GrayWhiteColor,
                                        border: Border.all(
                                            color: GrayLightColor, width: 1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 0.11.sw,
                                            height: 0.11.sw,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.amber.shade50,
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.gem,
                                              size: 0.06.sw,
                                              color: Colors.amber.shade700,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'ذهب',
                                                style: H5RegularDark.copyWith(
                                                    fontSize: 0.028.sw),
                                              ),
                                              SizedBox(height: 0.002.sh),
                                              Text(
                                                '${double.tryParse(
                                                    "${logic.gold.value?.idlib
                                                        ?.gold21?.bay}")} \$',
                                                style: H3BlackTextStyle
                                                    .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 0.032.sw),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'فضة',
                                                style: H5RegularDark.copyWith(
                                                    fontSize: 0.028.sw),
                                              ),
                                              SizedBox(height: 0.002.sh),
                                              Text(
                                                '${double.tryParse(
                                                    "${logic.gold.value?.idlib
                                                        ?.sliver?.bay}")} \$',
                                                style: H3BlackTextStyle
                                                    .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 0.032.sw),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 0.015.sw),
                                Expanded(
                                  flex: 33,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(WEATHER_PAGE);
                                    },
                                    child: Container(
                                      height: 0.35.sw,
                                      padding: EdgeInsets.all(0.02.sw),
                                      decoration: BoxDecoration(
                                        color: GrayWhiteColor,
                                        borderRadius: BorderRadius.circular(
                                            16.r),
                                        border: Border.all(
                                            color: GrayLightColor, width: 1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 0.11.sw,
                                            height: 0.11.sw,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue.shade50,
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider(
                                                  '${logic.idlibWeather.first
                                                      .icon}',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '${'${logic.idlibWeather.first
                                                    .text}'.weatherType()}',
                                                style: H5RegularDark.copyWith(
                                                    fontSize: 0.028.sw),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 0.002.sh),
                                              Text(
                                                '${logic.idlibWeather.first
                                                    .temp_c}°',
                                                style: H2BlackTextStyle
                                                    .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 0.045.sw),
                                              ),
                                            ],
                                          ),
                                          Obx(() {
                                            return Text(
                                              '${logic.nameCity}',
                                              style: H4BlackTextStyle.copyWith(
                                                  fontSize: 0.032.sw),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                        15.verticalSpace,
                        Wrap(
                          spacing: 0.02.sw,
                          runSpacing: 0.02.sw,
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(PRAYER_PAGE);
                              },
                              child: Container(
                                width: 0.22.sw,
                                height: 0.22.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: GrayWhiteColor,
                                  border:
                                  Border.all(color: GrayLightColor, width: 1),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 0.1.sw,
                                      height: 0.1.sw,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.purple.shade50,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.mosque,
                                        color: Colors.purple.shade700,
                                        size: 0.05.sw,
                                      ),
                                    ),
                                    SizedBox(height: 0.01.sh),
                                    Text(
                                      'مواقيت\nالصلاة',
                                      style: H5BlackTextStyle.copyWith(
                                          fontSize: 0.03.sw),
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
                                width: 0.22.sw,
                                height: 0.22.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: GrayWhiteColor,
                                  border:
                                  Border.all(color: GrayLightColor, width: 1),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 0.1.sw,
                                      height: 0.1.sw,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orange.shade50,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.oilWell,
                                        color: Colors.orange.shade700,
                                        size: 0.05.sw,
                                      ),
                                    ),
                                    SizedBox(height: 0.01.sh),
                                    Text(
                                      'أسعار\nالمحروقات',
                                      style: H5BlackTextStyle.copyWith(
                                          fontSize: 0.03.sw),
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
                                width: 0.22.sw,
                                height: 0.22.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: GrayWhiteColor,
                                  border:
                                  Border.all(color: GrayLightColor, width: 1),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 0.1.sw,
                                      height: 0.1.sw,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green.shade50,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.dollarSign,
                                        color: Colors.green.shade700,
                                        size: 0.05.sw,
                                      ),
                                    ),
                                    SizedBox(height: 0.01.sh),
                                    Text(
                                      'أسعار\nالعملات',
                                      style: H5BlackTextStyle.copyWith(
                                          fontSize: 0.03.sw),
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
                                width: 0.22.sw,
                                height: 0.22.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: GrayWhiteColor,
                                  border:
                                  Border.all(color: GrayLightColor, width: 1),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 0.1.sw,
                                      height: 0.1.sw,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.amber.shade50,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.gem,
                                        color: Colors.amber.shade700,
                                        size: 0.05.sw,
                                      ),
                                    ),
                                    SizedBox(height: 0.01.sh),
                                    Text(
                                      'أسعار\nالمعادن',
                                      style: H5BlackTextStyle.copyWith(
                                          fontSize: 0.03.sw),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        15.verticalSpace,
                        Obx(() {
                          return Column(
                            children: [
                              ...List.generate(
                                logic.categories.length,
                                    (index) =>
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Logger()
                                                .f(logic.categories[index]
                                                .toJson());
                                            Get.toNamed(SERVICE_PAGE,
                                                arguments: logic
                                                    .categories[index]);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.04.sw,
                                                vertical: 0.015.sh),
                                            width: 1.sw,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: GrayLightColor,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: 0.1.sw,
                                                        height: 0.1.sw,
                                                        alignment: Alignment
                                                            .center,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          color: GrayWhiteColor,
                                                        ),
                                                        child: Text(
                                                          "${logic
                                                              .categories[index]
                                                              .name?.substring(
                                                              0, 1)}",
                                                          style:
                                                          H2BlackTextStyle
                                                              .copyWith(
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ),
                                                      SizedBox(width: 0.03.sw),
                                                      Expanded(
                                                        child: Text(
                                                          "${logic
                                                              .categories[index]
                                                              .name}",
                                                          style: H2RegularDark,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 0.02.sw),
                                                Badge.count(
                                                    count: int.tryParse(
                                                        '${logic
                                                            .categories[index]
                                                            .products2Count}') ??
                                                        0),
                                              ],
                                            ),
                                          ),
                                        ),
                                        15.verticalSpace,
                                      ],
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
      ),
      onWillPop: () {
        if (exit == true) {
          Get.offNamed(HOME_PAGE);
        } else {
          scrollController.animateTo(0,
              duration: Duration(microseconds: 100), curve: Curves.linear);
          exit = true;
        }
        return Future.value(false);
      },
    );
  }

  Widget _buildFloatingActions() {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCreateProductButton(),
          SizedBox(height: 0.01.sh),
          if (mainController.carts.isNotEmpty) _buildCartButton(),
          SizedBox(height: 0.02.sh),
        ],
      );
    });
  }

  Widget _buildCreateProductButton() {
    return FloatingActionButton(
      key: mainController.createProductKey,
      onPressed: () => Get.toNamed(CREATE_SERVICE_PAGE),
      backgroundColor: PrimaryColor.withOpacity(0.7),
      mini: true,
      child: const Icon(FontAwesomeIcons.plus, color: WhiteColor),
    );
  }

  Widget _buildCartButton() {
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: () => Get.toNamed(CART_SELLER),
          backgroundColor: PrimaryColor.withOpacity(0.7),
          mini: true,
          child: const Icon(FontAwesomeIcons.cartShopping, color: WhiteColor),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Badge.count(
            count: mainController.carts.length,
            backgroundColor: PrimaryColor,
          ),
        ),
      ],
    );
  }
}
