import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ForgetPasswordPage extends StatelessWidget {
  final logic = Get.find<ForgetPasswordLogic>();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: RedColor,
        title: Text(
          'نسيت كلمة المرور',
          style: H3WhiteTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.1.sw),
        child: Obx(() {
          if(!logic.isSend.value){
            return Column(
              children: [
                Form(
                    key: _form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: TextFormField(
                            controller: logic.emailController,
                            validator: (value) {
                              if (value == '' || value == null) {
                                return "يرجى إدخال البريد الإلكتروني";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                    borderSide: BorderSide(
                                        color: GrayLightColor)),
                                label: Text(
                                  'البريد الإلكتروني',
                                  style: H4RegularDark,
                                ),
                                errorStyle: H4RedTextStyle
                            ),
                          ),
                        ),
                        SizedBox(height: 0.01.sh,),
                        Obx(() {
                          if (logic.loading.value) {
                            return InkWell(

                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 0.05.sw,
                                    vertical: 0.01.sh),
                                decoration: BoxDecoration(
                                  color: RedColor,
                                  borderRadius: BorderRadius.circular(30.r),

                                ),
                                child: Text('جاري إرسال الطلب',
                                  style: H3WhiteTextStyle,),
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              if (_form.currentState!.validate()) {
                                logic.requestChangePassword();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0.05.sw,
                                  vertical: 0.01.sh),
                              decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(30.r),

                              ),
                              child: Text('طلب تغيير كلمة المرور',
                                style: H3WhiteTextStyle,),
                            ),
                          );
                        })
                      ],
                    ))
              ],
            );
          }
          return Column(
            children: [
              Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: TextFormField(
                          controller: logic.codeController,
                          validator: (value) {
                            if (value == '' || value == null) {
                              return "يرجى إدخال الكود المرسل إلى بريدك الإلكتروني";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide: BorderSide(
                                      color: GrayLightColor)),
                              label: Text(
                                'الكود الخاص بك',
                                style: H4RegularDark,
                              ),
                              errorStyle: H4RedTextStyle
                          ),
                        ),
                      ),
                      SizedBox(height: 0.01.sh,),
                      Obx(() {
                        if (logic.loading.value) {
                          return InkWell(

                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0.05.sw,
                                  vertical: 0.01.sh),
                              decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(30.r),

                              ),
                              child: Text('جاري إرسال الطلب',
                                style: H3WhiteTextStyle,),
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            if (_form.currentState!.validate()) {
                              logic.requestChangePassword();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.05.sw,
                                vertical: 0.01.sh),
                            decoration: BoxDecoration(
                              color: RedColor,
                              borderRadius: BorderRadius.circular(30.r),

                            ),
                            child: Text('تغيير كلمة المرور',
                              style: H3WhiteTextStyle,),
                          ),
                        );
                      }),
                      SizedBox(height: 0.01.sh,),
                      Obx(() {
                        if (logic.loading.value) {
                          return InkWell(

                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0.05.sw,
                                  vertical: 0.01.sh),
                              decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(30.r),

                              ),
                              child: Text('جاري إرسال الطلب',
                                style: H3WhiteTextStyle,),
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {

                              logic.requestChangePassword();

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.05.sw,
                                vertical: 0.01.sh),
                            decoration: BoxDecoration(
                              color: RedColor,
                              borderRadius: BorderRadius.circular(30.r),

                            ),
                            child: Text('إعادة إرسال الرمز',
                              style: H3WhiteTextStyle,),
                          ),
                        );
                      })
                    ],
                  ))
            ],
          );
        }),
      ),
    );
  }
}
