import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import '../../models/product_model.dart';
import '../../models/slider_model.dart';
class MyAdviceLogic extends GetxController {
RxBool loading=RxBool(false);
MainController mainController=Get.find<MainController>();

RxList<SliderModel> sliders=RxList<SliderModel>();
RxList<ProductModel> myProducts=RxList<ProductModel>();
RxInt adviceCount=RxInt(0);
RxInt views=RxInt(0);
RxDouble myBalance=RxDouble(0);
RxInt sliderCount=RxInt(0);
RxDouble myPoint=RxDouble(0);
RxDouble myWins=RxDouble(0);
RxList<AdviceModel> myAdvices=RxList<AdviceModel>();



@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyAdvice();
  }

getMyAdvice() async {
  mainController.query('''
  query MyAdvice {
    myAdvice {
        views
        slider_count
        advices {
            image
            id
            url
            expired_date
            views_count
            name
        }
      
    }
      mySliders {
            id
            url
            image
            expired_date
            views_count
        }
        
        mySpecialProducts {
          id
          name
          expert
        level
        image
        views_count
        }
    
}
    ''');
  dio.Response? res = await mainController.fetchData();
Logger().e(res?.data);
  if (res != null) {
    if (res.data['data']['myAdvice']['advices'] != null) {
      for (var item in res.data['data']['myAdvice']['advices']) {
        myAdvices.add(AdviceModel.fromJson(item));
      }
    }

    if (res.data['data']['mySliders'] != null) {
      for (var item in res.data['data']['mySliders']) {
        sliders.add(SliderModel.fromJson(item));
      }
    }
    if (res.data['data']['mySpecialProducts'] != null) {
      for (var item in res.data['data']['mySpecialProducts']) {
        myProducts.add(ProductModel.fromJson(item));
      }
    }

    views.value =
        int.tryParse("${res.data['data']['myAdvice']['views']}") ?? 0;
    sliderCount.value =
        int.tryParse("${res.data['data']['myAdvice']['slider_count']}") ?? 0;
    adviceCount.value =
        int.tryParse("${res.data['data']['myAdvice']['advice_count']}") ?? 0;
    myBalance.value =
        double.tryParse("${res.data['data']['myAdvice']['my_balance']}") ?? 0;
    myPoint.value =
        double.tryParse("${res.data['data']['myAdvice']['my_point']}") ?? 0;
    myWins.value =
        double.tryParse("${res.data['data']['myAdvice']['my_wins']}") ?? 0;
  }
}

deletAdvice({required int adviceId}) async {
  mainController.query.value = '''
    mutation DeleteAdvice {
    deleteAdvice(id: "$adviceId") {
        id
    }
}
     ''';
  try {
    dio.Response? res = await mainController.fetchData();
    if (res?.data?['data']?['deleteAdvice'] != null) {
      int index = myAdvices.indexWhere((el) =>
      el.id ==
          int.tryParse("${res?.data?['data']?['deleteAdvice']['id']}"));
      if (index > -1) {
        myAdvices.removeAt(index);
      }
    }
  } catch (e) {}
}

}
