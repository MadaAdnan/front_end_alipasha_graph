import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../models/attribute_model.dart';
import '../../models/category_model.dart';
import 'logic.dart';

class EditProductPage extends StatelessWidget {
  EditProductPage({Key? key}) : super(key: key);

  final logic = Get.find<EditProductLogic>();

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
                                    width: 0.3.sw,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Text(
                                          "انت تنشر باسم :",
                                          style: H5BlackTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                        Container(
                                            child: Text(
                                          "${mainController.authUser.value?.seller_name ?? mainController.authUser.value?.name} متجر علي باشا باشا",
                                          style: H1BlackTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                           /* Container(
                              width: 0.38.sw,
                              child: FormBuilderDropdown(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: GrayLightColor),
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
                                        style: H5BlackTextStyle,
                                      )),
                                  DropdownMenuItem(
                                      value: 90,
                                      child: Text(
                                        'نشر لمدة 3 أشهر',
                                        style: H5BlackTextStyle,
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
                                        style: H5BlackTextStyle,
                                      )),
                                  DropdownMenuItem(
                                      value: 7,
                                      child: Text(
                                        'نشر لمدة اسبوع واحد',
                                        style: H5BlackTextStyle,
                                      )),
                                ],
                                name: 'period',
                              ),
                            ),*/
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
                                TextSpan(
                                    text: 'اسم المنتج', style: H4GrayTextStyle),
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
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'الوصف المنتج',
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
                                validator: FormBuilderValidators.numeric(),
                                decoration: InputDecoration(
                                    errorStyle: H5RedTextStyle,
                                    contentPadding: EdgeInsets.zero,
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.dollarSign,
                                      size: 0.03.sw,
                                    ),
                                    label: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'السعر الأصلي بالدولار',
                                            style: H4GrayTextStyle),
                                        TextSpan(
                                            text: '*', style: H3RedTextStyle),
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
                                style: H3BlackTextStyle,
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
                        height: 0.08.sh,
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

                    Obx(() {
                      return Visibility(child:   InkWell(
                        onTap: () {
                          if (logic.images.length < 4) {
                            Get.defaultDialog(
                                title: 'إختر مكان الصورة',
                                titleStyle: H3BlackTextStyle,
                                titlePadding:
                                EdgeInsets.symmetric(vertical: 0.02.sh),
                                content: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        logic.mainController.pickImage(
                                          imagSource: ImageSource.gallery,
                                          onChange: (file, fileSize) {
                                            logic.images.add(file!);
                                          },
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
                                  TextSpan(
                                      text: 'حدد صورة او عدة صور',
                                      style: H4GrayTextStyle),
                                  TextSpan(text: '*', style: H3RedTextStyle),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),visible: logic.images.length + logic.attachments.length <4,);
                    }),

                      30.verticalSpace,
                      Obx(
                        () => Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
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
                                                          .images[index]
                                                          .path))))),
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
                                    ),),
                            ...List.generate(
                                logic.attachments.length,
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
                                              image:NetworkImage("${logic.attachments[index].url}"),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: InkWell(
                                              onTap: () {
                                                Get.defaultDialog(
                                                  title: 'حذف المرفق',
                                                  titleStyle: H3RedTextStyle,
                                                  middleText:
                                                  'انت على وشك حذف هذا المرفق',
                                                  middleTextStyle: H3GrayTextStyle,
                                                  textCancel: 'إلغاء الأمر',
                                                  textConfirm: 'تأكيد',
                                                  onConfirm: () {
                                                    Get.back();
                                                    logic.deleteMedia(
                                                        logic.attachments[index].id!);
                                                  },
                                                );

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
                                    ),)
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      Container(
                        child: Text(
                          'ماهو تصنيف المنشور؟',
                          style: H3BlackTextStyle,
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      20.verticalSpace,
                      Obx(() {
                        return Container(
                          child: FormBuilderDropdown<CategoryModel>(
                            validator: FormBuilderValidators.required(
                                errorText: 'يرجى تحديد القسم الرئيسي',
                                checkNullOrEmpty: true),
                            decoration: InputDecoration(
                                label: Text(
                                  'القسم الرئيسي',
                                  style: H3GrayTextStyle,
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: GrayLightColor))),
                            onChanged: (value) => logic.category.value = value,
                            initialValue: logic.category.value,
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
                                  label: Text(
                                    'القسم الفرعي',
                                    style: H3GrayTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: GrayLightColor))),
                              onChanged: (value) =>
                                  logic.subCategory.value = value,
                              initialValue: logic.subCategory.value,
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
                                      borderSide:
                                          BorderSide(color: GrayLightColor))),
                              onChanged: (value) =>
                                  logic.sub2Category.value = value,
                              initialValue: logic.sub2Category.value,
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
                              logic.sub2Category.value!.children?.toList() ??
                                  [];
                          return Container(
                            child: FormBuilderDropdown<CategoryModel>(
                              decoration: InputDecoration(
                                  label: Text(
                                    'القسم الرئيسي',
                                    style: H3GrayTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: GrayLightColor))),
                              onChanged: (value) =>
                                  logic.sub3Category.value = value,
                              initialValue: logic.sub3Category.value,
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
                                              if (logic.colorIds.contains(
                                                  logic.colors[index].id)) {
                                                logic.colorIds.remove(
                                                    logic.colors[index].id);
                                              } else {
                                                logic.colorIds.add(
                                                    logic.colors[index].id!);
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(0.02.sw),
                                              width: 0.1.sw,
                                              height: 0.1.sw,
                                              decoration: BoxDecoration(
                                                  border: logic.colorIds
                                                          .contains(logic
                                                              .colors[index].id)
                                                      ? Border.all(
                                                          color: RedColor)
                                                      : null,
                                                  shape: BoxShape.circle,
                                                  color: logic
                                                      .colors[index].code
                                                      ?.toColor()),
                                              child: Container(
                                                width: 0.05.sw,
                                                height: 0.05.sw,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: GrayLightColor,
                                                        width: 2),
                                                    shape: BoxShape.circle,
                                                    color: logic
                                                        .colors[index].code
                                                        ?.toColor()),
                                              ),
                                            ),
                                          ))
                                ],
                              ),
                            ],
                          );
                        }
                        return Container();
                      }),
                      80.verticalSpace,
                      InkWell(
                        onTap: () {

                          if (_formState.currentState?.validate() == true) {
                            logic.saveData();
                          } else {
                            final firstErrorField = _formState
                                .currentState?.context
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
            if (logic.loading.value)
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      }),
    );
  }
}
