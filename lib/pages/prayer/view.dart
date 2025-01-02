import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/style.dart';
import 'logic.dart';

class PrayerPage extends StatelessWidget {
  PrayerPage({Key? key}) : super(key: key);
  RxInt index = RxInt(0);
  final logic = Get.find<PrayerLogic>();
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.07.sh,
            color: RedColor,
            child: Text(
              'تطبيق علي باشا - مواقيت الصلاة',
              style: H3WhiteTextStyle,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (logic.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return PageView(
                controller: pageController,
                onPageChanged: (i) => index.value = i,
                children: [
                  _idlib(),
                  _izaz(),
                ],
              );
            }),
          ),
         Obx(() {
           return  Text('${logic.idlib.value?.hijri?.dayName} - ${logic.idlib.value?.hijri?.day} - ${logic.idlib.value?.hijri?.monthName} - ${logic.idlib.value?.hijri?.year}',style: H3GrayTextStyle,);
         }),
          30.verticalSpace,
          Container(
            width: 0.9.sw,
            height: 0.1.sh,
            child: Column(
              children: [
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.03.sw,
                        height: 0.03.sw,
                        decoration: BoxDecoration(
                            color: index.value == 0 ? RedColor : GrayLightColor,
                            shape: BoxShape.circle),
                      ),
                      10.horizontalSpace,
                      Container(
                        width: 0.03.sw,
                        height: 0.03.sw,
                        decoration: BoxDecoration(
                            color: index.value == 1 ? RedColor : GrayLightColor,
                            shape: BoxShape.circle),
                      )
                    ],
                  );
                }),
                25.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(

                      onTap: () {
                        if (index.value == 1) {
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
                        if (index.value == 1) {
                          index.value = 0;
                        } else {
                          index.value = 1;
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

  _idlib() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 1.sw,
            height: 0.15.sh,

            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: 0.96.sw,
              height: 0.07.sh,
              decoration: BoxDecoration(
                  border: Border.all(color: DarkColor,),
                  borderRadius: BorderRadius.circular(15.r),
                  color: GrayWhiteColor),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "مواقيت الصلاة في مدينة ", style: H3BlackTextStyle),
                  TextSpan(
                    text: "إدلب ",
                    style: H2RedTextStyle.copyWith(
                        decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: "وما حولها", style: H3BlackTextStyle),
                ]),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الصلاة',
                        style: H2BlackTextStyle,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'وقت الأذان',
                        style: H2BlackTextStyle,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                // Body
                if (logic.idlib.value?.hijri?.month == "9")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 0.48.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                          //  border: Border.all(color: DarkColor),
                          color: GrayWhiteColor,
                        ),
                        child: Text(
                          'الإمساك',
                          style: H2RegularDark,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 0.48.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                          //  border: Border.all(color: DarkColor),
                          color: GrayWhiteColor,
                        ),
                        child: Text(
                          '${logic.idlib.value?.imsak}',
                          style: H2RegularDark,
                        ),
                      ),
                    ],
                  ),
                if (logic.idlib.value?.hijri?.month == "9")
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الفجر',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.idlib.value?.fajr}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الشروق',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.idlib.value?.sunrice}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الظهر',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.idlib.value?.duhur}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'العصر',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.idlib.value?.asr}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'المغرب',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.idlib.value?.magrib}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'العشاء',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.idlib.value?.isha}',
                        style: H2RegularDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _izaz() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 1.sw,
            height: 0.15.sh,
            alignment: Alignment.center,
            child:Container(
              alignment: Alignment.center,
              width: 0.96.sw,
              height: 0.07.sh,
              decoration: BoxDecoration(
                border: Border.all(color: DarkColor,),
                  borderRadius: BorderRadius.circular(15.r),
                  color: GrayWhiteColor),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "مواقيت الصلاة في مدينة ", style: H3BlackTextStyle),
                  TextSpan(
                    text: "إعزاز ",
                    style: H2RedTextStyle.copyWith(
                        decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: "وما حولها", style: H3BlackTextStyle),
                ]),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الصلاة',
                        style: H2BlackTextStyle,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'وقت الأذان',
                        style: H2BlackTextStyle,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                // Body
                if (logic.izaz.value?.hijri?.month == "9")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 0.48.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                          //  border: Border.all(color: DarkColor),
                          color: GrayWhiteColor,
                        ),
                        child: Text(
                          'الإمساك',
                          style: H2RegularDark,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 0.48.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                          //  border: Border.all(color: DarkColor),
                          color: GrayWhiteColor,
                        ),
                        child: Text(
                          '${logic.izaz.value?.imsak}',
                          style: H2RegularDark,
                        ),
                      ),
                    ],
                  ),
                if (logic.izaz.value?.hijri?.month == "9")
                  10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الفجر',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.izaz.value?.fajr}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الشروق',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.izaz.value?.sunrice}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'الظهر',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.izaz.value?.duhur}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'العصر',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.izaz.value?.asr}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'المغرب',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.izaz.value?.magrib}',
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
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        'العشاء',
                        style: H2RegularDark,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 0.48.sw,
                      height: 0.04.sh,
                      decoration: BoxDecoration(
                        //  border: Border.all(color: DarkColor),
                        color: GrayWhiteColor,
                      ),
                      child: Text(
                        '${logic.izaz.value?.isha}',
                        style: H2RegularDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
