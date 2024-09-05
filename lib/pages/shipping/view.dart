import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/fields_components/select2_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ShippingPage extends StatelessWidget {
  ShippingPage({Key? key}) : super(key: key);

  final logic = Get.find<ShippingLogic>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 0.185.sh),
        child: Container(
          margin: EdgeInsets.only(bottom: 0.005.sh),
          decoration: BoxDecoration(
              color: WhiteColor,
              border: Border(bottom: BorderSide(color: GrayDarkColor))),
          padding: EdgeInsets.only(top: 0.015.sh),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 0.55.sw,
                    child: Text(
                      '${logic.mainController.authUser.value?.seller_name ?? logic.mainController.authUser.value?.name}',
                      style: H2GrayTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Obx(() {
                    if (logic.mainController.loading.value == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'الرصيد الحالي : ',
                              style: H4BlackTextStyle),
                          TextSpan(
                              text: '${logic.totalBalance.value} \$',
                              style: H4OrangeTextStyle),
                        ],
                      ),
                    );
                  }),
                ],
              ),
              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 0.22.sw,
                    height: 0.22.sw,
                    decoration: BoxDecoration(
                      color: WhiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: GrayLightColor, width: 0.01.sw),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            '${logic.mainController.authUser.value?.logo}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  15.horizontalSpace,
                  Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'العنوان : ', style: H4GrayTextStyle),
                              TextSpan(
                                text:
                                    '${logic.mainController.authUser.value?.address}',
                                style: H4GrayTextStyle,
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'رقم الهاتف : ',
                                  style: H4GrayTextStyle),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      if (logic.mainController.authUser.value
                                              ?.phone !=
                                          null) {
                                        openUrl(
                                            url:
                                                "https://wa.me/${logic.mainController.authUser.value?.phone}");
                                      }
                                    },
                                  text:
                                      '${logic.mainController.authUser.value?.phone}',
                                  style: H4GrayTextStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: 1.sw,
        height: 0.845.sh,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
          child: Form(
            key: _formKey,
            child: Obx(() {
              if (logic.mainController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Select2Component(
                      label: 'مدينة المرسل',
                      width: 1.sw,
                      onChanged: (values) {
                        logic.from.value = values.firstOrNull;
                      },
                      selectDataController: logic.fromController),
                  Obx(() {
                    return Visibility(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${logic.errorFrom.value}',
                          style: H4RedTextStyle,
                        ),
                      ),
                      visible: logic.errorFrom.value != null,
                    );
                  }),
                  15.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: InputComponent(
                      fill: WhiteColor,
                      validation: (value) {
                        if (value?.length == 0) {
                          return "الاسم مطلوب";
                        }
                        return null;
                      },
                      isRequired: true,
                      width: 0.1.sw,
                      hint: 'اسم المرسل',
                      controller: logic.nameSenderController,
                    ),
                  ),
                  15.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: InputComponent(
                      fill: WhiteColor,
                      validation: (value) {
                        if (value?.length == 0) {
                          return "العنوان مطلوب";
                        }
                        return null;
                      },
                      isRequired: true,
                      width: 0.1.sw,
                      hint: 'عنوان المرسل',
                      controller: logic.addressSenderController,
                    ),
                  ),
                  15.verticalSpace,
                  Select2Component(
                      label: 'مدينة المرسل إليه',
                      width: 1.sw,
                      onChanged: (values) {
                        logic.to.value = values.firstOrNull;
                      },
                      selectDataController: logic.toController),
                  Obx(() {
                    return Visibility(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${logic.errorTo.value}',
                          style: H4RedTextStyle,
                        ),
                      ),
                      visible: logic.errorTo.value != null,
                    );
                  }),
                  15.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: InputComponent(
                      fill: WhiteColor,
                      validation: (value) {
                        if (value?.length == 0) {
                          return "الاسم مطلوب";
                        }
                        return null;
                      },
                      isRequired: true,
                      width: 0.1.sw,
                      hint: 'اسم المستلم',
                      controller: logic.nameReceiveController,
                    ),
                  ),
                  15.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: InputComponent(
                      fill: WhiteColor,
                      validation: (value) {
                        if (value?.length == 0) {
                          return "العنوان مطلوب";
                        }
                        return null;
                      },
                      isRequired: true,
                      width: 0.1.sw,
                      hint: 'عنوان المستلم',
                      controller: logic.addressReceiveController,
                    ),
                  ),
                  15.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: InputComponent(
                      fill: WhiteColor,
                      textInputType: TextInputType.phone,
                      validation: (value) {
                        if (value?.length == 0) {
                          return "رقم الهاتف مطلوب";
                        }
                        return null;
                      },
                      isRequired: true,
                      width: 0.1.sw,
                      hint: 'هاتف المستلم',
                      controller: logic.phoneReceiveController,
                    ),
                  ),
                  15.verticalSpace,
                  Row(
                    children: [
                      Text(
                        'وزن الحمولة',
                        style: H4BlackTextStyle,
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: InputComponent(
                          fill: WhiteColor,
                          width: 0.1.sw,
                          textInputType: TextInputType.number,
                          validation: (value) {
                            if (value?.length == 0) {
                              return "وزن الحمولة مطلوب";
                            }
                            return null;
                          },
                          isRequired: true,
                          hint: 'وزن الحمولة',
                          controller: logic.weightController,
                          onChanged: (value) {
                            logic.weight.value =
                                double.tryParse("${value ?? 0}");
                          },
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        'كغ',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                  15.verticalSpace,
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الأبعاد التقريبية للحمولة',
                        style: H1GrayTextStyle,
                      )),
                  15.verticalSpace,
                  Row(
                    children: [
                      SizedBox(
                        width: 0.5.sw,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'الإرتفاع',
                                  style: H4BlackTextStyle,
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: InputComponent(
                                    textInputType: TextInputType.number,
                                    fill: WhiteColor,
                                    width: 0.1.sw,
                                    validation: (value) {
                                      if (value?.length == 0) {
                                        return "الإرتفاع مطلوب";
                                      }
                                      return null;
                                    },
                                    isRequired: true,
                                    hint: 'الإرتفاع',
                                    controller: logic.heightController,
                                    onChanged: (value) {
                                      logic.height.value =
                                          double.tryParse("${value ?? 0}");
                                    },
                                  ),
                                ),
                                10.horizontalSpace,
                                Text(
                                  "سم",
                                  style: H4BlackTextStyle,
                                )
                              ],
                            ),
                            15.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  'العرض',
                                  style: H4BlackTextStyle,
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: InputComponent(
                                    textInputType: TextInputType.number,
                                    fill: WhiteColor,
                                    validation: (value) {
                                      if (value?.length == 0) {
                                        return "العرض مطلوب";
                                      }
                                      return null;
                                    },
                                    isRequired: true,
                                    width: 0.1.sw,
                                    hint: 'العرض',
                                    controller: logic.widthController,
                                    onChanged: (value) {
                                      logic.width.value =
                                          double.tryParse("${value ?? 0}");
                                    },
                                  ),
                                ),
                                10.horizontalSpace,
                                Text(
                                  "سم",
                                  style: H4BlackTextStyle,
                                )
                              ],
                            ),
                            15.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  'الطول',
                                  style: H4BlackTextStyle,
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: InputComponent(
                                    textInputType: TextInputType.number,
                                    fill: WhiteColor,
                                    width: 0.1.sw,
                                    validation: (value) {
                                      if (value?.length == 0) {
                                        return "الطول مطلوب";
                                      }
                                      return null;
                                    },
                                    isRequired: true,
                                    hint: 'الطول',
                                    controller: logic.lengthController,
                                    onChanged: (value) {
                                      logic.length.value =
                                          double.tryParse("${value ?? 0}");
                                    },
                                  ),
                                ),
                                10.horizontalSpace,
                                Text(
                                  "سم",
                                  style: H4BlackTextStyle,
                                )
                              ],
                            ),
                            15.verticalSpace,
                          ],
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        width: 0.4.sw,
                        height: 0.4.sw,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/png/box.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  15.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 0.5.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: DarkColor,
                        ),
                        child: Text(
                          'كلفة الشحنة',
                          style: H3WhiteTextStyle,
                        ),
                      ),
                      Obx(() {
                        return Container(
                          alignment: Alignment.center,
                          width: 0.4.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: GrayLightColor,
                          ),
                          child: Text(
                            '${logic.totalPrice} \$',
                            style: H3OrangeTextStyle,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: Divider(
                      color: GrayDarkColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.6.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: " - ",
                                      style: H2OrangeTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          "يرجى الإلتزام بكتابة البيانات الصحيحة للشحنة",
                                      style: H3GrayTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            20.verticalSpace,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: " - ",
                                      style: H2OrangeTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          "إذا كان هناك فرق بين المعلومات المدخلة والبضاعة الفعلية فلن يتم قبول التوصيل .",
                                      style: H3GrayTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            20.verticalSpace,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: " - ",
                                      style: H2OrangeTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          "الرجاء الإتصال بالدعم الفني لأي إستفسار أو مساعدة .",
                                      style: H3GrayTextStyle.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 0.3.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 0.15.sw,
                                height: 0.15.sw,
                                decoration: BoxDecoration(
                                  color: GrayLightColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Icon(FontAwesomeIcons.question),
                              ),
                            ),
                            15.verticalSpace,
                            Container(
                              width: 0.2.sw,
                              child: Center(
                                child: Text(
                                  'طلب المساعدة من الدعم الفني',
                                  style: H5BlackTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    return InkWell(
                      splashColor: RedColor,
                      highlightColor: Colors.yellow,
                      onTap: () {
                        if (logic.from.value == null) {
                          logic.errorFrom.value = "مدينة المرسل مطلوبة";
                        } else {
                          logic.errorFrom.value = null;
                        }
                        if (logic.to.value == null) {
                          logic.errorTo.value = "مدينة المرسل إليه مطلوبة";
                        } else {
                          logic.errorTo.value = null;
                        }

                        if (logic.totalBalance.value > 0) {
                          if (_formKey.currentState?.validate() == true &&
                              logic.errorFrom.value == null &&
                              logic.errorTo.value == null) {
                            _buildDialogConfirm();
                          }
                        } else {
                          CherryToast.info(
                            title: Text("تنبيه", style: H3OrangeTextStyle),
                            action: Text("لا تملك رصيد لطلب الشحن",
                                style: H3BlackTextStyle),
                          ).show(context);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 0.006.sh, bottom: 0.009.sh),
                        width: 0.6.sw,
                        height: 0.1.sw,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: logic.totalBalance.value > 0
                              ? RedColor
                              : GrayDarkColor,
                        ),
                        child: Text(
                          'تقديم طلب الشحن',
                          style: H3WhiteTextStyle,
                        ),
                      ),
                    );
                  })
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

/*  Widget _dropDownButtonCity(
      {required List<DropdownMenuItem<String>> items,
      required String title,
      required String img,
      String? selectedValue}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.002.sh),
      width: 1.sw,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(

          isExpanded: true,
          hint: Row(
            children: [
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.06.sw,
                      child: Image(
                        image: AssetImage(
                          img,
                        ),
                      ),
                    ),
                    20.horizontalSpace,
                    Text(
                      title,
                      style: H3GrayTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          items: items,
          value: selectedValue,
          onChanged: (value) {
            print(value);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: WhiteColor,
            ),
            elevation: 2,
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 0.07.sw,
            iconEnabledColor: DarkColor,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: WhiteColor,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }*/

  void _buildDialogConfirm() {
    Get.defaultDialog(
      radius: 15.r,
      backgroundColor: GrayLightColor,
      title: 'تأكيد طلب الشحن',
      titleStyle: H3BlackTextStyle,
      middleText: 'ستخصم أجور الشحن من رصيدك عند تقديم الطلب !',
      middleTextStyle: H2RedTextStyle,
      textConfirm: 'تقديم الطلب',
      confirm: MaterialButton(
        onPressed: () async {
          await logic.sendOrder();
          Get.back();
        },
        child: Text(
          'تقديم الطلب',
          style: H3WhiteTextStyle,
        ),
        color: RedColor,
      ),
      cancel: MaterialButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          'إلغاء',
          style: H3WhiteTextStyle,
        ),
        color: GrayDarkColor,
      ),
      textCancel: 'إلغاء',
    );
  }
}
