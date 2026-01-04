import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/weather_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:logger/logger.dart';

class WeatherLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxList<WeatherModel> idlibWeather = RxList<WeatherModel>([]);
  RxList<WeatherModel> izazWeather = RxList<WeatherModel>([]);
  late dio.Dio connect;
  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connect = dio.Dio(dio.BaseOptions(
      baseUrl: 'http://api.weatherapi.com/v1/forecast.json',
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
    if (idlibWeather.length == 0 || izazWeather.length == 0) {
      getWeather();
    }
  }

  RxString nameCity = RxString('دمشق');

  getWeather() async {
    loading.value = true;
    String setting_weather = "${mainController.settings.value.weather_api}";
    double? latitude = 33.5151444;
    double? longitude = 36.3931354;
    if (mainController.authUser.value?.city?.latitude != null) {
      latitude = mainController.authUser.value?.city?.latitude;
      longitude = mainController.authUser.value?.city?.longitude;
      nameCity.value = mainController.authUser.value!.city!.name!;
    }
    try {
      dio.Response resIdlib = await connect
          .get('?key=$setting_weather&q=${latitude},${longitude}&days=3&aqi=no&alerts=no');

      if (resIdlib.data['forecast']['forecastday'] != null) {
        for (var item in resIdlib.data['forecast']['forecastday']) {
          idlibWeather.add(WeatherModel.fromJson(item));
        }
      }
    } catch (e) {
      print("Error Get Weather Idlib $e");
    }

   /* try {
      dio.Response resIzaz =
          await connect.get('?key=$setting_weather&q=Aazaz&days=3');

      if (resIzaz.data['forecast']['forecastday'] != null) {
        for (var item in resIzaz.data['forecast']['forecastday']) {
          izazWeather.add(WeatherModel.fromJson(item));
        }
      }
    } catch (e) {
      print("Error Get Weather Aazaz $e");
    }*/
    loading.value = false;
  }
}
