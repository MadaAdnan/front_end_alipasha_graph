import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class VerifyEmailPage extends StatelessWidget {
  VerifyEmailPage({Key? key}) : super(key: key);

  final logic = Get.find<VerifyEmailLogic>();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputComponent(
                width: 1.sw,
                controller: logic.codeController,
                fill: WhiteColor,
                isRequired: true,
                hint: 'كود التفعيل',
                validation: (value) {
                  if (value?.length == 0) {
                    return 'يرجى إدخال الكود';
                  }
                },
              ),
              15.verticalSpace,
              Obx(() {
                return Visibility(
                  child: Text(
                    '${logic.error.value}',
                    style: H4RedTextStyle,
                  ),
                  visible: logic.error.value != null,
                );
              }),
              15.verticalSpace,
              Obx(() {
                if (logic.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return InkWell(
                  onTap: () {
                    logic.error.value = null;

                    if (_form.currentState!.validate()) {
                      logic.verify();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 1.sw,
                    height: 0.12.sw,
                    decoration: BoxDecoration(
                        color: RedColor,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Text(
                      'تفعيل',
                      style: H3WhiteTextStyle,
                    ),
                  ),
                );
              }),
              25.verticalSpace,
              InkWell(
                onTap: (){
                  logic.resendVerifyCode();
                },
                child: Align(child: Text('أعد إرسال الرمز',style: H3BlackTextStyle,),alignment: Alignment.centerRight,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
