import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/helper_class.dart';
import '../../helpers/style.dart';
import '../../models/attribute_model.dart';
import '../../models/category_model.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class CreateTenderPage extends StatelessWidget {
  CreateTenderPage({Key? key}) : super(key: key);

  final logic = Get.find<CreateTenderLogic>();
  final MainController mainController = Get.find<MainController>();



  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WhiteColor,
        body: Container(
          width: 1.sw,
          height: 1.sh,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: logic.formState,
              child: Column(children: [
                Container(
                  width: 1.sw,
                  height: 0.08.sh,
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: RedColor, width: 2))),
                          child: Text(
                            'إنشاء منشور',
                            style: H5BlackTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.offAndToNamed(CREATE_PRODUCT_PAGE);
                          },
                          child: Container(
                            width: 0.2.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.008.sw, vertical: 0.009.sh),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: logic.typePost.value != 'product'
                                      ? GrayDarkColor
                                      : RedColor),
                              borderRadius: BorderRadius.circular(15.r),
                              color: logic.typePost.value != 'product'
                                  ? Colors.transparent
                                  : RedColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.shoppingCart,
                                    color: logic.typePost.value != 'product'
                                        ? GrayDarkColor
                                        : WhiteColor,
                                    size: 0.04.sw),
                                10.horizontalSpace,
                                Text(
                                  'منتجات',
                                  style: logic.typePost.value != 'product'
                                      ? H4GrayTextStyle
                                      : H4WhiteTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap:() => Get.offAndToNamed(CREATE_JOB_PAGE),
                          child: Container(
                            width: 0.2.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.009.sw, vertical: 0.009.sh),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: logic.typePost.value != 'job'
                                      ? GrayDarkColor
                                      : RedColor),
                              borderRadius: BorderRadius.circular(15.r),
                              color: logic.typePost.value != 'job'
                                  ? Colors.transparent
                                  : RedColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.idCard,
                                    color: logic.typePost.value != 'job'
                                        ? GrayDarkColor
                                        : WhiteColor,
                                    size: 0.04.sw),
                                10.horizontalSpace,
                                Text(
                                  'وظائف',
                                  style: logic.typePost.value != 'job'
                                      ? H4GrayTextStyle
                                      : H4WhiteTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 0.2.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.009.sw, vertical: 0.009.sh),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: logic.typePost.value != 'tender'
                                      ? GrayDarkColor
                                      : RedColor),
                              borderRadius: BorderRadius.circular(15.r),
                              color: logic.typePost.value != 'tender'
                                  ? Colors.transparent
                                  : RedColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.moneyBillTrendUp,
                                    color: logic.typePost.value != 'tender'
                                        ? GrayDarkColor
                                        : WhiteColor,
                                    size: 0.04.sw),
                                10.horizontalSpace,
                                Text(
                                  'مناقصات',
                                  style: logic.typePost.value != 'tender'
                                      ? H4GrayTextStyle
                                      : H4WhiteTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            logic.typePost('service');
                          },
                          child: Container(
                            width: 0.2.sw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.009.sw, vertical: 0.009.sh),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: logic.typePost.value != 'service'
                                      ? GrayDarkColor
                                      : RedColor),
                              borderRadius: BorderRadius.circular(15.r),
                              color: logic.typePost.value != 'service'
                                  ? Colors.transparent
                                  : RedColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.servicestack,
                                  color: logic.typePost.value != 'service'
                                      ? GrayDarkColor
                                      : WhiteColor,
                                  size: 0.04.sw,
                                ),
                                10.horizontalSpace,
                                Text(
                                  'خدمة',
                                  style: logic.typePost.value != 'service'
                                      ? H4GrayTextStyle
                                      : H4WhiteTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Divider(
                  color: GrayLightColor,
                  height: 2,
                  thickness: 3,
                ),
                Container(
                  height: 0.1.sh,
                  width: 1.sw,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.9.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: GrayDarkColor),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "${mainController.authUser.value?.logo}",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            10.horizontalSpace,
                            Container(
                              width: 0.6.sw,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(
                                        "انت تنشر باسم :",
                                        style: H5BlackTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Container(
                                      child: Text(
                                        "${mainController.authUser.value?.seller_name ?? mainController.authUser.value?.name}",
                                        style: H1BlackTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.18.sh,
                  child: FormBuilderTextField(
                    validator: FormBuilderValidators.required(
                        errorText: 'يرجى ملء الحقل', checkNullOrEmpty: true),
                    name: 'info',
                    minLines: 6,
                    maxLines: 9,
                    keyboardType: TextInputType.multiline,
                    style: H3BlackTextStyle,
                    controller: logic.infoProduct,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'الوصف ', style: H4GrayTextStyle),
                          TextSpan(text: '*', style: H3RedTextStyle),
                        ]),
                      ),
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),


                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.08.sh,
                  child: FormBuilderDateTimePicker(
                    name: 'start_date',
                    format: DateFormat.yMd(),
                    controller: logic.startDateController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 0.02.sw),
                      floatingLabelStyle: H3BlackTextStyle,
                      labelText: 'بداية التقديم',
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.08.sh,
                  child: FormBuilderDateTimePicker(
                    name: 'end_date',
                    controller: logic.endDateController,
                    format: DateFormat.yMd(),
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 0.02.sw),
                      floatingLabelStyle: H3BlackTextStyle,
                      labelText: 'نهاية التقديم',
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.24.sh,
                  child: FormBuilderFilePicker(
                    previewImages: false,
                    allowCompression: true,
                    typeSelectors: [
                      TypeSelector(
                          type: FileType.custom,
                          selector: Container(
                            width: 0.9.sw,
                            padding: EdgeInsets.all(0.02.sw),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: GrayLightColor),
                            ),
                            child: Text('إضغط لتحديد المرفقات'),
                          ))
                    ],
                    allowedExtensions: ['pdf', 'xlsx', 'docs', 'png', 'jpg'],
                    allowMultiple: false,
                    maxFiles: 1,
                    onChanged: (values) {
                      logic.images.clear();
                      if (values != null) {
                        for (var value in values) {
                          if (value.path != null) {
                            logic.images.add(XFile(value.path!));
                          }
                        }
                      }
                    },
                    name: 'files',
                    validator: FormBuilderValidators.required(
                        errorText: 'يرجى تحديد المرفقات',
                        checkNullOrEmpty: true),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      constraints: BoxConstraints.expand(),
                      floatingLabelStyle: H3BlackTextStyle,
                      label: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: 'مرفقات ', style: H4GrayTextStyle),
                          TextSpan(text: '*', style: H3RedTextStyle),
                        ]),
                      ),
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.08.sh,
                  child: FormBuilderTextField(
                    validator: FormBuilderValidators.email(
                        errorText: 'يرجى ملء الحقل', checkNullOrEmpty: true),
                    name: 'email',
                    keyboardType: TextInputType.emailAddress,
                    style: H3BlackTextStyle,
                    controller: logic.emailController,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: ' البريد الإلكتروني ',
                              style: H4GrayTextStyle),
                          TextSpan(text: '*', style: H3RedTextStyle),
                        ]),
                      ),
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.08.sh,
                  child: FormBuilderTextField(
                    validator: FormBuilderValidators.required(
                        errorText: 'يرجى ملء الحقل', checkNullOrEmpty: true),
                    name: 'phone',
                    keyboardType: TextInputType.phone,
                    style: H3BlackTextStyle,
                    controller: logic.phoneController,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: ' رقم الهاتف ', style: H4GrayTextStyle),
                          TextSpan(text: '*', style: H3RedTextStyle),
                        ]),
                      ),
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.08.sh,
                  child: FormBuilderTextField(

                    name: 'url',
                    validator: FormBuilderValidators.required(
                        errorText: 'يرجى إدخال الرابط'),
                    keyboardType: TextInputType.url,
                    style: H3BlackTextStyle,
                    controller: logic.urlController,
                    decoration: InputDecoration(
                      labelText: 'رابط التقديم',
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.08.sh,
                  child: FormBuilderTextField(
                    validator: FormBuilderValidators.required(
                      errorText: 'يرجى إدخال كود المناقصة',
                    ),
                    name: 'code',
                    keyboardType: TextInputType.text,
                    style: H3BlackTextStyle,
                    controller: logic.codeController,
                    decoration: InputDecoration(
                      labelText: 'كود المناقصة',
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return Container(
                    child: FormBuilderDropdown<CategoryModel>(
                      validator: FormBuilderValidators.required(
                          errorText: 'يرجى تحديد القسم الرئيسي',
                          checkNullOrEmpty: true),
                      decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'القسم الرئيسي',
                                  style: H4GrayTextStyle),
                              TextSpan(text: '*', style: H3RedTextStyle),
                            ]),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: GrayLightColor))),
                      onChanged: (value) => logic.category.value = value,
                      initialValue: logic.category.value ,
                      name: 'category_id',
                      items: [
                        ...List.generate(
                          logic.categories.length,
                              (index) => DropdownMenuItem<CategoryModel>(
                            child: Text(
                              '${logic.categories[index].name}',
                              style: H3BlackTextStyle,
                            ),
                            value: logic.categories[index],
                          ),
                        )
                      ],
                    ),
                  );
                }),
                30.verticalSpace,
                Obx(() {
                  if (logic.category.value != null &&
                      logic.category.value!.children!.length > 0) {
                    List<CategoryModel> categories =
                        logic.category.value!.children?.toList() ?? [];
                    return Container(
                      child: FormBuilderDropdown<CategoryModel>(
                        validator: FormBuilderValidators.required(
                            errorText: 'يرجى تحديد القسم الفرعي',
                            checkNullOrEmpty: true),
                        decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'القسم الفرعي ',
                                    style: H4GrayTextStyle),
                                TextSpan(text: '*', style: H3RedTextStyle),
                              ]),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: GrayLightColor))),
                        onChanged: (value) => logic.subCategory.value = value,
                        name: 'sub_id',
                        items: [
                          ...List.generate(
                            categories.length,
                                (index) => DropdownMenuItem<CategoryModel>(
                              child: Text(
                                '${categories[index].name}',
                                style: H3BlackTextStyle,
                              ),
                              value: categories[index],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
                30.verticalSpace,
                Obx(() {
                  if (logic.subCategory.value != null &&
                      logic.subCategory.value!.children!.length > 0) {
                    List<CategoryModel> categories =
                        logic.subCategory.value!.children?.toList() ?? [];
                    return Container(
                      child: FormBuilderDropdown<CategoryModel>(
                        validator: FormBuilderValidators.required(
                            errorText: 'يرجى تحديد الفرعي الرئيسي',
                            checkNullOrEmpty: true),
                        decoration: InputDecoration(
                            label: Text(
                              'القسم الفرعي 2',
                              style: H3GrayTextStyle,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: GrayLightColor))),
                        onChanged: (value) => logic.sub2Category.value = value,
                        name: 'sub2_id',
                        items: [
                          ...List.generate(
                            categories.length,
                                (index) => DropdownMenuItem<CategoryModel>(
                              child: Text(
                                '${categories[index].name}',
                                style: H3BlackTextStyle,
                              ),
                              value: categories[index],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
                30.verticalSpace,
                Obx(() {
                  if (logic.sub2Category.value != null &&
                      logic.sub2Category.value!.children!.length > 0) {
                    List<CategoryModel> categories =
                        logic.sub2Category.value!.children?.toList() ?? [];
                    return Container(
                      child: FormBuilderDropdown<CategoryModel>(
                        decoration: InputDecoration(
                            label: Text(
                              'القسم الرئيسي',
                              style: H3GrayTextStyle,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: GrayLightColor))),
                        onChanged: (value) => logic.sub3Category.value = value,

                        name: 'sub3_id',
                        items: [
                          ...List.generate(
                            categories.length,
                                (index) => DropdownMenuItem<CategoryModel>(
                              child: Text(
                                '${categories[index].name}',
                                style: H3BlackTextStyle,
                              ),
                              value: categories[index],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
                30.verticalSpace,
                InkWell(
                  onTap: () {
                    print(logic.formState.currentState?.validate());
                    if (logic.formState.currentState?.validate() == true) {
                      logic.saveData();
                    } else {
                      final firstErrorField = logic.formState.currentState?.context
                          .findRenderObject() as RenderBox?;

                      if (firstErrorField != null) {
                        _scrollController.animateTo(
                          firstErrorField.localToGlobal(Offset.zero).dy,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                  },
                  child: Container(
                    width: 0.8.sw,
                    height: 0.05.sh,
                    alignment: Alignment.center,
                    child: Text(
                      'إرسال للنشر',
                      style: H3WhiteTextStyle,
                    ),
                    decoration: BoxDecoration(
                      color: RedColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
