import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'colors.dart';

ImageProvider getUserImage() {
  return AssetImage('assets/images/png/user.png');
}

String? getName() {
  MainController mainController = Get.find<MainController>();

  if (mainController.authUser.value != null &&
      mainController.authUser.value?.seller_name != '') {
    return mainController.authUser.value?.seller_name;
  } else if (mainController.authUser.value != null &&
      mainController.authUser.value?.name != '') {
    return mainController.authUser.value?.name;
  }
  return 'انت تستخدم التطبيق كزائر';
}

String? getLogo() {
  MainController mainController = Get.find<MainController>();
 /* if (mainController.authUser.value?.logo != null &&
      mainController.authUser.value?.logo !=
          mainController.authUser.value?.image) {
    return mainController.authUser.value?.logo;
  }*/
  return mainController.authUser.value?.image;
}

bool isAuth() {
  MainController mainController = Get.find<MainController>();
  if (mainController.storage.hasData('token')) {
    mainController.token.value = mainController.storage.read('token');
  }
  return mainController.token.value != null &&
      mainController.token.value!.length > 10;
}

Future<void> openUrl({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw CustomException(message: 'Could not launch $url');
  }
}

messageBox({String? title, String? message, bool isError = false}) {
  Get.snackbar('$title', "$message",
      backgroundColor:
          isError ? RedColor.withOpacity(0.7) : Colors.green.withOpacity(0.7),
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        '$title',
        style: H4WhiteTextStyle,
      ),
      messageText: Text(
        "$message",
        style: H3WhiteTextStyle,
      ),
      icon: Icon(
        isError ? FontAwesomeIcons.ban : FontAwesomeIcons.checkCircle,
        color: WhiteColor,
      ));
}

void showAutoCloseDialog(
    {String title = "نجاح العملية",
    required String message,
    bool isSuccess = true}) {
  Get.dialog(
    AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text(
          '$title',
          style: H3OrangeTextStyle,
        ),
      ),
      content:Container(
        width: 0.7.sw,
        height: 0.2.sh,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           isSuccess? Icon(
              FontAwesomeIcons.circleCheck,
              size: 0.3.sw,
              color: Colors.green,
            ): Icon(
             FontAwesomeIcons.circleXmark,
             size: 0.3.sw,
             color: Colors.red,
           ),
            30.verticalSpace,
            Text('$message',style: H3GrayTextStyle,),
          ],
        ),
      ),
      /* actions: [
        TextButton(
          onPressed: () {
            Get.back(); // إغلاق النافذة يدويًا
          },
          child: Text('إغلاق'),
        ),
      ],*/
    ),
  );

  // إغلاق النافذة تلقائيًا بعد 3 ثواني
  Future.delayed(Duration(seconds: 3), () {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  });

  VerifiedMsg(){}
}
