import 'dart:ui';

import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.find<LoginLogic>();
  RxBool secure = RxBool(true);
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.05.sh),
              width: 1.sw,
              height: 0.2.sh,
              color: RedColor,
              child: const Image(
                image: AssetImage(
                  'assets/images/png/logo-alipasha.png',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
            15.verticalSpace,
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.001.sw, vertical: 0.02.sh),
              child: Transform.translate(
                offset: Offset(0,-0.05.sh),
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.1.sh),
                  decoration: BoxDecoration(
                    color: WhiteColor,
                    borderRadius: BorderRadius.circular(30.r)
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        InputComponent(
                          fill: WhiteColor,
                          controller: logic.usernameController,
                          suffixIcon: FontAwesomeIcons.user,
                          width: 0.9.sw,
                          isRequired: true,
                          validation: (value) {
                            if (value?.length == 0) {
                              return "يرجى إدخال اسم المستخدم أو البريد الإلكتروني";
                            } else {
                              return null;
                            }
                          },
                          hint: 'البريد الإلكتروني أو اسم المستخدم',
                        ),
                        15.verticalSpace,
                        Obx(() {
                          return InputComponent(
                            fill: WhiteColor,
                            controller: logic.passwordController,
                            isSecure: secure.value,
                            suffixIcon: secure.value
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            suffixClick: () {
                              secure.value = !secure.value;
                            },
                            width: 0.9.sw,
                            isRequired: true,
                            validation: (value) {
                              if (value?.length == 0) {
                                return "كلمة المرور مطلوبة";
                              } else {
                                return null;
                              }
                            },
                            hint: 'كلمة المرور',
                          );
                        }),
                        GestureDetector(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: H4BlackTextStyle.copyWith(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        15.verticalSpace,
                        Obx(() {
                          if (logic.loading.value) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              if (_form.currentState!.validate()) {
                                logic.login();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 0.9.sw,
                              height: 0.12.sw,
                              decoration: BoxDecoration(
                                  color: RedColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Text(
                                'تسجيل الدخول',
                                style: H3WhiteTextStyle,
                              ),
                            ),
                          );
                        }),
                        25.verticalSpace,
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              '- أو -',
                              style: H1BlackTextStyle,
                            )),
                        25.verticalSpace,
                        InkWell(
                          onTap: () async {
                            logic.registerGoogel();
                          },
                          child: Container(
                            width: 0.9.sw,
                            height: 0.12.sw,
                            decoration: BoxDecoration(
                                color: GrayLightColor,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'التسجيل السريع بإستخدام ',
                                  style: H3BlackTextStyle,
                                ),
                                Icon(
                                  FontAwesomeIcons.google,
                                  color: RedColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        50.verticalSpace,
                        Container(
                          width: 0.9.sw,
                          height: 0.12.sw,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: GrayLightColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.offAndToNamed(REGISTER_PAGE);
                            },
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(text: 'ليس لديك حساب ؟ ', style: H4BlackTextStyle),
                                TextSpan(
                                    text: ' أنشئ حساب جديد',
                                    style: H2OrangeTextStyle.copyWith(
                                        decoration: TextDecoration.underline)),
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
