import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/pricing_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:select2dot1/select2dot1.dart';

class ShippingLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  TextEditingController nameSenderController = TextEditingController();
  TextEditingController addressSenderController = TextEditingController();
  TextEditingController phoneSenderController = TextEditingController();
  TextEditingController addressReceiveController = TextEditingController();
  TextEditingController nameReceiveController = TextEditingController();
  TextEditingController phoneReceiveController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  SelectDataController fromController = SelectDataController(data: []);
  SelectDataController toController = SelectDataController(data: []);

  ///
  RxnDouble weight = RxnDouble(null);
  RxnDouble height = RxnDouble(null);
  RxnDouble width = RxnDouble(null);
  RxnDouble length = RxnDouble(null);
  RxnInt from = RxnInt(null);
  RxnInt to = RxnInt(null);

  RxnDouble totalPrice = RxnDouble(0);

  ///
  RxDouble totalBalance = RxDouble(0);
  RxList<PricingModel> pricing = RxList<PricingModel>([]);
  RxnString errorFrom = RxnString(null);
  RxnString errorTo = RxnString(null);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (pricing.length == 0) {
      getPricingData();
    }
    List<SingleItemCategoryModel> listCities = [];
    for (var city
        in mainController.cities.where((el) => el.isDelivery == true)) {
      listCities.add(SingleItemCategoryModel(
          nameSingleItem: city.name ?? '', value: city.id));
    }
    fromController = SelectDataController(data: [
      SingleCategoryModel(
          singleItemCategoryList: listCities, nameCategory: 'مدينة المرسل')
    ], isMultiSelect: false);
    toController = SelectDataController(data: [
      SingleCategoryModel(
          singleItemCategoryList: listCities, nameCategory: 'مدينة المرسل إليه')
    ], isMultiSelect: false);
  }

  /*calcPrice() {
    print("Calc");
    double size =
        (length.value ?? 0) * (width.value ?? 0) * (height.value ?? 0);
    PricingModel maxSize = pricing.firstWhere((el) => el.size! >= size);
    PricingModel maxWeight =
        pricing.firstWhere((el) => el.weight! >= weight.value!);
    totalPrice.value = (maxSize.internal_price! > maxWeight.internal_price!)
        ? maxSize.internal_price!
        : maxWeight.internal_price!;
  }*/

  void calcPrice() {
    // حساب الحجم بناءً على الطول والعرض والارتفاع المدخل
    double size = (length.value ?? 0) *
        (width.value ?? 0) *
        (height.value ?? 0) /
        1000000;
    // التأكد من وجود عناصر في قائمة التسعير
    if (pricing.isEmpty) {
      print("No pricing data available");
      return;
    }

    // جلب العنصر الذي يحتوي على أكبر حجم أكبر أو يساوي الحجم المدخل
    PricingModel? maxSize;
    try {
      maxSize = pricing.firstWhere((el) => el.size! >= size);
      maxSize = pricing.firstWhere(
        (el) => el.size! >= size,
        orElse: () => pricing
            .reduce((curr, next) => curr.size! > next.size! ? curr : next),
      );
    } catch (e) {
      print("No matching size found");
      return;
    }

    // جلب العنصر الذي يحتوي على أكبر وزن أكبر أو يساوي الوزن المدخل
    PricingModel? maxWeight;
    try {
      maxWeight = pricing.firstWhere(
        (el) => el.weight! >= weight.value!,
        orElse: () => pricing
            .reduce((curr, next) => curr.weight! > next.weight! ? curr : next),
      );
    } catch (e) {
      print("No matching weight found");
      return;
    }
    CityModel? fromCiity;
    CityModel? toCiity;
    // حساب السعر الإجمالي بناءً على الأسعار الداخلية
    if (from.value != null) {
      fromCiity = mainController.cities.firstWhere((el) => el.id == from.value);
    }
    if (to.value != null) {
      toCiity = mainController.cities.firstWhere((el) => el.id == to.value);
    }

    if (fromCiity?.cityId == toCiity?.cityId) {
      totalPrice.value = (maxSize.internal_price! > maxWeight.internal_price!)
          ? maxSize.internal_price!
          : maxWeight.internal_price!;
    } else {
      totalPrice.value = (maxSize.external_price! > maxWeight.external_price!)
          ? maxSize.external_price!
          : maxWeight.external_price!;
    }
  }

  getPricingData() async {
    pricing.clear();
    mainController.query('''
    query Pricing {
    pricing {
        weight
        size
        internal_price
        external_price
    }
     me {
        total_balance
    }
}
    ''');

    dio.Response? res = await mainController.fetchData();
    if (res?.data?['data']?['pricing'] != null) {
      for (var item in res?.data['data']['pricing']) {
        pricing.add(PricingModel.fromJson(item));
      }
      totalBalance.value = double.tryParse(
          "${res?.data?['data']?['me']['total_balance'] ?? 0}")!;
      calcPrice();
    }
  }

  sendOrder() async {
    mainController.query('''
    mutation CreateOrder {
    createOrder(
        input: {
            weight: ${weight.value}
            height: ${height.value}
            width: ${width.value}
            length: ${length.value}
            receive_name: "${nameReceiveController.text}"
            receive_phone: "${phoneReceiveController.text}"
            sender_name: "${nameSenderController.text}"
            sender_phone: "${phoneSenderController.text}"
            from_id: ${from.value}
            to_id: ${to.value}
            receive_address: "${addressReceiveController.text}"
        }
    ) {
        order {
            id
            price
        }
         user {
           $AUTH_FIELDS
        }
    }
}

     ''');
    try {
      dio.Response? res = await mainController.fetchData();
      //mainController.logger.i(res?.data);

      if (res?.data?['data']?['createOrder'] != null) {

        mainController.setUserJson(json:res?.data?['data']?['createOrder']['user'] );
        totalBalance.value = double.tryParse(
            "${res?.data?['data']?['createOrder']?['user']?['total_balance'] ?? 0}")!;
      }
    } catch (e) {
      //mainController.logger.i("Error =>");
      mainController.logger.i(e);
    }
  }
}
