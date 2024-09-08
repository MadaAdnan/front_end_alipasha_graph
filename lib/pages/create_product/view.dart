import 'dart:io';
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/helper_class.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/attribute_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'logic.dart';

class CreateProductPage extends StatelessWidget {
  CreateProductPage({Key? key}) : super(key: key);

  final logic = Get.find<CreateProductLogic>();

  final MainController mainController = Get.find<MainController>();

  final _formState = GlobalKey<FormState>();

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
                      Container(
                        width: 0.38.sw,
                        child: FormBuilderDropdown(
                          decoration: InputDecoration(
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
                      labelText: 'الوصف',
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
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Icon(
                                FontAwesomeIcons.dollarSign,
                                size: 0.03.sw,
                              ),
                              labelText: 'السعر',
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
                  height: 0.18.sh,
                  child: FormBuilderTextField(
                    validator: FormBuilderValidators.url(
                        errorText: 'يرجى إدخال رابط صحيح',
                        checkNullOrEmpty: false),
                    name: 'video',
                    keyboardType: TextInputType.url,
                    style: H3BlackTextStyle,
                    controller: logic.videoController,
                    decoration: InputDecoration(
                      labelText: 'رابط الفيديو',
                      labelStyle: H4GrayTextStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (logic.images.length < 3) {
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
                                    onChange: (file, fileSize) =>
                                        logic.images.add(file!),
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
                                  if (logic.images.length >= 3) {
                                    Get.back();
                                  }
                                  logic.mainController.pickImage(
                                      imagSource: ImageSource.camera,
                                      onChange: (file, fileSize) {
                                        logic.images.add(file!);
                                      });
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
                    height: 0.07.sh,
                    decoration: BoxDecoration(
                      border: Border.all(color: GrayLightColor),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(FontAwesomeIcons.image),
                        40.horizontalSpace,
                        Text(
                          'حدد صورة او عدة صور',
                          style: H4GrayTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                30.verticalSpace,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(
                          logic.images.length,
                          (index) => Stack(
                                children: [
                                  Container(
                                    width: 0.25.sw,
                                    height: 0.25.sw,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        image: DecorationImage(
                                            image: FileImage(File.fromUri(
                                                Uri.file(logic
                                                    .images[index].path))))),
                                  ),
                                  Positioned(
                                    child: InkWell(
                                        onTap: () {
                                          logic.images.removeAt(index);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 0.06.sw,
                                          height: 0.06.sw,
                                          child: Icon(
                                            Icons.close,
                                            color: WhiteColor,
                                            size: 0.04.sw,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: RedColor,
                                          ),
                                        )),
                                    right: 0,
                                    top: 0,
                                  )
                                ],
                              ))
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
                            label: Text(
                              'القسم الفرعي',
                              style: H3GrayTextStyle,
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
                              margin: EdgeInsets.only(bottom: 0.02.sh),
                              child: FormBuilderDropdown<int>(
                                  onChanged: (value) {
                                    if (value != null) {
                                      logic.options.value[attr.id!] = [value];
                                    }
                                  },
                                  decoration: InputDecoration(
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
                          return Container();
                        })
                      ],
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
                                    ))
                          ],
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
                InkWell(
                  onTap: () {
                    print(_formState.currentState?.validate());
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
    );
  }

  Widget _dropDownButton({
    required List<DropdownMenuItem<int>> items,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.002.sh),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<int>(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
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
          value: logic.periodProduct.value,
          onChanged: (value) {
            logic.periodProduct.value = value;
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
            icon: const Icon(
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
  }
}
