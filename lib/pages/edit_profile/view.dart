import 'dart:io';
import 'dart:math';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

import '../../helpers/components.dart';
import 'logic.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final logic = Get.find<EditProfileLogic>();
  GlobalKey<FormState> state = GlobalKey<FormState>();
  RxBool isScure = true.obs;
  RxBool isScureConfirm = true.obs;
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        title: Text(
          'تعديل الملف الشخصي ',
          style: H2RegularDark,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            if (logic.loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              child: FormBuilder(
                key: state,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Obx(() {
                          return Container(
                            width: 0.3.sw,
                            height: 0.3.sw,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: GrayLightColor, width: 0.01.sw),
                              image: DecorationImage(
                                  image: logic.avatar.value != null
                                      ? FileImage(File.fromUri(Uri.file(
                                          "${logic.avatar.value!.path}")))
                                      : CachedNetworkImageProvider(
                                          "${logic.user.value?.image}"),
                                  fit: BoxFit.cover),
                            ),
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          right: -0.02.sw,
                          child: IconButton(
                            onPressed: () {
                              logic.pickAvatar(
                                  imagSource: ImageSource.gallery,
                                  cropStyle: CropStyle.circle,
                                  onChange: (file, size) {
                                    logic.avatar.value = file;
                                  });
                            },
                            icon: Icon(
                              FontAwesomeIcons.camera,
                              color: RedColor.withOpacity(0.6),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    if (logic.user.value?.is_verified != true)
                      InkWell(
                          onTap: () {
                            openUrl(
                                url:
                                    "https://wa.me/${mainController.settings.value.social?.phone}");
                          },
                          child: Container(
                            width: 0.35.sw,
                            padding: EdgeInsets.symmetric(
                                vertical: 0.01.sh, horizontal: 0.02.sw),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: RedColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'تـوثيق الحسـاب ',
                                    style: H4WhiteTextStyle,
                                  ),
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                            "assets/images/svg/verified_white.svg",
                                            color: WhiteColor,
                                          ),
                                          fit: BoxFit.cover)),
                                )
                              ],
                            ),
                          )),
                    if (logic.user.value?.is_verified == true)
                      Container(
                        width: 0.35.sw,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.01.sh, horizontal: 0.02.sw),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: RedColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                'الحسـاب مـوثق',
                                style: H4WhiteTextStyle,
                              ),
                            ),
                            10.horizontalSpace,
                            Container(
                              width: 0.04.sw,
                              height: 0.04.sw,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: Svg(
                                        "assets/images/svg/verified_white.svg",
                                        color: WhiteColor,
                                      ),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    InputComponent(
                      name: 'name',
                      isRequired: true,
                      width: 1.sw,
                      radius: 30.r,
                      hint: 'الاسم',
                      controller: logic.nameController,
                      fill: WhiteColor,
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
                      name: 'seller_name',
                      isRequired: true,
                      width: 1.sw,
                      radius: 30.r,
                      hint: 'اسم المتجر',
                      controller: logic.sellerNameController,
                      fill: WhiteColor,
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
                    InputComponent(
                        name: 'email',
                        isRequired: true,
                        width: 1.sw,
                        radius: 30.r,
                        hint: 'البريد الإلكتروني',
                        enabled: true,
                        controller: logic.emailController,
                        fill: GrayLightColor,
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
                        name: 'phone',
                        isRequired: true,
                        width: 1.sw,
                        radius: 30.r,
                        hint: 'رقم الهاتف',
                        controller: logic.phoneController,
                        fill: WhiteColor,
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
                        name: 'address',
                        isRequired: true,
                        width: 1.sw,
                        radius: 30.r,
                        hint: 'العنوان',
                        controller: logic.addressController,
                        fill: WhiteColor,
                        textInputType: TextInputType.text,
                        validation: (text) {
                          if (text == '' || text == null) {
                            return "العنوان مطلوب";
                          }
                          return null;
                        }),
                    Obx(() {
                      return Container(
                        child: FormBuilderDropdown<int>(
                            validator: FormBuilderValidators.required(
                                errorText: "يرجى تحديد المدينة"),
                            name: 'city_id',
                            initialValue: logic.cityId.value,
                            onChanged: (value) => logic.cityId.value = value,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'المدينة', style: H4GrayTextStyle),
                                  TextSpan(text: ' * ', style: H3RedTextStyle),
                                ]),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: GrayDarkColor),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0.02.sw),
                            ),
                            items: [
                              ...List.generate(
                                logic.cities.length,
                                (index) => DropdownMenuItem<int>(
                                  value: logic.cities[index].id,
                                  child: Text(
                                    '${logic.cities[index].name}',
                                    style: H3GrayTextStyle,
                                  ),
                                ),
                              )
                            ]),
                      );
                    }),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    InputComponent(
                      name: 'open_at',
                      isRequired: true,
                      width: 1.sw,
                      radius: 30.r,
                      hint: 'يفتح الساعة',
                      controller: logic.openTimeController,
                      enabled: true,
                      fill: WhiteColor,
                      textInputType: TextInputType.datetime,
                    ),
                    InputComponent(
                      name: 'close_at',
                      isRequired: true,
                      width: 1.sw,
                      radius: 30.r,
                      hint: 'يغلق الساعة',
                      controller: logic.closeTimeController,
                      enabled: true,
                      fill: WhiteColor,
                      textInputType: TextInputType.datetime,
                    ),
                    Column(
                      children: [
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        InputComponent(
                          name: 'info',
                          width: 1.sw,
                          maxLine: 1,
                          height: 0.09.sh,
                          radius: 15.r,
                          hint: 'وصف مختصر عن المتجر',
                          controller: logic.infoController,
                          enabled: logic.user.value?.is_verified == true,
                          fill: logic.user.value?.is_verified == true
                              ? WhiteColor
                              : GrayLightColor,
                          textInputType: TextInputType.multiline,
                        ),
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        Container(
                          child: InputComponent(
                            width: 1.sw,
                            controller: logic.faceController,
                            name: 'facebook',
                            hint: 'رابط فيسبوك',
                            suffixIcon: FontAwesomeIcons.facebook,
                            radius: 30.r,
                            enabled: logic.user.value?.is_verified == true,
                            fill: logic.user.value?.is_verified == true
                                ? WhiteColor
                                : GrayLightColor,
                          ),
                        ),
                        25.verticalSpace,
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        Container(
                          child: InputComponent(
                            width: 1.sw,
                            controller: logic.instagramController,
                            name: 'instagram',
                            suffixIcon: FontAwesomeIcons.instagram,
                            hint: 'رابط إنستغرام',
                            radius: 30.r,
                            enabled: logic.user.value?.is_verified == true,
                            fill: logic.user.value?.is_verified == true
                                ? WhiteColor
                                : GrayLightColor,
                          ),
                        ),
                        25.verticalSpace,
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        Container(
                          child: InputComponent(
                            width: 1.sw,
                            controller: logic.twitterController,
                            name: 'twitter',
                            suffixIcon: FontAwesomeIcons.xTwitter,
                            hint: 'رابط تويتر',
                            radius: 30.r,
                            enabled: logic.user.value?.is_verified == true,
                            fill: logic.user.value?.is_verified == true
                                ? WhiteColor
                                : GrayLightColor,
                          ),
                        ),
                        25.verticalSpace,
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        Container(
                          child: InputComponent(
                            width: 1.sw,
                            controller: logic.linkedInController,
                            name: 'linkedin',
                            suffixIcon: FontAwesomeIcons.linkedin,
                            hint: 'رابط لينكد إن',
                            radius: 30.r,
                            enabled: logic.user.value?.is_verified == true,
                            fill: logic.user.value?.is_verified == true
                                ? WhiteColor
                                : GrayLightColor,
                          ),
                        ),
                        25.verticalSpace,
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        Container(
                          child: InputComponent(
                            width: 1.sw,
                            controller: logic.tiktokController,
                            name: 'tiktok',
                            suffixIcon: FontAwesomeIcons.tiktok,
                            hint: 'رابط تيكتوك',
                            radius: 30.r,
                            enabled: logic.user.value?.is_verified == true,
                            fill: logic.user.value?.is_verified == true
                                ? WhiteColor
                                : GrayLightColor,
                          ),
                        ),
                        25.verticalSpace,
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            if (mainController.authUser.value?.is_verified != true){
                              return;
                            }
                            Get.toNamed(GALLERY_PAGE,arguments:mainController.authUser.value?.id );
                          },
                          child: Container(
                            width: 1.sw,
                            height: 0.06.sh,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(0.02.sw),
                            decoration: BoxDecoration(
                                color: GrayLightColor,
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                  color: DarkColor,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'معرض الصور',
                                  style: H3GrayTextStyle,
                                ),
                                Icon(FontAwesomeIcons.images,size:0.05.sw,color:GrayDarkColor),
                              ],
                            ),
                          ),
                        ),
                        25.verticalSpace,
                        if (mainController.authUser.value?.is_verified != true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Row(
                              children: [
                                Text(
                                  'مطلوب توثيق الحساب لفتح هذه الميزة',
                                  style: H4RegularDark.copyWith(
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 0.02.sw,
                                ),
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg(
                                              'assets/images/svg/verified.svg'))),
                                )
                              ],
                            ),
                          ),
                        if (mainController.authUser.value?.is_verified != true)
                          SizedBox(
                            height: 0.01.sh,
                          ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'لون الملف الشخصي',
                            style: H3RegularDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.005.sh, horizontal: 0.02.sw),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                  color: Colors.black, width: 0.001.sw),
                              color:
                                  mainController.authUser.value?.is_verified ==
                                          true
                                      ? WhiteColor
                                      : GrayLightColor),
                          child: Column(
                            children: [
                              Container(
                                width: 1.sw,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#FF3B30');
                                        logic.colorHex.value =
                                            int.parse("FFFF3B30", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFF3B30),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FFFF3B30",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: const Color(0xFFFF3B30),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#FFCC00');
                                        logic.colorHex.value =
                                            int.parse("FFFFCC00", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFFCC00),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FFFFCC00",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: const Color(0xFFFFCC00),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#FFCC00');
                                        logic.colorHex.value =
                                            int.parse("FF34C759", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF34C759),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FF34C759",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: const Color(0xFF34C759),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#007AFF');
                                        logic.colorHex.value =
                                            int.parse("FF007AFF", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF007AFF),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FF007AFF",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: const Color(0xFF007AFF),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#000000');
                                        logic.colorHex.value =
                                            int.parse("FF000000", radix: 16);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF000000),
                                        ),
                                        padding: EdgeInsets.all(0.005.sw),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FF000000",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.01.sh,
                              ),
                              Container(
                                width: 1.sw,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        Get.defaultDialog(
                                            title: 'إختر لونك المخصص',
                                            content: Container(
                                              width: 1.sw,
                                              height: 0.3.sh,
                                              child: Container(
                                                child:
                                                    FormBuilderColorPickerField(
                                                  name: 'colorId',
                                                  enabled: true,
                                                  initialValue: logic
                                                      .colorIdController.text
                                                      .toColor(),
                                                  controller:
                                                      logic.colorIdController,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: WhiteColor,
                                                    label: Text(
                                                      'لون المتجر الأساسي',
                                                      style: H3GrayTextStyle,
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                0.02.sw),
                                                    suffixIconColor: Colors.red,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              150.r),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            textConfirm: 'تأكيد',
                                            textCancel: 'إلغاء',
                                            onConfirm: () {
                                              logic.colorHex.value = null;
                                              Get.back();
                                            },
                                            onCancel: () {
                                              logic.colorHex.value = null;
                                              logic.colorIdController.value =
                                                  TextEditingValue();
                                            });
                                      },
                                      child: Container(
                                        width: 0.1.sw,
                                        height: 0.1.sw,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: GrayLightColor,
                                        ),
                                        child: const Icon(
                                          FontAwesomeIcons.plus,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#7AC6F5');
                                        logic.colorHex.value =
                                            int.parse("FF7AC6F5", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF7AC6F5),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FF7AC6F5",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: const Color(0xFF7AC6F5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#AF52DE');
                                        logic.colorHex.value =
                                            int.parse("FFAF52DE", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFAF52DE),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FFAF52DE",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: Color(0xFFAF52DE),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#5856D6');
                                        logic.colorHex.value =
                                            int.parse("FF5856D6", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF5856D6),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FF5856D6",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: Color(0xFF5856D6),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mainController
                                                .authUser.value?.is_verified !=
                                            true) return;
                                        logic.colorIdController.value =
                                            const TextEditingValue(
                                                text: '#FF2D55');
                                        logic.colorHex.value =
                                            int.parse("FFFF2D55", radix: 16);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0.005.sw),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFF2D55),
                                        ),
                                        child: Container(
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                            border: logic.colorHex.value ==
                                                    int.parse("FFFF2D55",
                                                        radix: 16)
                                                ? Border.all(
                                                    color: WhiteColor,
                                                    width: 0.01.sw)
                                                : null,
                                            shape: BoxShape.circle,
                                            color: Color(0xFFFF2D55),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.01.sh,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    25.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                            backgroundColor: WhiteColor,
                            title: 'تغيير كلمة المرور',
                            content: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: GrayDarkColor),
                              ),
                              child: Container(
                                width: 0.8.sw,
                                child: Obx(() {
                                  if (logic.loadingPassword.value) {
                                    return ProgressLoading();
                                  }
                                  return Column(
                                    children: [
                                      InputComponent(
                                          name: 'password',
                                          suffixIcon: isScure.value
                                              ? FontAwesomeIcons.eyeSlash
                                              : FontAwesomeIcons.eye,
                                          suffixClick: () {
                                            isScure.value = !isScure.value;
                                            return "";
                                          },
                                          isSecure: isScure.value,
                                          width: 1.sw,
                                          radius: 30.r,
                                          hint: 'كلمة المرور',
                                          controller: logic.passwordController,
                                          fill: WhiteColor,
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
                                          name: 'confirm_password',
                                          suffixIcon: isScureConfirm.value
                                              ? FontAwesomeIcons.eyeSlash
                                              : FontAwesomeIcons.eye,
                                          suffixClick: () {
                                            isScureConfirm.value =
                                                !isScureConfirm.value;
                                            return "";
                                          },
                                          isSecure: isScureConfirm.value,
                                          width: 1.sw,
                                          radius: 30.r,
                                          hint: 'تأكيد كلمة المرور',
                                          controller:
                                              logic.confirmPasswordController,
                                          fill: WhiteColor,
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
                                  );
                                }),
                              ),
                            ),
                            textCancel: 'إلغاء',
                            textConfirm: 'تأكيد',
                            onConfirm: () {
                              if (logic.passwordController.text == '' ||
                                  logic.passwordController.text.length < 8) {
                                mainController.showToast(
                                    text:
                                        'يرجى إدخال كلمة مرور من 8 أحرف أو أكثر',
                                    type: 'error');
                                return;
                              }
                              if (logic.passwordController.text !=
                                  logic.confirmPasswordController.text) {
                                mainController.showToast(
                                    text: 'كلمة المرور غير متطابقة',
                                    type: 'error');
                                return;
                              }
                              logic.changePassword();
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(0.02.sw),
                        decoration: BoxDecoration(
                          color: RedColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          'تغيير كلمة المرور',
                          style: H3WhiteTextStyle,
                        ),
                      ),
                    ),
                    25.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (logic.user.value?.is_seller == true)
                          Column(
                            children: [
                              Text(
                                "صورة الغلاف",
                                style: H4BlackTextStyle,
                              ),
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    logic.pickAvatar(
                                        imagSource: ImageSource.gallery,
                                        width: 400,
                                        height: 200,
                                        onChange: (file, size) {
                                          logic.logo.value = file;
                                          print(
                                              "Size: ${size! / (1024 * 1024)} MB");
                                        });
                                  },
                                  child: Obx(() {
                                    return Container(
                                      width: 0.7.sw,
                                      height: 0.35.sw,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
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
                  ],
                ),
              ),
            );
          })),
          SizedBox(
            height: 0.002.sh,
          ),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => logic.saveData(),
              child: Container(
                  width: 1.sw,
                  height: 0.06.sh,
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
          ),
        ],
      ),
    );
  }
}
