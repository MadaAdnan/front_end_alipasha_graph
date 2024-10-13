import 'dart:io';
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';

import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/attribute_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'logic.dart';

class CreateProductPage extends StatelessWidget {
  CreateProductPage({Key? key}) : super(key: key);

  final logic = Get.find<CreateProductLogic>();

  final MainController mainController = Get.find<MainController>();

  final _formState = GlobalKey<FormBuilderState>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Obx(() {
        return Stack(
          children: [
            Container(
              width: 1.sw,
              height: 1.sh,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: FormBuilder(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formState,
                  child: Column(
                    children: [
                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 0.02.sh),
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
                                        'منتج',
                                        style: logic.typePost.value != 'product'
                                            ? H4GrayTextStyle
                                            : H4WhiteTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offAndToNamed(CREATE_JOB_PAGE);
                                },
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
                                        'وظيفة',
                                        style: logic.typePost.value != 'job'
                                            ? H4GrayTextStyle
                                            : H4WhiteTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offAndToNamed(CREATE_TENDER_PAGE);
                                },
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
                                        'مناقصة',
                                        style: logic.typePost.value != 'tender'
                                            ? H4GrayTextStyle
                                            : H4WhiteTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offAndToNamed(CREATE_SERVICE_PAGE);
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
                        height: 1,
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
                              width: 0.55.sw,
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
                                    width: 0.44.sw,
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
                            Container(
                              width: 0.38.sw,
                              child: FormBuilderDropdown(
                                decoration: InputDecoration(
                                  errorStyle: H5RedTextStyle,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0.01.sw),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: GrayLightColor),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                ),
                                onChanged: (value) {
                                  logic.periodProduct.value = value;
                                },
                                initialValue: logic.periodProduct.value,
                                items: [
                                  DropdownMenuItem(
                                      value: 360,
                                      child: Text(
                                        'نشر بدون مدة',
                                        style: H4BlackTextStyle,
                                      )),
                                  DropdownMenuItem(
                                      value: 90,
                                      child: Text(
                                        'نشر لمدة 3 أشهر',
                                        style: H4BlackTextStyle,
                                      )),
                                  DropdownMenuItem(
                                      value: 30,
                                      child: Text(
                                        'نشر لمدة شهر واحد',
                                        style: H5BlackTextStyle,
                                      )),
                                  DropdownMenuItem(
                                      value: 15,
                                      child: Text(
                                        'نشر لمدة 15 يوم',
                                        style: H4BlackTextStyle,
                                      )),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text(
                                        'نشر لمدة اسبوع واحد',
                                        style: H4BlackTextStyle,
                                      )),
                                ],
                                name: 'period',
                              ),
                            ),
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.required(
                            errorText: 'يرجى إدخال الاسم',
                          ),
                          name: 'name',
                          keyboardType: TextInputType.text,
                          style: H3BlackTextStyle,
                          controller: logic.nameController,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,

                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(text: 'اسم المنتج', style: H4GrayTextStyle),
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
                        height: 0.18.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.required(
                              errorText: 'يرجى كتابة وصف للمنتج',
                              checkNullOrEmpty: true),
                          name: 'info',
                          minLines: 6,
                          maxLines: 9,
                          keyboardType: TextInputType.multiline,
                          style: H3BlackTextStyle,
                          controller: logic.infoProduct,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,
                            alignLabelWithHint: true,
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(text: 'الوصف المنتج', style: H4GrayTextStyle),
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

                      // body
                      Container(
                        width: 1.sw,
                        height: 0.09.sh,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 0.33.sw,
                              child: FormBuilderTextField(
                                name: 'price',
                                controller: logic.priceController,
                                keyboardType: TextInputType.number,
                                style: H3BlackTextStyle,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'يرجى إدخال السعر'),
                                  FormBuilderValidators.numeric(
                                      errorText: 'يرجى إدخال السعر'),
                                ]),
                                decoration: InputDecoration(
                                    errorStyle: H5RedTextStyle,
                                    contentPadding: EdgeInsets.zero,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.dollarSign,
                                      size: 0.03.sw,
                                    ),
                                    label: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(text: 'السعر الأصلي بالدولار', style: H4GrayTextStyle),
                                        TextSpan(text: '*', style: H3RedTextStyle),
                                      ]),
                                    ),

                                    labelStyle: H4GrayTextStyle,
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: GrayLightColor))),
                              ),
                            ),
                            Container(
                              width: 0.33.sw,
                              child: FormBuilderTextField(
                                name: 'discount',
                                style: H4BlackTextStyle,
                                controller: logic.discountController,
                                keyboardType: TextInputType.number,
                                validator: FormBuilderValidators.numeric(
                                    errorText: 'يرجى إدخال قيمة رقمية',
                                    checkNullOrEmpty: false),
                                decoration: InputDecoration(
                                    errorStyle: H5RedTextStyle,
                                    contentPadding: EdgeInsets.zero,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.arrowTrendDown,
                                      size: 0.03.sw,
                                    ),
                                    labelText: 'بعد الحسم',
                                    labelStyle: H4GrayTextStyle,
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: GrayLightColor))),
                              ),
                            ),
                            Obx(() {
                              return Container(
                                width: 0.25.sw,
                                child: Column(
                                  children: [
                                    Text(
                                      'التوفر بالمخزون',
                                      style: H4BlackTextStyle,
                                    ),
                                    Switch(
                                      onChanged: (value) {
                                        logic.isAvailable.value = value;
                                      },
                                      activeColor: Colors.green,
                                      value: logic.isAvailable.value,
                                    ),
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      30.verticalSpace,

                      Container(
                        width: 1.sw,
                        height: 0.06.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.url(
                              errorText: 'يرجى إدخال رابط صحيح',
                              checkNullOrEmpty: false),
                          name: 'video',
                          keyboardType: TextInputType.url,
                          style: H3BlackTextStyle,
                          controller: logic.videoController,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,
                            prefixIcon: Icon(
                              FontAwesomeIcons.youtube,
                              color: RedColor,
                            ),
                            labelText: 'رابط الفيديو (اختياري)',
                            labelStyle: H4GrayTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      InkWell(
                        onTap: () {
                          if (logic.images.length < 4) {
                            Get.defaultDialog(
                                title: 'إختر مكان الصورة',
                                titleStyle: H3BlackTextStyle,
                                titlePadding: EdgeInsets.symmetric(vertical: 0.02.sh),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        logic.mainController.pickImage(
                                          imagSource: ImageSource.gallery,
                                          onChange: (file, fileSize) {
                                            logic.images.add(file!);
                                          }
                                          ,
                                        );
                                        Get.back();
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(FontAwesomeIcons.images),
                                            Text(
                                              'المعرض',
                                              style: H3GrayTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (logic.images.length >= 4) {
                                          Get.back();
                                        }
                                        logic.mainController.pickImage(
                                            imagSource: ImageSource.camera,
                                            onChange: (file, fileSize) {
                                              logic.images.add(file!);
                                            });
                                        Get.back();
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Icon(FontAwesomeIcons.camera),
                                            Text(
                                              'الكاميرا',
                                              style: H3GrayTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          }
                        },
                        child: Container(
                          width: 1.sw,
                          height: 0.08.sh,
                          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                          decoration: BoxDecoration(
                            border: Border.all(color: GrayLightColor),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.image),
                              40.horizontalSpace,
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(text: 'حدد صورة او عدة صور', style: H4GrayTextStyle),
                                  TextSpan(text: '*', style: H3RedTextStyle),
                                ]),
                              ),

                            ],
                          ),
                        ),
                      ),



                      30.verticalSpace,
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(
                                logic.images.length,
                                    (index) => Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0.01.sw),
                                      width: 0.22.sw,
                                      height: 0.22.sw,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15.r),
                                          image: DecorationImage(
                                              image: FileImage(File.fromUri(
                                                  Uri.file(logic
                                                      .images[index].path))))),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: InkWell(
                                          onTap: () {
                                            logic.images.removeAt(index);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 0.06.sw,
                                            height: 0.06.sw,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: RedColor,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: WhiteColor,
                                              size: 0.04.sw,
                                            ),
                                          )),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Obx(() {
                        return Visibility(child: Container(child: Text('${logic.errorImage.value}',style: H5RedTextStyle,),alignment: Alignment.centerRight,),visible: logic.errorImage.value!=null,);
                      }),
                      30.verticalSpace,
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ماهو تصنيف المنشور؟',
                          style: H3BlackTextStyle,
                        ),
                      ),
                      30.verticalSpace,
                      Obx(() {
                        return Container(
                          child: FormBuilderDropdown<CategoryModel>(
                            validator: FormBuilderValidators.required(
                                errorText: 'يرجى تحديد القسم الرئيسي',
                                checkNullOrEmpty: true),
                            decoration: InputDecoration(
                                errorStyle: H5RedTextStyle,
                                label: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(text: 'القسم الرئيسي', style: H4GrayTextStyle),
                                    TextSpan(text: '*', style: H3RedTextStyle),
                                  ]),
                                ),

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: GrayLightColor))),
                            onChanged: (value) => logic.category.value = value,
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
                                  errorStyle: H5RedTextStyle,
                                  label: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(text: 'القسم الفرعي', style: H4GrayTextStyle),
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
                        return SizedBox(height:0);
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
                                  errorText: 'يرجى تحديد الفرعي 2',
                                  checkNullOrEmpty: true),
                              decoration: InputDecoration(
                                  errorStyle: H5RedTextStyle,
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
                        return SizedBox(height:0);
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
                                  errorStyle: H5RedTextStyle,
                                  label: Text(
                                    'القسم الفرعي 3',
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
                        return SizedBox(height:0);
                      }),
                      30.verticalSpace,
                      Obx(() {
                        if (logic.subCategory.value != null &&
                            logic.subCategory.value!.attributes!.length > 0) {
                          return Column(
                            children: [
                              ...List.generate(
                                  logic.subCategory.value!.attributes!.length,
                                      (index) {
                                    AttributeModel attr =
                                    logic.subCategory.value!.attributes![index];
                                    if (attr.type == 'limit') {
                                      return Container(
                                        height: 0.06.sh,
                                        margin: EdgeInsets.only(bottom: 0.02.sh),
                                        child: FormBuilderDropdown<int>(
                                            onChanged: (value) {
                                              if (value != null) {
                                                logic.options.value[attr.id!] = [value];
                                              }
                                            },

                                            decoration: InputDecoration(
                                              errorStyle: H5RedTextStyle,
                                              labelText: '${attr.name}',
                                              labelStyle: H3GrayTextStyle,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: GrayLightColor,
                                                ),
                                              ),
                                            ),
                                            name: 'options.${attr.id}',
                                            items: [
                                              ...List.generate(
                                                attr.attributes!.length,
                                                    (i) => DropdownMenuItem<int>(

                                                  child: Text(
                                                    '${attr.attributes![i].name}',
                                                    style: H3BlackTextStyle,
                                                  ),
                                                  value: attr.attributes![i].id,
                                                ),
                                              )
                                            ]),
                                      );
                                    } else if (attr.type == 'multiple') {
                                      return FormBuilderFilterChip(
                                        labelStyle: H3BlackTextStyle,
                                        alignment: WrapAlignment.spaceEvenly,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        checkmarkColor: WhiteColor,
                                        selectedColor: RedColor.withOpacity(0.5),
                                        onChanged: (values) {
                                          if (values != null) {
                                            logic.options.value[attr.id!] = values;
                                          }
                                        },
                                        name: 'options',
                                        decoration: InputDecoration(
                                          labelText: '${attr.name}',
                                          labelStyle: H3GrayTextStyle,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: GrayLightColor,
                                            ),
                                          ),
                                        ),
                                        options: [
                                          ...List.generate(
                                            attr.attributes!.length,
                                                (i) => FormBuilderChipOption(
                                              value: attr.attributes![i].id,
                                              child: Text('${attr.attributes![i].name}'),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                    return SizedBox(height:0);
                                  })
                            ],
                          );
                        }
                        return SizedBox(height:0);
                      }),
                      30.verticalSpace,
                      Obx(() {
                        if (logic.category.value != null &&
                            logic.category.value?.hasColor == true) {
                          return Column(
                            children: [
                              Container(
                                child: Text(
                                  'متوفر بالألوان',
                                  style: H3BlackTextStyle,
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Wrap(
                                children: [
                                  ...List.generate(
                                      logic.colors.length,
                                          (index) => InkWell(
                                        onTap: () {
                                          if (logic.colorIds
                                              .contains(logic.colors[index].id)) {
                                            logic.colorIds
                                                .remove(logic.colors[index].id);
                                          } else {
                                            logic.colorIds
                                                .add(logic.colors[index].id!);
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(0.02.sw),
                                          width: 0.1.sw,
                                          height: 0.1.sw,
                                          decoration: BoxDecoration(
                                              border: logic.colorIds.contains(
                                                  logic.colors[index].id)
                                                  ? Border.all(color: RedColor)
                                                  : null,
                                              shape: BoxShape.circle,
                                              color: logic.colors[index].code
                                                  ?.toColor()),
                                          child: Container(
                                            width: 0.05.sw,
                                            height: 0.05.sw,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: GrayLightColor,
                                                    width: 2),
                                                shape: BoxShape.circle,
                                                color: logic.colors[index].code
                                                    ?.toColor()),
                                          ),
                                        ),
                                      )),

                                ],
                              ),
                            ],
                          );
                        }
                        return SizedBox(height:0);
                      }),
                      80.verticalSpace,
                      InkWell(
                        onTap: () {
                          logic.errorImage.value=null;
                          if(logic.images.length==0){
                            logic.errorImage.value="يرجى تحديد صورة واحدة على الأقل";
                            return ;
                          }
                          if (_formState.currentState?.validate() == true) {
                            logic.saveData();
                          } else {
                            final firstErrorField = _formState.currentState?.context
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            if(logic.loading.value) Container(child: Center(child: CircularProgressIndicator(),),)
          ],
        );
      }),
    );
  }


}
