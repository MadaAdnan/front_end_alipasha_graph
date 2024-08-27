import 'dart:io';

import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'logic.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final logic = Get.find<EditProfileLogic>();
  GlobalKey<FormState> state = GlobalKey<FormState>();
  RxBool isScure = true.obs;
  RxBool isScureConfirm = true.obs;

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
                    25.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: GrayDarkColor),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'يمكنك ترك حقل كلمة المرور فارغاً إذا كنت لا تريد تغييرها',
                            style: H5RedTextStyle,
                          ),
                          InputComponent(
                              suffixIcon: isScure.value
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              suffixClick: () {
                                isScure.value = !isScure.value;
                                return "";
                              },
                              isSecure: isScure.value,
                              width: 1.sw,
                              radius: 150.r,
                              hint: 'كلمة المرور',
                              controller: logic.passwordController.value,
                              fill: GrayWhiteColor,
                              textInputType: TextInputType.text,
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
                              suffixIcon: isScureConfirm.value
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              suffixClick: () {
                                isScureConfirm.value = !isScureConfirm.value;
                                return "";
                              },
                              isSecure: isScureConfirm.value,
                              width: 1.sw,
                              radius: 150.r,
                              hint: 'تأكيد كلمة المرور',
                              controller: logic.confirmPasswordController.value,
                              fill: GrayWhiteColor,
                              textInputType: TextInputType.text,
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
                        ],
                      ),
                    ),
                    25.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "صورة الحساب",
                              style: H4BlackTextStyle,
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  logic.pickAvatar(
                                      imagSource: ImageSource.gallery,
                                      onChange: (file, size) {
                                        logic.avatar.value = file;
                                        print(
                                            "Size: ${size! / (1024 * 1024)} MB");
                                      });
                                },
                                child: Obx(() {
                                  return Container(
                                    width: 0.25.sw,
                                    height: 0.25.sw,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: logic.avatar.value == null
                                              ? NetworkImage(
                                              '${logic.mainController.authUser.value?.image}')
                                                  as ImageProvider
                                              : FileImage(
                                                  File.fromUri(
                                                    Uri.file(
                                                        "${logic.avatar.value!.path}"),
                                                  ),
                                                ),
                                          fit: BoxFit.cover,
                                        )),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        if (logic.user.value?.is_seller == true)
                          Column(
                            children: [
                              Text(
                                "لوغو المتجر",
                                style: H4BlackTextStyle,
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    logic.pickAvatar(
                                        imagSource: ImageSource.gallery,
                                        onChange: (file, size) {
                                          logic.logo.value = file;
                                          print(
                                              "Size: ${size! / (1024 * 1024)} MB");
                                        });
                                  },
                                  child: Obx(() {
                                    return Container(
                                      width: 0.25.sw,
                                      height: 0.25.sw,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: logic.logo.value == null
                                                ? NetworkImage(
                                                        '${logic.mainController.authUser.value?.logo}')
                                                    as ImageProvider
                                                : FileImage(
                                                    File.fromUri(
                                                      Uri.file(
                                                          "${logic.logo.value!.path}"),
                                                    ),
                                                  ),
                                            fit: BoxFit.cover,
                                          )),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                    25.verticalSpace,
                    InkWell(
                      onTap:() => logic.saveData(),
                      child: Container(
                          width: 1.sw,
                          height: 0.04.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: RedColor),
                          child: Center(
                            child: Text(
                              "حفظ التغييرات",
                              style: H4WhiteTextStyle,
                            ),
                          )),
                    ),
                    25.verticalSpace,
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
