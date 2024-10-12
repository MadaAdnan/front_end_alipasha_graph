import 'package:ali_pasha_graph/Global/main_controller.dart';
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
  final MainController mainController = Get.find<MainController>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 0.02.sw, vertical: 0.004.sh),
            decoration: BoxDecoration(color: WhiteColor,
                border: Border(bottom: BorderSide(color: GrayDarkColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Container(
                    child: Row(
                      children: [
                        Container(
                          width: 0.12.sw,
                          height: 0.12.sw,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1, color: GrayDarkColor),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${mainController.authUser.value
                                          ?.image}"))
                          ),
                        ),
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(text: TextSpan(children: [
                                  TextSpan(
                                    text: " ${mainController.authUser.value
                                        ?.seller_name} ",
                                    style: H3BlackTextStyle,),
                                  TextSpan(
                                    text: " (${mainController.authUser.value
                                        ?.city
                                        ?.name}) ", style: H5RegularDark,),
                                ]),
                                ),
                                SizedBox(height: 0.002.sh,),
                                Text(
                                  " ${mainController.authUser.value?.address} ",
                                  style: H5GrayTextStyle,),
                                SizedBox(height: 0.002.sh,),
                                Text(
                                  " ${mainController.authUser.value?.phone} ",
                                  style: H5GrayTextStyle,),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  );
                }),
                Obx(() {
                  return Container(
                    child: RichText(text: TextSpan(children: [
                      TextSpan(text: 'الرصيد الحالي : ', style: H4RegularDark),
                      TextSpan(text: '${logic.totalBalance.value} \$',
                          style: H3RedTextStyle)
                    ])),
                  );
                })
              ],
            ),
          ),
          SizedBox(height: 0.02.sh,),
          Expanded(child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Select2Component(
                          label: 'مدينة المرسل',
                          width: 0.5.sw,
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
                      35.verticalSpace,
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
                     Divider(),
                      Select2Component(
                          label: 'مدينة المرسل إليه',
                          width: 0.5.sw,
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
                      35.verticalSpace,

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
                      Divider(),
                      Row(
                        children: [
                          
                          SizedBox(width: 0.5.sw,
                            child: InputComponent(
                              suffixIcon: FontAwesomeIcons.scaleBalanced,
                              fill: WhiteColor,
                              width: 0.7.sw,
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

                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الأبعاد التقريبية للحمولة',
                            style: H1GrayTextStyle,
                          )),
                      25.verticalSpace,
                      Row(
                        children: [
                          SizedBox(
                            width: 0.5.sw,
                            child: Column(
                              children: [
                                Row(
                                  children: [

                                    Expanded(
                                      child: InputComponent(
                                        suffixIcon: FontAwesomeIcons.textHeight,
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

                                Row(
                                  children: [

                                    Expanded(
                                      child: InputComponent(
                                        suffixIcon: FontAwesomeIcons.textWidth,
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

                                Row(
                                  children: [


                                    Expanded(
                                      child: InputComponent(
                                        suffixIcon: FontAwesomeIcons.rulerHorizontal,
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

                              ],
                            ),
                          ),
                          10.horizontalSpace,
                          Container(
                            width: 0.4.sw,
                            height: 0.4.sw,
                            decoration: const BoxDecoration(
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
                          InkWell(
                            onTap: () {
                              logic.calcPrice();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 0.5.sw,
                              height: 0.04.sh,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: RedColor,
                              ),
                              child: Text(
                                'أحسب كلفة الشحن',
                                style: H3WhiteTextStyle,
                              ),
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
                          Flexible(child: Container(
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
                          ),flex: 4,),
                         Flexible(child:  Container(
                           alignment: Alignment.center,

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
                         ),flex: 1,)
                        ],
                      ),
                      SizedBox(height: 0.01.sh,),
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
                              color: logic.totalBalance.value > 0 && logic.totalPrice.value!=null && logic.totalPrice.value!>0
                                  ? RedColor
                                  : GrayDarkColor,
                            ),
                            child: Text(
                              'تقديم طلب الشحن',
                              style: H3WhiteTextStyle,
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 0.01.sh,),
                    ],
                  );
                }),
              ),
            ),
          ))
        ],
      ),
    );
  }


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
