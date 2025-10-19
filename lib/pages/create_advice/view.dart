import 'dart:io';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:logger/logger.dart';

import 'logic.dart';

class CreateAdvicePage extends StatelessWidget {
  final logic = Get.find<CreateAdviceLogic>();
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
        backgroundColor: PrimaryColor,
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
                  isExpanded: true,
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
                  menuWidth: 0.8.sw,
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
                /*  Obx(() {

                  return FormBuilderImagePicker(
                    initialValue:[logic.image.value],

                    name: 'image',
                    maxImages: 1,
                    fit: BoxFit.cover,
                    previewAutoSizeWidth: true,
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
                    onChanged: (values)async {

                      if(values!=null){
                        XFile? imageCroppedImage = values.first;
                        imageCroppedImage=await logic.mainController.cropImage(values.first,ratio: CropAspectRatio(ratioX: 2, ratioY: 1));
                        logic.image.value = imageCroppedImage;
logic.imagesList.clear();
logic.imagesList.add(imageCroppedImage);
logic.image.refresh();
                      }


                    },
                  );
                }),*/
                //////////////////////
                Obx(() {
                  return Visibility(
                    visible: logic.image.value == null,
                    child: InkWell(
                      onTap: () {
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
                                      aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 1),
                                      onChange: (file, fileSize) {
                                        logic.image.value = file!;
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
                                    logic.mainController.pickImage(
                                        imagSource: ImageSource.camera,
                                        aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 1),
                                        onChange: (file, fileSize) {
                                          logic.image.value = file!;
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
                                    text: 'حدد صورة ',
                                    style: H4GrayTextStyle),
                                TextSpan(text: '*', style: H3RedTextStyle),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Obx((){
                  return Visibility(child: Stack(
                    children: [
                      Container(
                        width: 1.sw,
                        height: 0.33.sw,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File("${logic.image.value?.path}")),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                        logic.image.value=null;
                      }, icon: Icon(FontAwesomeIcons.trash,color: PrimaryColor,))
                    ],
                  ),visible: logic.image.value!=null,);
                }),
                //////////////////////
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
                    color: PrimaryColor,);
                }))
              ],
            )),
      ),
    );
  }
}
