import 'dart:io';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CreateCommunityPage extends StatelessWidget {
  CreateCommunityPage({Key? key}) : super(key: key);
  MainController mainController = Get.find<MainController>();
  final logic = Get.find<CreateCommunityLogic>();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
            height: 0.05.sh,
            width: 1.sw,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: RedColor,
            ),
            child: Text(
              'إنشاء ${logic.type == 'group' ? 'مجموعة' : 'قناة'}',
              style: H4WhiteTextStyle,
            ),
          ),
          SizedBox(
            height: 0.02.sh,
          ),
          Container(
            width: 0.85.sw,
            decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(30.r)),
            padding:
                EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.02.sh),
            child: Text(
              "${logic.message}",
              style: H2RegularDark,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.02.sh),
            child: FormBuilder(
              key: formKey,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  controller: logic.nameController,
                  name: 'name',
                  validator: FormBuilderValidators.required(
                      errorText:
                          'يرجى كتابة اسم ${logic.type == 'group' ? 'المجموعة' : 'القناة'}'),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: const BorderSide(
                          color: GrayLightColor,
                        ),
                      ),
                      labelStyle: H3GrayTextStyle,
                      labelText:
                          'اسم ${logic.type == 'group' ? 'المجموعة' : 'القناة'}'),
                ),
                SizedBox(
                  height: 0.05.sh,
                ),
                Column(
                  children: [
                    Text(
                      "حدد صورة ${logic.type == 'group' ? 'المجموعة' : 'القناة'}",
                      style: H4BlackTextStyle,
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/png/no-img.png'))),
                      child: InkWell(
                        onTap: () {
                          logic.pickAvatar(
                              imagSource: ImageSource.gallery,
                              onChange: (file, size) {
                                logic.avatar.value = file;
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
                SizedBox(
                  height: 0.05.sh,
                ),
                Obx(() {
                  if (logic.loading.value) {
                    return Container(
                      width: 0.2.sw,
                      child: ProgressLoading(),
                    );
                  }
                  return InkWell(
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        if(logic.avatar.value ==null){
                          messageBox(title: 'خطأ',message: 'يرجى تحديد صورة ${logic.type == 'group' ? 'مجموعة' : 'قناة'}',isError: true);
                          return;
                        }
                        logic.saveData();
                      }
                    },
                    child: Container(
                      height: 0.05.sh,
                      width: 0.5.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: RedColor,
                      ),
                      child: Text(
                        'إنشاء ${logic.type == 'group' ? 'مجموعة' : 'قناة'}',
                        style: H4WhiteTextStyle,
                      ),
                    ),
                  );
                }),
              ],
            )),
          )),
        ],
      ),
    );
  }
}
