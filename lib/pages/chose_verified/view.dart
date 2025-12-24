import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:easy_radio/easy_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../helpers/colors.dart';
import 'logic.dart';

class ChooseVerifiedPage extends StatelessWidget {
  ChooseVerifiedPage({Key? key}) : super(key: key);

  final ChooseVerifiedLogic logic = Get.put(ChooseVerifiedLogic());
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('توثيق الحساب'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.topRight,
        width: 1.sw,
        height: 1.sh,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.01.sh),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'احصل على الإشارة الزرقاء لحسابك الآن!',
                  style: H1RegularDark.copyWith(color: Colors.blueAccent),
                ),
                Text('لتوثيق حسابك والحصول على الإشارة الزرقاء(حساب موثق).',
                    style: H4BlackTextStyle),
                SizedBox(
                  height: 20,
                ),
                Text('اختر نوع التوثيق',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return EasyRadio(
                          value: 'record',
                          groupValue: logic.type.value,
                          activeBorderColor: Colors.blueAccent,
                          dotColor: Colors.blueAccent,
                          dotStyle: DotStyle.check(),
                          onChanged: (value) {
                            logic.type.value = value ?? '';
                          });
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          logic.type.value = 'record';
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('التوثيق التجاري',
                                style: H3RegularDark.copyWith(
                                    color: Colors.blueAccent)),
                            Text('قدم صورة من السجل التجاري مع الهوية',
                                style: H4BlackTextStyle),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 0.03.sh,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() {
                      return EasyRadio(
                        value: 'identity',
                        activeBorderColor: Colors.blueAccent,
                        dotColor: Colors.blueAccent,
                        dotStyle: DotStyle.check(),
                        groupValue: logic.type.value,
                        onChanged: (value) {
                          logic.type.value = value ?? '';
                        },
                      );
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          logic.type.value = 'identity';
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'التوثيق الشخصي',
                              style: H3RegularDark.copyWith(
                                  color: Colors.blueAccent),
                            ),
                            Text(
                              'قدم صورة الهوية فقط',
                              style: H4BlackTextStyle,
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 0.05.sh,
                ),
                Text(
                  'ملاحظات هامة:',
                  style: H1BlackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Row(
                  children: [
                    Container(
                      width: 0.013.sw,
                      height: 0.013.sw,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Text(
                      'تأكد من صحة الوثائق ووضوح الصور لتسريع العملية.',
                      style: H4BlackTextStyle,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 0.013.sw,
                      height: 0.013.sw,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Text(
                      'بعد التحقق سيتم توثيق حسابك على الفور.',
                      style: H4BlackTextStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 0.05.sh,
                ),
                Container(
                    width: 1.sw,
                    padding: EdgeInsets.symmetric(vertical: 0.02.sh),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text('تقديم الوثائق',
                            style: H3WhiteTextStyle.copyWith(
                                color: Colors.blueAccent)),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(IDENTITY_VERIFICATION_PAGE,
                                arguments: logic.type.value);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.01.sh, horizontal: 0.05.sw),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Text(
                              'تقديم الوثائق',
                              style: H3WhiteTextStyle,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 0.05.sh,
                ),
                Text(
                  'تواصل معنا:',
                  style: H3BlackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Row(
                  children: [
                    Container(
                      width: 0.013.sw,
                      height: 0.013.sw,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    InkWell(
                        onTap: () {
                          String url =
                              "https://wa.me/${mainController.settings.value.social?.phone}?text=السلام عليكم ورحمة الله وبركاته";
                          openUrl(url: url);
                        },
                        child: Text(
                          'للأستفسار تواصل عبر الدعم الفني',
                          style: H4BlackTextStyle,
                        ))
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
