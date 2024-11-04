import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class GoldPage extends StatelessWidget {
  GoldPage({Key? key}) : super(key: key);
  RxInt index = RxInt(Get.arguments??0);
  final logic = Get.find<GoldLogic>();
  PageController pageController = PageController(
    initialPage: Get.arguments??0,
    viewportFraction: 1,
  );
  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    _buldPages();
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.07.sh,
            color: RedColor,
            child: Obx(() {
              return Text(
                '${this.index.value == 0 ? 'أسعار الذهب والفضة' : this.index.value == 1 ? 'أسعار العملات' : "أسعار المحروقات"}',
                style: H3WhiteTextStyle,
              );
            }),
          ),
          Expanded(
              child: PageView(
            onPageChanged: (i) => index.value = i,
            controller: pageController,
            children: pages,
          )),
          Container(
            width: 0.9.sw,
            height: 0.1.sh,
            child: Column(
              children: [
                Container(
                  width: 0.9.sw,
                  alignment: Alignment.center,
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...List.generate(
                            pages.length,
                            (i) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w,),
                              width: 0.03.sw,
                              height: 0.03.sw,
                                  decoration: BoxDecoration(
                                      color: i == index.value
                                          ? RedColor
                                          : GrayDarkColor,
                                      shape: BoxShape.circle),
                                ))
                      ],
                    );
                  }),
                ),
                25.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (index.value == pages.length - 1) {
                          index.value = 0;
                        } else {
                          index.value++;
                        }
                        pageController.animateToPage(index.value,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      child: Text(
                        'التالي',
                        style: H2BlackTextStyle,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (index.value == 0) {
                          index.value = pages.length - 1;
                          ;
                        } else {
                          index.value--;
                        }
                        pageController.animateToPage(index.value,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      child: Text(
                        'السابق',
                        style: H2BlackTextStyle,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buldPages() {
    pages.clear();
    pages.add(_buildPage1());
    pages.add(_buildPage2());
    pages.add(_buildPage3());
  }

  _buildPage1() {
    return ListView(
      children: [
        70.verticalSpace,
        Container(
          width: 0.9.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.02.sh),
                width: 0.96.sw,
                decoration: BoxDecoration(
                    color: GrayWhiteColor,
                    border: Border.all(color: GrayDarkColor),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15.r),
                        right: Radius.circular(15.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          return Text(
                            '${logic.setting.value?.createdAt ?? ''}',
                            style: H2GrayTextStyle,
                          );
                        })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'إدلب',
                          style: H2GrayTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              30.verticalSpace,

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                        // border: Border.all(color: DarkColor,),
                        color: GrayWhiteColor),
                    child: Text(
                      'المادة',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                        // border: Border.all(color: DarkColor),
                        color: GrayWhiteColor),
                    child: Text(
                      'سعر الشراء',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      // border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر المبيع',
                      style: H2BlackTextStyle,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Obx(() {
                if (logic.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'ذهب عيار 24',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold24?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold24?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'ذهب عيار 21',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold21?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold21?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'ذهب عيار 18',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold18?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold18?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'الفضة',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold18?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.idlib?.gold18?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              })
            ],
          ),
        ),
        70.verticalSpace,
        Divider(),
        70.verticalSpace,
        Container(
          width: 0.9.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.02.sh),
                width: 0.96.sw,
                decoration: BoxDecoration(
                    color: GrayWhiteColor,
                    border: Border.all(color: GrayDarkColor),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15.r),
                        right: Radius.circular(15.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          return Text(
                            '${logic.setting.value?.createdAt ?? ''}',
                            style: H2GrayTextStyle,
                          );
                        })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'إعزاز',
                          style: H2GrayTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              30.verticalSpace,

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                        //border: Border.all(color: DarkColor),
                        color: GrayWhiteColor),
                    child: Text(
                      'المادة',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                        // border: Border.all(color: DarkColor),
                        color: GrayWhiteColor),
                    child: Text(
                      'سعر الشراء',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر المبيع',
                      style: H2BlackTextStyle,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Obx(() {
                if (logic.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'ذهب عيار 24',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            color: GrayWhiteColor,
                            // border: Border.all(color: DarkColor),
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold24?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold24?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            color: GrayWhiteColor,
                            // border: Border.all(color: DarkColor),
                          ),
                          child: Text(
                            'ذهب عيار 21',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            color: GrayWhiteColor,
                            //border: Border.all(color: DarkColor),
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold21?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            color: GrayWhiteColor,
                            // border: Border.all(color: DarkColor),
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold21?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'ذهب عيار 18',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold18?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold18?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'الفضة',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold18?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            // border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.gold?.izaz?.gold18?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  _buildPage2() {
    return ListView(
      children: [
        70.verticalSpace,
        Container(
          width: 1.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.02.sh),
                width: 0.96.sw,
                decoration: BoxDecoration(
                    color: GrayWhiteColor,
                    border: Border.all(color: GrayDarkColor),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15.r),
                        right: Radius.circular(15.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          return Text(
                            '${logic.setting.value?.createdAt ?? ''}',
                            style: H2GrayTextStyle,
                          );
                        })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'إدلب',
                          style: H2GrayTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              30.verticalSpace,

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'العملة',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر الشراء',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر المبيع',
                      style: H2BlackTextStyle,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Obx(() {
                if (logic.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'دولار',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.idlib?.usd?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.idlib?.usd?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'يورو',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.idlib?.eur?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.idlib?.eur?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'ليرة سورية',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.idlib?.syr?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.idlib?.syr?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              })
            ],
          ),
        ),
        70.verticalSpace,
        Divider(),
        70.verticalSpace,
        Container(
          width: 1.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.02.sh),
                width: 0.96.sw,
                decoration: BoxDecoration(
                    color: GrayWhiteColor,
                    border: Border.all(color: GrayDarkColor),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15.r),
                        right: Radius.circular(15.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          return Text(
                            '${logic.setting.value?.createdAt ?? ''}',
                            style: H2GrayTextStyle,
                          );
                        })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'إعزاز',
                          style: H2GrayTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              30.verticalSpace,

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'العملة',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر الشراء',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر المبيع',
                      style: H2BlackTextStyle,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Obx(() {
                if (logic.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'دولار',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.izaz?.usd?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.izaz?.usd?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'يورو',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.izaz?.eur?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.izaz?.eur?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            'ليرة سورية',
                            style: H2RegularDark,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.izaz?.syr?.sale}',
                            style: H2RegularDark,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 0.32.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: DarkColor),
                            color: GrayWhiteColor,
                          ),
                          child: Text(
                            '${logic.setting.value?.dollar?.izaz?.syr?.bay}',
                            style: H2RegularDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  _buildPage3() {
    return ListView(
      children: [
        70.verticalSpace,
        Container(
          width: 1.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.02.sh),
                width: 0.96.sw,
                decoration: BoxDecoration(
                    color: GrayWhiteColor,
                    border: Border.all(color: GrayDarkColor),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15.r),
                        right: Radius.circular(15.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          return Text(
                            '${logic.setting.value?.createdAt ?? ''}',
                            style: H2GrayTextStyle,
                          );
                        })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'إدلب',
                          style: H2GrayTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              30.verticalSpace,

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'المادة',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر الشراء',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر المبيع',
                      style: H2BlackTextStyle,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Obx(() {
                if (logic.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    ...List.generate(
                      logic.setting.value?.material_idlib?.length ?? 0,
                      (index) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 0.32.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  //  border: Border.all(color: DarkColor),
                                  color: GrayWhiteColor,
                                ),
                                child: Text(
                                  '${logic.setting.value?.material_idlib?[index].name}',
                                  style: H2RegularDark,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 0.32.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  //  border: Border.all(color: DarkColor),
                                  color: GrayWhiteColor,
                                ),
                                child: Text(
                                  '${logic.setting.value?.material_idlib?[index].sale}',
                                  style: H2RegularDark,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 0.32.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  //  border: Border.all(color: DarkColor),
                                  color: GrayWhiteColor,
                                ),
                                child: Text(
                                  '${logic.setting.value?.material_idlib?[index].bay}',
                                  style: H2RegularDark,
                                ),
                              ),
                            ],
                          ),
                          10.verticalSpace,
                        ],
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
        70.verticalSpace,
        Divider(),
        70.verticalSpace,
        Container(
          width: 1.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.02.sh),
                width: 0.96.sw,
                decoration: BoxDecoration(
                    color: GrayWhiteColor,
                    border: Border.all(color: GrayDarkColor),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15.r),
                        right: Radius.circular(15.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Obx(() {
                          return Text(
                            '${logic.setting.value?.createdAt ?? ''}',
                            style: H2GrayTextStyle,
                          );
                        })
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'إعزاز',
                          style: H2GrayTextStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
              30.verticalSpace,

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'المادة',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر الشراء',
                      style: H2BlackTextStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 0.32.sw,
                    height: 0.04.sh,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: DarkColor),
                      color: GrayWhiteColor,
                    ),
                    child: Text(
                      'سعر المبيع',
                      style: H2BlackTextStyle,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Obx(() {
                if (logic.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    ...List.generate(
                      logic.setting.value?.material_izaz?.length ?? 0,
                      (index) =>Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 0.32.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  //  border: Border.all(color: DarkColor),
                                  color: GrayWhiteColor,
                                ),
                                child: Text(
                                  '${logic.setting.value?.material_idlib?[index].name}',
                                  style: H2RegularDark,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 0.32.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  //  border: Border.all(color: DarkColor),
                                  color: GrayWhiteColor,
                                ),
                                child: Text(
                                  '${logic.setting.value?.material_idlib?[index].sale}',
                                  style: H2RegularDark,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 0.32.sw,
                                height: 0.04.sh,
                                decoration: BoxDecoration(
                                  //  border: Border.all(color: DarkColor),
                                  color: GrayWhiteColor,
                                ),
                                child: Text(
                                  '${logic.setting.value?.material_idlib?[index].bay}',
                                  style: H2RegularDark,
                                ),
                              ),
                            ],
                          ),
                          10.verticalSpace,
                        ],
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
