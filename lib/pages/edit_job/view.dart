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
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../models/attribute_model.dart';
import '../../models/category_model.dart';
import 'logic.dart';

class EditJobPage extends StatelessWidget {
  EditJobPage({Key? key}) : super(key: key);

  final logic = Get.find<EditJobLogic>();
  final MainController mainController = Get.find<MainController>();

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
                    key: logic.formState,
                    child: Column(children: [
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
                                            "${mainController.authUser.value?.image}",
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Container(
                                    width: 0.6.sw,
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
                              errorText: 'يرجى ملء الحقل',
                              checkNullOrEmpty: true),
                          name: 'info',
                          minLines: 6,
                          maxLines: 9,
                          keyboardType: TextInputType.multiline,
                          style: H3BlackTextStyle,
                          controller: logic.infoProduct,
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'الوصف ', style: H4GrayTextStyle),
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
                      /*Obx(() {
                        return Container(
                          width: 1.sw,
                          height: 0.08.sh,
                          child: FormBuilderChoiceChip(
                            options: [
                              FormBuilderChipOption(
                                value: 'job',
                                child: Text(
                                  'شاغر وظيفي',
                                  style: H3BlackTextStyle,
                                ),
                              ),
                              FormBuilderChipOption(
                                value: 'search_job',
                                child: Text(
                                  'أبحث عن وظيفة',
                                  style: H3BlackTextStyle,
                                ),
                              ),
                            ],
                            name: 'type',
                            validator: FormBuilderValidators.required(
                                errorText: 'يرجى إختيار نوع المنشور',
                                checkNullOrEmpty: true),
                            initialValue: logic.typeProduct.value,
                            onChanged: (value) {
                              logic.typeProduct.value = value;
                            },
                            alignment: WrapAlignment.spaceAround,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              floatingLabelStyle: H3BlackTextStyle,
                              label: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'نوع المنشور ',
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
                        );
                      }),
                      30.verticalSpace,*/
                      Obx(() {
                        return Visibility(
                          visible: logic.typeProduct.value == 'job',
                          child: Container(
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
                        );
                      }),
                      30.verticalSpace,
                      Obx(() {
                        return Visibility(
                          visible: logic.typeProduct.value == 'job',
                          child: Container(
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
                        );
                      }),
                      30.verticalSpace,

                      //file
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...List.generate(
                              logic.attachments.length,
                                  (index) => Stack(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      openUrl(url: "${logic.attachments[index].url}");
                                    },
                                    child:  Container(
                                      width: 0.3.sw,
                                      height: 0.3.sw,
                                      child: Icon(FontAwesomeIcons.fileInvoice,size: 0.25.sw,color: GrayLightColor,),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
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
                                      icon: Icon(FontAwesomeIcons.trash,color: RedColor,))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(() {
                        return Visibility(visible: logic.attachments.length==0,child:  Container(
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
                            allowedExtensions: const [
                              'pdf',
                              'xlsx',
                              'docs',
                              'png',
                              'jpg'
                            ],
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
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              constraints: BoxConstraints.expand(),
                              floatingLabelStyle: H3BlackTextStyle,
                              label: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'مرفقات ', style: H4GrayTextStyle),
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
                        ),);
                      }),
                      30.verticalSpace,
                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.email(
                              errorText: 'يرجى ملء الحقل',
                              checkNullOrEmpty: true),
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
                              errorText: 'يرجى ملء الحقل',
                              checkNullOrEmpty: true),
                          name: 'phone',
                          keyboardType: TextInputType.phone,
                          style: H3BlackTextStyle,
                          controller: logic.phoneController,
                          decoration: InputDecoration(
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ' رقم الهاتف ',
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
                      Obx(() {
                        return Visibility(
                          visible: logic.typeProduct.value == 'job',
                          child: Container(
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
                        );
                      }),
                      30.verticalSpace,
                      Obx(() {
                        return Visibility(
                          visible: logic.typeProduct.value == 'job',
                          child: Container(
                            width: 1.sw,
                            height: 0.08.sh,
                            child: FormBuilderTextField(
                              validator: FormBuilderValidators.required(
                                errorText: 'يرجى إدخال كود الوظيفة',
                              ),
                              name: 'code',
                              keyboardType: TextInputType.text,
                              style: H3BlackTextStyle,
                              controller: logic.codeController,
                              decoration: InputDecoration(
                                labelText: 'كود الوظيفة',
                                labelStyle: H4GrayTextStyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
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
                                  label: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'القسم الفرعي ',
                                          style: H4GrayTextStyle),
                                      TextSpan(
                                          text: '*', style: H3RedTextStyle),
                                    ]),
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
                                            logic.options.value[attr.id!] = [
                                              value
                                            ];
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
                                          child: Text(
                                              '${attr.attributes![i].name}'),
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
                      InkWell(
                        onTap: () {
                          print(logic.formState.currentState?.validate());
                          if (logic.formState.currentState?.validate() ==
                              true) {
                            logic.saveData();
                          } else {
                            final firstErrorField = logic
                                .formState.currentState?.context
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
              ),
              if (logic.loading.value)
                Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        }));
  }
}
