import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PaymentPage extends StatelessWidget {
  final logic = Get.put(PaymentLogic());
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'شحن الحساب',
          style: H3WhiteTextStyle,
        ),
        backgroundColor: RedColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.01.sh,
            ),
            Container(
              alignment: Alignment.center,
              width: 1.sw,
              child: Text(
                'طريقة شحن الرصيد عن طريق شام كاش',
                style: H2BlackTextStyle,
              ),
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Container(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'ملاحظة : ', style: H4RedTextStyle),
                    TextSpan(
                      text:
                          'قد يستغرق شحن الرصيد في حسابك في تطبيق علي باشا من 5 إلى 30 دقيقة',
                      style: H4RegularDark,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.01.sh),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  children: [
                    TextSpan(text: 'هام جداً : ', style: H4RedTextStyle),
                    WidgetSpan(
                        child: SizedBox(
                      height: 0.02.sh,
                    )),
                    TextSpan(
                      text:
                          'تأكد من إضافة المعرف الخاص بك في علي باشا إلى ملاحظات الحوالة في تطبيق شام كاش ',
                      style: H4RegularDark,
                    ),
                    WidgetSpan(
                        child: SizedBox(
                      height: 0.02.sh,
                    )),
                    WidgetSpan(
                        child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'معرفك الخاص هو : ',
                            style: H4RegularDark,
                          ),
                          TextSpan(
                            text: '${mainController.authUser.value?.id}',
                            style: H2RedTextBoldStyle,
                          ),
                        ])),
                        IconButton(
                            onPressed: ()async {
                             await Clipboard.setData(ClipboardData(text: '${mainController.authUser.value?.id}'));
                             mainController.showToast(text: 'تم نسخ المعرف بنجاح',type: 'success');
                            }, icon: Icon(FontAwesomeIcons.copy))
                      ],
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.1.sw,
                        height: 0.01.sh,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      Text(
                        "الخطوة الأولى : ",
                        style: H3RegularDark,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.01.sh,
                ),
                Image(image: AssetImage('assets/images/payment/payment1.jpg')),
              ],
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.1.sw,
                        height: 0.01.sh,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      Text(
                        "الخطوة الثانية : ",
                        style: H3RegularDark,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.01.sh,
                ),
                Image(image: AssetImage('assets/images/payment/payment2.jpg')),
              ],
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.1.sw,
                        height: 0.01.sh,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      Text(
                        "الخطوة الثالثة : ",
                        style: H3RegularDark,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.01.sh,
                ),
                Image(image: AssetImage('assets/images/payment/payment3.jpg')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
