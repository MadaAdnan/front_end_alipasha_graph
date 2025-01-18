import 'dart:io';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'logic.dart';

class CreateAdvicePage extends StatelessWidget {
  final logic = Get.put(CreateAdviceLogic());
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        title: Text(
          "إضافة إعلان",
          style: H3WhiteTextStyle,
        ),
        centerTitle: true,
        backgroundColor: RedColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sh),
        child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  style: H3RegularDark,
                  controller: logic.nameController,
                  validator:
                  FormBuilderValidators.required(errorText: "الحقل مطلوب"),
                  name: 'name',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: GrayLightColor)),
                      label: Text(
                        'إسم الإعلان',
                        style: H3RegularDark,
                      )),
                ),
                SizedBox(
                  height: 0.04.sh,
                ),
                FormBuilderTextField(
                  style: H3RegularDark,
                  controller: logic.urlController,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.url(errorText: "رابط غير صالح"),
                  ]),
                  name: 'url',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: GrayLightColor)),
                      label: Text(
                        'رابط الزيارة',
                        style: H3RegularDark,
                      )),
                ),
                SizedBox(
                  height: 0.04.sh,
                ),
                FormBuilderDropdown(
                  isExpanded: false,
                  style: H3RegularDark,
                  decoration: InputDecoration(
                      label: Text(
                        'القسم',
                        style: H3RegularDark,
                      ),
                      helper: Text(
                        'عند تحديد القسم سيظهر الإعلان فقط في القسم المحدد والاقسام التابعة له',
                        style: H5RedTextStyle,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: GrayLightColor))),
                  name: 'category',
                  items: mainController.categories
                      .where((el) =>
                  el.type == 'product' || el.type == 'restaurant')
                      .map((el) =>
                      DropdownMenuItem(
                        child: Text("${el.name}"),
                        value: el,
                      ))
                      .toList(),
                  onChanged: (value) => logic.category.value = value,
                ),
                SizedBox(
                  height: 0.04.sh,
                ),
                Obx(() {
                  return FormBuilderImagePicker(
                    initialValue: [logic.image.value],
                    name: 'image',
                    maxImages: 1,
                    fit: BoxFit.cover,
                    maxHeight: 300,
                    maxWidth: 600,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'الصورة مطلوبة'),
                    ]),
                    decoration: InputDecoration(
                      label: Text(
                        'الصورة',
                        style: H3RegularDark,
                      ),
                      helper: Text(
                        'يجب أن تكون أبعاد الصورة العرض ضعف الإرتفاع مثال : 300 * 600',
                        style: H5RedTextStyle,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: GrayLightColor)),
                    ),
                    onChanged: (values) => logic.image.value = values?.first,
                  );
                }),
                SizedBox(
                  height: 0.04.sh,
                ),
                SizedBox(width: 1.sw, child: Obx(() {
                  if (logic.loading.value) {
                    return Center(
                        child: Text('جاري الحفظ ...', style: H4RedTextStyle,));
                  }
                  return MaterialButton(onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      logic.saveAdvice();
                    }
                  },
                    child: Text('حفظ', style: H3WhiteTextStyle,),
                    color: RedColor,);
                }))
              ],
            )),
      ),
    );
  }
}
