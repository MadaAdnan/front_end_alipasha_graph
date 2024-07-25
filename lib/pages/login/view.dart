import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.find<LoginLogic>();
  RxBool secure = RxBool(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.2.sw, vertical: 0.1.sh),
              width: 1.sw,
              height: 0.4.sh,
              color: RedColor,
              child: Image(
                image: AssetImage(
                  'assets/images/png/logo-alipasha.png',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
            15.verticalSpace,
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.02.sh),
              child: Form(
                  child: Column(
                children: [
                  InputComponent(
                    suffixIcon: FontAwesomeIcons.user,
                    width: 1.sw,
                    isRequired: true,
                    validation: (value) {
                      if (value?.length == 0) {
                        return "يرجى إدخال اسم المستخدم أو البريد الإلكتروني";
                      } else {
                        return null;
                      }
                    },
                    hint: 'البريد الإلكتروني أو اسم المستخدم',
                  ),
                  15.verticalSpace,
                  Obx(() {
                    return InputComponent(
                      isSecure: secure.value,
                      suffixIcon: secure.value
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      suffixClick: () {
                        secure.value = !secure.value;
                      },
                      width: 1.sw,
                      isRequired: true,
                      validation: (value) {
                        if (value?.length == 0) {
                          return "يرجى إدخال اسم المستخدم أو البريد الإلكتروني";
                        } else {
                          return null;
                        }
                      },
                      hint: 'البريد الإلكتروني أو اسم المستخدم',
                    );
                  }),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
