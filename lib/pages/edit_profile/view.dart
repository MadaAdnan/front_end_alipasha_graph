import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'logic.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final logic = Get.find<EditProfileLogic>();
  GlobalKey<FormState> state = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: 0.1.sh,
            alignment: Alignment.center,
            color: RedColor,
            child: Text(
              'تعديل الملف الشخصي',
              style: H2WhiteTextStyle,
            ),
          ),
          Expanded(child: Obx(() {
            if (logic.loading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              child: Form(
                key: state,
                child: Column(
                  children: [
                    35.verticalSpace,
                    InputComponent(
                      isRequired: true,
                      width: 1.sw,
                      radius: 150.r,
                      hint: 'الاسم',
                      controller: logic.nameController.value,
                      fill: GrayWhiteColor,
                      textInputType: TextInputType.text,
                      validation: (text) {
                        if (text == '' || text == null) {
                          return "الاسم مطلوب";
                        } else if (text.length < 3) {
                          return "يرجى كتابة اسم أطول";
                        }
                        return null;
                      },
                    ),
                    InputComponent(
                        isRequired: true,
                        width: 1.sw,
                        radius: 150.r,
                        hint: 'البريد الإلكتروني',
                        controller: logic.emailController.value,
                        fill: GrayWhiteColor,
                        textInputType: TextInputType.emailAddress,
                        validation: (text) {
                          if (text == '' || text == null) {
                            return "البريد الإلكتروني مطلوب";
                          } else if (!text.isEmail) {
                            return "يرجى كتابة بريد إلكتروني صحيح";
                          }
                          return null;
                        }),
                    InputComponent(
                        isRequired: true,
                        width: 1.sw,
                        radius: 150.r,
                        hint: 'رقم الهاتف',
                        controller: logic.phoneController.value,
                        fill: GrayWhiteColor,
                        textInputType: TextInputType.phone,
                        validation: (text) {
                          if (text == '' || text == null) {
                            return "رقم الهاتف مطلوب";
                          } else if (text.startsWith('+')) {
                            return 'يرجى عدم إدخال اي رمز غير الأرقام';
                          } else if (text.startsWith('00')) {
                            return 'يرجى حذف 00  من بداية الرقم';
                          }
                          return null;
                        }),
                    InputComponent(
                        isRequired: true,
                        width: 1.sw,
                        radius: 150.r,
                        hint: 'العنوان',
                        controller: logic.addressController.value,
                        fill: GrayWhiteColor,
                        textInputType: TextInputType.text,
                        validation: (text) {
                          if (text == '' || text == null) {
                            return "العنوان مطلوب";
                          }
                          return null;
                        }),
                    if (logic.user.value?.is_seller == true)
                      InputComponent(
                        isRequired: true,
                        width: 1.sw,
                        radius: 150.r,
                        hint: 'اسم المتجر',
                        controller: logic.sellerNameController.value,
                        fill: GrayWhiteColor,
                        textInputType: TextInputType.text,
                        validation: (text) {
                          if (text == '' || text == null) {
                            return "اسم المتجر مطلوب";
                          } else if (text.length < 3) {
                            return "يرجى كتابة اسم متجر أطول";
                          }
                          return null;
                        },
                      ),
                    if (logic.user.value?.is_seller == true)
                      InputComponent(
                        isRequired: true,
                        width: 1.sw,
                        radius: 150.r,
                        hint: 'يفتح الساعة',
                        controller: logic.openTimeController.value,
                        fill: GrayWhiteColor,
                        textInputType: TextInputType.datetime,
                      ),
                    if (logic.user.value?.is_seller == true)
                      InputComponent(
                        isRequired: true,
                        width: 1.sw,
                        radius: 150.r,
                        hint: 'يغلق الساعة',
                        controller: logic.closeTimeController.value,
                        fill: GrayWhiteColor,
                        textInputType: TextInputType.datetime,
                      ),
                    if (logic.user.value?.is_seller == true)
                      InputComponent(
                        width: 1.sw,
                        maxLine: 7,
                        height: 0.1.sh,
                        radius: 15.r,
                        hint: 'وصف مختصر عن المتجر',
                        controller: logic.infoController.value,
                        fill: GrayWhiteColor,
                        textInputType: TextInputType.multiline,
                      ),
                  ],
                ),
              ),
            );
          }))
        ],
      ),
    );
  }
}
