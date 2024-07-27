import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/fields_components/select2_component.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final logic = Get.find<RegisterLogic>();
  RxBool secure = RxBool(true);
  RxBool confirmSecure = RxBool(true);
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: WhiteColor,
      body:  Container(
        color: WhiteColor,
        child: Column(
          children: [
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 0.07.sw, vertical: 0.02.sh),
              width: 1.sw,
              height: 0.2.sh,
              decoration: BoxDecoration(
                color: RedColor,
              ),
              child: const Image(
                image: AssetImage(
                  'assets/images/png/logo-alipasha.png',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
            15.verticalSpace,
            Transform.translate(
              offset: Offset(0,-0.02.sh),
              child: Container(
                height: 0.73.sh,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50.r),topRight:  Radius.circular(50.r)),
                    color: WhiteColor),
                padding: EdgeInsets.symmetric(
                    horizontal: 0.05.sw, vertical: 0.02.sh),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                  child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InputComponent(
                            fill: WhiteColor,
                            width: 1.sw,
                            controller: logic.nameController,
                            suffixIcon: FontAwesomeIcons.user,
                            textInputType: TextInputType.text,
                            isRequired: true,
                            hint: 'الاسم',
                            validation: (value) {
                              if (value?.length == 0) {
                                return "الاسم مطلوب";
                              }
                              return null;
                            },
                          ),
                          Obx(() {
                            return Visibility(
                                visible: logic.errorName.value != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${logic.errorName.value}",
                                    style: H4RedTextStyle,
                                  ),
                                ));
                          }),
                          /*  15.verticalSpace,
                                          InputComponent(
                                            fill: WhiteColor,
                                            width: 1.sw,
                                            controller: logic.userNameController,
                                            suffixIcon: FontAwesomeIcons.idCard,
                                            textInputType: TextInputType.text,
                                            isRequired: true,
                                            hint: 'اسم المستخدم',
                                            validation: (value) {
                                              if (value?.length == 0) {
                                                return "اسم المستخدم مطلوب";
                                              }
                                              return null;
                                            },
                                          ),*/
                          15.verticalSpace,
                          InputComponent(
                            fill: WhiteColor,
                            width: 1.sw,
                            controller: logic.emailController,
                            suffixIcon: FontAwesomeIcons.envelope,
                            textInputType: TextInputType.emailAddress,
                            isRequired: true,
                            hint: 'البريد الإلكتروني',
                            validation: (value) {
                              if (value?.length == 0) {
                                return "البريد الإلكتروني مطلوب";
                              }
                              if (!value!.isEmail) {
                                return "يرجى إدخال بريد إلكتروني صالح";
                              }
                              return null;
                            },
                          ),
                          Obx(() {
                            return Visibility(
                                visible: logic.errorEmail.value != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${logic.errorEmail.value}",
                                    style: H4RedTextStyle,
                                  ),
                                ));
                          }),
                          15.verticalSpace,
                          Obx(() {
                            return InputComponent(
                              fill: WhiteColor,
                              isSecure: secure.value,
                              width: 1.sw,
                              controller: logic.passwordController,
                              suffixIcon: secure.value
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              suffixClick: () {
                                secure.value = !secure.value;
                              },
                              textInputType: TextInputType.visiblePassword,
                              isRequired: true,
                              hint: 'كلمة المرور',
                              validation: (value) {
                                if (value?.length == 0) {
                                  return "كلمة المرور مطلوبة";
                                }
                                if (value!.length < 8) {
                                  return "يجب ان تحتوي كلمة المرور 8 أحرف على الأقل";
                                }
                                return null;
                              },
                            );
                          }),
                          Obx(() {
                            return Visibility(
                                visible: logic.errorPassword.value != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${logic.errorPassword.value}",
                                    style: H4RedTextStyle,
                                  ),
                                ));
                          }),
                          15.verticalSpace,
                          Obx(() {
                            return InputComponent(
                              fill: WhiteColor,
                              isSecure: confirmSecure.value,
                              width: 1.sw,
                              controller: logic.confirmPasswordController,
                              suffixIcon: confirmSecure.value
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              suffixClick: () {
                                confirmSecure.value = !confirmSecure.value;
                              },
                              textInputType: TextInputType.visiblePassword,
                              isRequired: true,
                              hint: 'تأكد كلمة المرور',
                              validation: (value) {
                                if (value !=
                                    logic.passwordController.text) {
                                  return "كلمة المرور غير متطابقة";
                                }
                                return null;
                              },
                            );
                          }),
                          15.verticalSpace,
                          InputComponent(
                            fill: WhiteColor,
                            width: 1.sw,
                            controller: logic.phoneController,
                            suffixIcon: FontAwesomeIcons.mobileScreen,
                            textInputType: TextInputType.phone,
                            isRequired: true,
                            hint: 'رقم الهاتف',
                            validation: (value) {
                              if (value?.length == 0) {
                                return "رقم الهاتف مطلوب";
                              }
                              if (value!.startsWith("+")) {
                                return "يرجى إزالة علامة +  من بداية رقم الهاتف";
                              }
                              if (value!.startsWith("00")) {
                                return "يرجى إزالة علامة 00  من بداية رقم الهاتف";
                              }
                              return null;
                            },
                          ),
                          Obx(() {
                            return Visibility(
                                visible: logic.errorPhone.value != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${logic.errorPhone.value}",
                                    style: H4RedTextStyle,
                                  ),
                                ));
                          }),
                          15.verticalSpace,
                          Select2Component(
                              label: 'المدينة',
                              width: 1.sw,
                              onChanged: (values) {
                                logic.citySelected.value =
                                    values.firstOrNull;
                              },
                              selectDataController:
                              logic.citiesController!),
                          Obx(() {
                            return Visibility(
                                visible: logic.errorCity.value != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${logic.errorCity.value}",
                                    style: H4RedTextStyle,
                                  ),
                                ));
                          }),
                          25.verticalSpace,
                          Obx(() {
                            if (logic.loading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                logic.clearError();

                                if (_form.currentState!.validate()) {
                                  if (logic.citySelected.value == null) {
                                    logic.errorCity.value = 'يرجى تحديد المدينة';
                                    return;
                                  }
                                  logic.register();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 1.sw,
                                height: 0.12.sw,
                                decoration: BoxDecoration(
                                    color: RedColor,
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Text(
                                  'تسجيل الحساب',
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
                              logic.mainController.loginByGoogle();
                            },
                            child: Container(
                              width: 1.sw,
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
                            width: 1.sw,
                            height: 0.12.sw,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: GrayLightColor,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.offAndToNamed(LOGIN_PAGE);
                              },
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'لديك حساب ؟ ',
                                      style: H4BlackTextStyle),
                                  TextSpan(
                                      text: ' تسجيل الدخول',
                                      style: H2OrangeTextStyle.copyWith(
                                          decoration: TextDecoration.underline)),
                                ]),
                              ),
                            ),
                          ),
                          25.verticalSpace,
                        ],
                      ),
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
