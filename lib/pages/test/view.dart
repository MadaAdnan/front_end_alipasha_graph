import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'logic.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  final logic = Get.find<TestLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.04.sh, horizontal: 0.02.sw),
        child: Container(
          padding: EdgeInsets.only(top: 0.02.sh, right: 0.02.sw,left: 0.02.sw),

          decoration: BoxDecoration(
              color: WhiteColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, blurRadius: 0.5.r, spreadRadius: 0.1.r)
              ],
              borderRadius: BorderRadius.circular(30.r)),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  width: 0.2.sw,
                  child: LottieBuilder.asset('assets/json/verified.json'),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'مميزات توثيق الحساب',
                    style: H1RedTextStyle.copyWith(color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 0.01.sh,
                ),

                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'عند توثيق الحساب، ستحصل على العديد من الامتيازات:',
                    style: H3RegularDark,
                  ),
                ),
                SizedBox(
                  height: 0.04.sh,
                ),

                //LIST
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.circleCheck,
                            size: 0.04.sw,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Expanded(
                              child: Text('علامة الحساب موثق ',
                                  style: H3BlackTextStyle)),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                          ),
                          Text('تميز حسابك كحساب رسمي يمثل الشركة أو المنظمة.',
                              style:
                              H3GrayTextStyle.copyWith(height: 0.002.sh)),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.01.sh,
                ),
                //LIST
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.circleCheck,
                            size: 0.04.sw,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Text('علامة المنتجات الموثوقة ',
                              style: H3BlackTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                          ),
                          Expanded(
                              child: Text(
                                  'تظهر على كل منتج أو منشور لك، مما يعزز ثقة العملاء بالجودة.',
                                  style: H3GrayTextStyle.copyWith(
                                      height: 0.002.sh))),
                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 0.01.sh,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.circleCheck,
                            size: 0.04.sw,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Text('هوية بصرية فريدة', style: H3BlackTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                          ),
                          Expanded(
                              child: Text(
                                  'إمكانية اختيار هوية بصرية خاصة بالشركة تعكس رسالتها وتميزها.',
                                  style: H3GrayTextStyle.copyWith(
                                      height: 0.002.sh))),
                        ],
                      )
                    ],
                  ),
                ),
                //LIST

                SizedBox(
                  height: 0.01.sh,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.circleCheck,
                            size: 0.04.sw,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Text('معرض صور للأعمال', style: H3BlackTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                          ),
                          Expanded(
                              child: Text(
                                  'عرض صور لمنتجات وأعمال الشركة لإبراز جودة الخدمات والمنتجات.',
                                  style: H3GrayTextStyle.copyWith(
                                      height: 0.002.sh))),
                        ],
                      )
                    ],
                  ),
                ),
                //LIST

                SizedBox(
                  height: 0.01.sh,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.circleCheck,
                            size: 0.04.sw,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Text('روابط حسابات التواصل الاجتماعي',
                              style: H3BlackTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                          ),
                          Expanded(
                              child: Text(
                                  'إضافة معرفات الشركة على السوشيال ميديا لتسهيل الوصول إلى حساباتها الرسمية.',
                                  style: H3GrayTextStyle.copyWith(
                                      height: 0.002.sh))),
                        ],
                      )
                    ],
                  ),
                ),
                //LIST

                SizedBox(
                  height: 0.01.sh,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.circleCheck,
                            size: 0.04.sw,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Text('وصف مختصر (Slogan) للشركة',
                              style: H3BlackTextStyle),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                          ),
                          Expanded(
                              child: Text(
                                  'إدراج وصف ملهم يعبرعن رؤية ورسالة الشركة في ملفها الشخصي.',
                                  style: H3GrayTextStyle.copyWith(
                                      height: 0.002.sh))),
                        ],
                      )
                    ],
                  ),
                ),
                //LIST
                SizedBox(
                  height: 0.03.sh,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: 0.75.sw,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.02.sh, horizontal: 0.03.sw),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.blue
                    ),
                    child: Text(
                      'طلب توثيق الحساب',
                      style: H4WhiteTextStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.03.sh,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
