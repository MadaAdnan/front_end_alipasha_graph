import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/setting_model.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../models/weather_model.dart';

class ServicesLogic extends GetxController {
  RxList<SliderModel> sliders = RxList<SliderModel>([]);
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);

  RxnString search = RxnString('');
  Rxn<ExchangeGold> gold = Rxn<ExchangeGold>();
  Rxn<ExchangeCur> dollar = Rxn<ExchangeCur>();
  RxList<WeatherModel> idlibWeather = RxList<WeatherModel>([]);

  late dio.Dio connect;

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
    getDataByStorage();
  }



  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getCategories();
  }

  getCategories() async {
    loading.value = true;
    mainController.query.value = '''
   query MainCategories {
    mainCategories(type: "service") {
        children {
            id
            name
          products2_count
        }
    }
    
    settings {
        gold {
            idlib {
                gold21 {
                   
                    bay
                }
                sliver{
                bay
                }
            }
        }
        dollar {
            idlib {
                usd {
                    sale
                    bay
                }
            }
        }
    }
    
     sliders(type: "service") {
        id
        url
        image
        expired_date
        views_count
        user {
            name
            seller_name
            id
        }
        category {
            type
        }
    } 
}
   
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
//mainController.logger.d(res?.data);
      if (res?.data?['data']?['mainCategories'] != null) {
        categories.clear();
        for (var item in res?.data?['data']?['mainCategories']) {
          if (item['children'] != null) {
            for (var i in item['children']) {
              categories.add(CategoryModel.fromJson(i));
            }
          }
        }
        await mainController.storage.write('services',res?.data?['data']?['mainCategories']);
      }

      if (res?.data?['data']?['sliders'] != null) {
        for (var item in res?.data?['data']?['sliders']) {
          sliders.add(SliderModel.fromJson(item));
        }
      }

      if (res?.data?['data']?['settings']?['gold'] != null) {
        gold.value =
            ExchangeGold.fromJson(res?.data?['data']?['settings']?['gold']);
      }

      if (res?.data?['data']?['settings']?['dollar'] != null) {
        dollar.value =
            ExchangeCur.fromJson(res?.data?['data']?['settings']?['dollar']);
      }
    } catch (e) {
      mainController.logger.e("Error get Service $e");
    }

    await getWeather();
    loading.value = false;
  }
  getDataByStorage()async{
    if(mainController.storage.hasData('services')){
      var data=mainController.storage.read('services');
      for (var item in data) {
        if (item['children'] != null) {
          for (var i in item['children']) {
            categories.add(CategoryModel.fromJson(i));
          }
        }
      }

    }
  }

  getWeather() async {
    List<Map<String, dynamic>> weatherStorage = [];
   try{
     if(mainController.storage.hasData('weather')){
       List<Map<String, dynamic>> data=mainController.storage.read('weather');
       for(var item in data){
         WeatherModel weatherModel = WeatherModel.fromStorage(item);
         DateTime? date=DateTime.tryParse("${weatherModel.date}");
         if(date!=null && (date.compareTo(DateTime.now())==0)){
           idlibWeather.clear();
           throw Exception('end Date');
         }
         idlibWeather.add(weatherModel);
       }
       if(idlibWeather.length>0){
         mainController.logger.w('IN OF STORAGE');
         return;
       }
     }
   }catch(e){
     mainController.logger.w(e);
   }

    loading.value = true;
    String setting_weather = "${mainController.settings.value.weather_api}";
    try {
      dio.Response resIdlib =
          await connect.get('?key=$setting_weather&q=Idlib&days=3');
      mainController.logger.e(resIdlib.data);
      if (resIdlib.data['forecast']['forecastday'] != null) {
        for (var item in resIdlib.data['forecast']['forecastday']) {
          WeatherModel weatherModel = WeatherModel.fromJson(item);
          idlibWeather.add(weatherModel);
          weatherStorage.add(weatherModel.toJson());
        }
     await   mainController.storage.write('weather', weatherStorage);
      }
    } catch (e) {
      print("Error Get Weather Idlib $e");
    }
    loading.value = false;
  }
}
