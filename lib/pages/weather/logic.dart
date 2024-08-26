import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/weather_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

// http://api.weatherapi.com/v1/marine.json?key=&q=London&days=1

class WeatherLogic extends GetxController {
  RxBool loading = RxBool(false);
  RxList<WeatherModel> idlibWeather = RxList<WeatherModel>([]);
  RxList<WeatherModel> izazWeather = RxList<WeatherModel>([]);
  late dio.Dio connect;
MainController mainController=Get.find<MainController>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connect = dio.Dio(dio.BaseOptions(
      baseUrl: 'http://api.weatherapi.com/v1/marine.json',
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
    if(idlibWeather.length==0 || izazWeather.length==0){

      getWeather();
    }

  }

  getWeather() async {
    loading.value = true;
    String setting_weather = "${mainController.settings.value.weather_api}";
    try {
      dio.Response resIdlib =
          await connect.get('?key=$setting_weather&q=Idlib&days=3');

      if (resIdlib.data['forecast']['forecastday'] != null) {

        for(var item in resIdlib.data['forecast']['forecastday']){
          idlibWeather.add(WeatherModel.fromJson(item));
        }

      }
    } catch (e) {
      print("Error Get Weather Idlib $e");
    }

    try {

      dio.Response resIzaz =
      await connect.get('?key=$setting_weather&q=Aazaz&days=3');

      if (resIzaz.data['forecast']['forecastday'] != null) {
        for(var item in resIzaz.data['forecast']['forecastday']){
          izazWeather.add(WeatherModel.fromJson(item));
        }

      }
    } catch (e) {
      print("Error Get Weather Aazaz $e");
    }
    loading.value = false;
  }
}
