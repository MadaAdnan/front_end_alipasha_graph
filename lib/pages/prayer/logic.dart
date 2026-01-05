import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/prayer_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';

class PrayerLogic extends GetxController {
  RxBool loading = RxBool(false);
  Rxn<PrayerModel> idlib = Rxn<PrayerModel>(null);
  Rxn<PrayerModel> izaz = Rxn<PrayerModel>(null);
  late dio.Dio connect;
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connect = dio.Dio(dio.BaseOptions(
      baseUrl: 'https://api.aladhan.com/v1/calendar',
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getPrayerTime();
  }
RxString nameCity=RxString('محافظة دمشق');
  getPrayerTime() async {
    loading.value = true;
    try {
      double? latitude = 33.5151444;
      double? longitude = 36.3931354;
      if (mainController.authUser.value?.city?.latitude != null) {
        latitude = mainController.authUser.value?.city?.latitude;
        longitude = mainController.authUser.value?.city?.longitude;
        nameCity.value = mainController.authUser.value!.city!.name!;
      }
      /*dio.Response idlibP = await connect.get(
          '/${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}?city=Idlib&country=Syria&method=3');*/
      dio.Response idlibP = await connect.get(
          '/${DateTime.now().year}/${DateTime.now().month}?latitude=$latitude&longitude=$longitude&method=3');
      // Logger().e(idlibP.data?['data']?[DateTime.now().day-1]);
      if (idlibP.data?['data']?[DateTime.now().day-1] != null) {
       dynamic data=idlibP.data?['data']?[DateTime.now().day-1];
        idlib.value = PrayerModel.fromJson(data);
      }

    } catch (e,s) {
      mainController.logger.e("Get PrayerTime in idlib $s");
    }

 /*   try {
      dio.Response izazP = await connect.get(
          '/${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}?city=Izaz&country=Syria&method=3');
      if (izazP.data?['data'] != null) {
        izaz.value = PrayerModel.fromJson(izazP.data?['data']);
      }
    } catch (e) {
      mainController.logger.e("Get PrayerTime in Izaz $e");
    }*/

    loading.value = false;
  }
}
