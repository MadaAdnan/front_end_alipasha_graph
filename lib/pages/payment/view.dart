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
        padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
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
                            text: 'رقم حسابك : ',
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
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),

                  width:1.sw,
                  child:Image.network("${mainController.settings.value?.shamCash}",width: 0.5.sw,height: 0.5.sw,)),
                SizedBox(
                  height: 0.01.sh,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  color: GrayLightColor,
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(text: TextSpan(children:
                      [
                        TextSpan(text: "رقم الحساب : ",style: H4RedTextStyle,),
                        TextSpan(text: "${mainController.settings.value?.wallet}",style: H4RegularDark,)
                      ])),
                      IconButton(onPressed: ()async {
                        await Clipboard.setData(ClipboardData(text: '${mainController.settings.value?.wallet}'));
                        mainController.showToast(text: 'تم نسخ المعرف بنجاح',type: 'success');
                      }, icon:Icon( FontAwesomeIcons.copy))
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.01.sh,
                ),
                Text("خطوات شحن الرصيد :",style: H2RegularDark,),
                Image(image: AssetImage('assets/images/payment/1.png')),
                SizedBox(
                  height: 0.01.sh,
                ),
                Image(image: AssetImage('assets/images/payment/2.png')),
                SizedBox(
                  height: 0.01.sh,
                ),
                Image(image: AssetImage('assets/images/payment/3.png')),
                SizedBox(
                  height: 0.01.sh,
                ),

              ],
            ),




          ],
        ),
      ),
    );
  }
}
