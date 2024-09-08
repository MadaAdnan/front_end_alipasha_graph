import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/prayer_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class PrayerLogic extends GetxController {
  // http://api.aladhan.com/v1/timings/17-07-2007?latitude=51.508515&longitude=-0.1254872&method=2
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
      baseUrl: 'https://api.aladhan.com/v1/timingsByCity',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
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

  getPrayerTime() async {
    loading.value = true;
    try {
      dio.Response idlibP = await connect.get(
          '/${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}}?city=Idlib&country=Syria&method=3');
      if (idlibP.data?['data'] != null) {
        idlib.value = PrayerModel.fromJson(idlibP.data?['data']);
      }

    } catch (e) {
      mainController.logger.e("Get PrayerTime in idlib $e");
    }

    try {
      dio.Response izazP = await connect.get(
          '/${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}}?city=Izaz&country=Syria&method=3');
      if (izazP.data?['data'] != null) {
        izaz.value = PrayerModel.fromJson(izazP.data?['data']);
      }
    } catch (e) {
      mainController.logger.e("Get PrayerTime in Izaz $e");
    }

    loading.value = false;
  }
}
