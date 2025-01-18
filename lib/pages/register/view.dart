import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/fields_components/select2_component.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final logic = Get.find<RegisterLogic>();
  RxBool secure = RxBool(true);
  RxBool confirmSecure = RxBool(true);
  GlobalKey<FormBuilderState> _form = GlobalKey<FormBuilderState>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
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
          Expanded(
            child: ListView(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.01.sh),
              children: [
                FormBuilder(
                  key: _form,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        style: H3RegularDark,
                        controller: logic.nameController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "الاسم مطلوب"),
                        ]),
                        name: 'name',
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.user),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: GrayLightColor)),
                            label: Text(
                              'الاسم',
                              style: H3RegularDark,
                            )),
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
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      FormBuilderTextField(
                        style: H3RegularDark,
                        controller: logic.emailController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "البريد الإلكتروني مطلوب"),
                          FormBuilderValidators.email(
                              errorText: "البريد الإلكتروني غير صالح"),
                        ]),
                        name: 'email',
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.envelope),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: GrayLightColor)),
                            label: Text(
                              'البريد الإلكتروني',
                              style: H3RegularDark,
                            )),
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
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Obx(() {
                        return FormBuilderTextField(
                          obscureText: secure.value,
                          style: H3RegularDark,
                          controller: logic.passwordController,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "كلمة المرور مطلوبة"),
                            FormBuilderValidators.minLength(8,
                                errorText:
                                    "يجب أن يكون طول كلمة المرور 8 أحرف على الأقل"),
                          ]),
                          name: 'password',
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed: () {
                                secure.value = !secure.value;
                              }, icon: Obx(() {
                                return Icon(secure.value
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye);
                              })),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide:
                                      BorderSide(color: GrayLightColor)),
                              label: Text(
                                'كلمة المرور',
                                style: H3RegularDark,
                              )),
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
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Obx(() {
                        return FormBuilderTextField(
                          obscureText: secure.value,
                          style: H3RegularDark,
                          controller: logic.confirmPasswordController,
                          validator: FormBuilderValidators.compose([
                            (value) {
                              if (value != logic.passwordController.text) {
                                return "كلمة المرور غير متطابقة";
                              }
                              return null;
                            }
                          ]),
                          name: 'confirmPassword',
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed: () {
                                secure.value = !secure.value;
                              }, icon: Obx(() {
                                return Icon(secure.value
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye);
                              })),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide:
                                      BorderSide(color: GrayLightColor)),
                              label: Text(
                                'تأكيد كلمة المرور',
                                style: H3RegularDark,
                              )),
                        );
                      }),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      FormBuilderTextField(
                        style: H3RegularDark,
                        controller: logic.phoneController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "رقم الهاتف مطلوب"),
                          (value) {
                            if (value!.startsWith("+")) {
                              return "يرجى إزالة علامة +  من بداية رقم الهاتف";
                            }
                            if (value.startsWith("00")) {
                              return "يرجى إزالة علامة 00  من بداية رقم الهاتف";
                            }
                            return null;
                          }
                        ]),
                        name: 'phone',
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.mobileScreen),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: GrayLightColor)),
                            label: Text(
                              'رقم الهاتف : 963966047550',
                              style: H3RegularDark,
                            ),
                            helperText:
                                "أدخل رقم الهاتف مع رمز الدولة بدون + أو 00",
                            helperStyle: H6RedTextStyle),
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
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      FormBuilderDropdown(
                          name: 'mainCity',
                          validator: FormBuilderValidators.required(errorText: 'يرجى تحديد المحافظة'),
                          decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.city),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: GrayLightColor)),
                            label: Text(
                              'المحافظة',
                              style: H3RegularDark,
                            ),
                          ),
                          onChanged: (value) {
                            logic.mainCitySelected.value = value;
                          },
                          items: mainController.mainCities!
                              .map(
                                (city) => DropdownMenuItem(
                                  value: city.id,
                                  child: Text(
                                    '${city.name}',
                                    style: H3RegularDark,
                                  ),
                                ),
                              )
                              .toList()),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Obx(() {
                        return FormBuilderDropdown(
                            name: 'city',
                            validator: FormBuilderValidators.required(errorText: 'يرجى تحديد المدينة'),
                            decoration: InputDecoration(
                              suffixIcon: Icon(FontAwesomeIcons.city),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide:
                                      BorderSide(color: GrayLightColor)),
                              label: Text(
                                'المدينة',
                                style: H3RegularDark,
                              ),
                            ),
                            onChanged: (value) {
                              logic.citySelected.value = value;
                            },
                            items: mainController.mainCities
                                .where((el) =>
                                    el.id == logic.mainCitySelected.value)
                                .first
                                .children!
                                .map(
                                  (city) => DropdownMenuItem(
                                    value: city.id,
                                    child: Text(
                                      '${city.name}',
                                      style: H3RegularDark,
                                    ),
                                  ),
                                )
                                .toList());
                      }),
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
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      FormBuilderTextField(
                        style: H3RegularDark,
                        controller: logic.addressController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "العنوان التفصيلي مطلوب"),
                          FormBuilderValidators.minLength(15,
                              errorText: "يجب أن يكون العنوان من 15 حرف على الأقل"),

                        ]),
                        name: 'address',
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.locationDot),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: GrayLightColor)),
                            label: Text(
                              'العنوان التفصيلي',
                              style: H3RegularDark,
                            ),
                            helperText:
                            "مثال : سرمدا دوار السيارات جانب كازية كاف",
                            helperStyle: H6RegularDark),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      FormBuilderTextField(
                        style: H3RegularDark,
                        controller: logic.affiliateController,
                        name: 'affiliate',
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(FontAwesomeIcons.donate),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.r),
                              borderSide: BorderSide(color: GrayLightColor)),
                          label: Text(
                            'كود الإحالة (إختياري)',
                            style: H3RegularDark,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ],
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
        if (logic.loading.value) {
          return ProgressLoading(
            width: 0.15.sw,
          );
        }
        return Container(
          height: 0.2.sh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'كود الإحالة',
                  style: H1RedTextStyle,
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                Text(
                  'يرجى إدخال كود الإحالة في حال توفره',
                  style: H4RedTextStyle,
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                InputComponent(
                  fill: WhiteColor,
                  width: 1.sw,
                  controller: logic.affiliateController,
                  suffixIcon: FontAwesomeIcons.user,
                  textInputType: TextInputType.text,
                  isRequired: false,
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
                    color: RedColor, borderRadius: BorderRadius.circular(30.r)),
                child: Text(
                  'إستمرار',
                  style: H3WhiteTextStyle,
                ),
              ),
            ),
            SizedBox(
              width: 0.1.sw,
            ),
            InkWell(
              onTap: () {
                logic.registerGoogel();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 0.02.sw),
                width: 0.25.sw,
                decoration: BoxDecoration(
                    color: GrayLightColor,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Text(
                  'تخطي',
                  style: H3RegularDark,
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
