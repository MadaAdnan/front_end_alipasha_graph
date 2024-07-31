import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
  if (mainController.authUser.value?.logo != null &&
      mainController.authUser.value?.logo !=
          mainController.authUser.value?.image) {
    return mainController.authUser.value?.logo;
  }
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
