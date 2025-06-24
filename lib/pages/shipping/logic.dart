import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/pricing_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';
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
  TextEditingController noteController = TextEditingController();
  SelectDataController fromController = SelectDataController(data: []);
  SelectDataController toController = SelectDataController(data: []);

  ///
  RxnDouble weight = RxnDouble(null);
  RxnDouble height = RxnDouble(null);
  RxnDouble width = RxnDouble(null);
  RxnDouble length = RxnDouble(null);
  Rxn<CityModel> fromCity = Rxn<CityModel>(null);
  Rxn<CityModel> from = Rxn<CityModel>(null);
  Rxn<CityModel> to = Rxn<CityModel>(null);
  Rxn<CityModel> toCity = Rxn<CityModel>(null);
  RxnDouble totalPrice = RxnDouble(0);
  RxBool isDelivary = RxBool(true);

  ///
  RxDouble totalBalance = RxDouble(0);
  RxList<PricingModel> pricing = RxList<PricingModel>([]);
  RxnString errorFrom = RxnString(null);
  RxnString errorTo = RxnString(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(toCity, (value) {
      to.value = null;
    });
    ever(fromCity, (value) {
      from.value = null;
    });
    ever(to,(value){
      if(value!=null){
        isDelivary.value=value.isDelivery??false;
      }
    });
    ever(from,(value){
      if(value!=null){
        isDelivary.value=value.isDelivery??false;
      }
    });
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

  void calcPrice() {
    double size = double.tryParse((((length.value ?? 0) * 0.01) *
                ((width.value ?? 0) * 0.01) *
                ((height.value ?? 0) * 0.01))
            .toStringAsFixed(3)) ??
        0;

    if (pricing.isEmpty) {
      print("No pricing data available");
      return;
    }

    // جلب العنصر الذي يحتوي على أكبر حجم أكبر أو يساوي الحجم المدخل
    PricingModel? maxSize;

    try {
      pricing.sort((a, b) => a.size!.compareTo(b.size!));

      //maxSize = pricing.firstWhere((el) => el.size! >= size);
      maxSize = pricing.firstWhere((el) => el.size! >= size);
    } catch (e) {
      print("No matching size found");
      return;
    }

    // جلب العنصر الذي يحتوي على أكبر وزن أكبر أو يساوي الوزن المدخل
    PricingModel? maxWeight;
    try {
      pricing.sort((a, b) => a.weight!.compareTo(b.weight!));
      maxWeight = pricing.firstWhere((el) => el.weight! >= weight.value!);
    } catch (e) {
      print("No matching weight found");
      return;
    }

    // حساب السعر الإجمالي بناءً على الأسعار الداخلية

    totalPrice.value = (maxSize.internal_price! > maxWeight.internal_price!)
        ? maxSize.internal_price!
        : maxWeight.internal_price!;

    int steps = ((from.value?.level ?? 0) + (to.value?.level ?? 0)) - 1;
    double ratio = 0;
    if (steps > 0) {
      ratio = (totalPrice.value ?? 0) / 3;
    }

    totalPrice.value = totalPrice.value! + (steps * ratio);
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
    mutation CreateNewOrder(\$input:InputCreateOrder!) {
    createNewOrder(
        input: \$input
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
    mainController.variables.value = {
      'input': {
        "weight": weight.value,
        "height": height.value,
        "width": width.value,
        "length": length.value,
        "receive_name": nameReceiveController.text,
        "receive_phone": phoneReceiveController.text,
        "sender_name": nameSenderController.text,
        "sender_phone": phoneSenderController.text,
        "note": noteController.text,
        "from_id": from.value?.id,
        "to_id": to.value?.id,
        "receive_address": addressReceiveController.text,
      }
    };
    try {
      dio.Response? res = await mainController.fetchData();
      //mainController.logger.e(res?.data);

      if (res?.data?['data']?['createNewOrder'] != null) {
        mainController.setUserJson(
            json: res?.data?['data']?['createNewOrder']['user']);
        totalBalance.value = double.tryParse(
            "${res?.data?['data']?['createNewOrder']?['user']?['total_balance'] ?? 0}")!;
        mainController.showToast(text: 'تم إرسال الطلب للمراجعة');
        Get.offNamed(SHIPPING_PAGE);
      } else if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: "${res?.data?['errors']?[0]?['message']}", type: "error");
      }
    } catch (e) {
      //mainController.logger.i("Error =>");
      mainController.logger.i(e);
    }
  }
}
