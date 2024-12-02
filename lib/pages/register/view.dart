import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/fields_components/select2_component.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 0.07.sw, vertical: 0.02.sh),
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
          Expanded(

            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.01.sw, vertical: 0.01.sh),
              children: [

                Form(
                  key: _form,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
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
                              if (value != logic.passwordController.text) {
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
                              logic.citySelected.value = values.firstOrNull;
                            },
                            selectDataController: logic.citiesController!),
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
                        InputComponent(
                          fill: WhiteColor,
                          width: 1.sw,
                          controller: logic.affiliateController,
                          suffixIcon: FontAwesomeIcons.user,
                          textInputType: TextInputType.text,
                          isRequired: true,
                          hint: 'كود الإحالة',

                        ),
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
                                  logic.errorCity.value =
                                  'يرجى تحديد المدينة';
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
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: 0.35.sw,
                                    child: Divider(
                                      height: 0.07.sh,
                                      color: GrayDarkColor,
                                    )),
                                Text(
                                  ' أو ',
                                  style: H1BlackTextStyle,
                                ),
                                SizedBox(
                                    width: 0.35.sw,
                                    child: Divider(
                                      height: 0.07.sh,
                                      color: GrayDarkColor,
                                    )),
                              ],
                            )),
                        25.verticalSpace,
                        InkWell(
                          onTap: _getAffeliateCode,
                          child: Container(
                            width: 1.sw,
                            height: 0.12.sw,
                            decoration: BoxDecoration(
                                color: GrayLightColor,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
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
                                        decoration:
                                        TextDecoration.underline)),
                              ]),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  _getAffeliateCode() {
    Get.dialog(AlertDialog(
      backgroundColor: WhiteColor,
      content: Obx(() {
        if(logic.loading.value){
          return ProgressLoading(width: 0.15.sw,);
        }
        return Container(
          height: 0.2.sh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('كود الإحالة', style: H1RedTextStyle,),
                SizedBox(height: 0.02.sh,),
                Text(
                  'يرجى إدخال كود الإحالة في حال توفره', style: H4RegularDark,),
                SizedBox(height: 0.02.sh,),
                InputComponent(
                  fill: WhiteColor,
                  width: 1.sw,
                  controller: logic.affiliateController,
                  suffixIcon: FontAwesomeIcons.user,
                  textInputType: TextInputType.text,
                  isRequired: true,
                  hint: 'كود الإحالة',

                ),
              ],
            ),
          ),
        );
      }),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                logic.registerGoogel();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.02.sw),
                width: 0.25.sw,
                decoration: BoxDecoration(
                    color: RedColor,
                    borderRadius: BorderRadius.circular(30.r)
                ),
                child: Text('إستمرار', style: H3WhiteTextStyle,),
              ),
            )
          ],
        )
      ],
    ));
  }
}
