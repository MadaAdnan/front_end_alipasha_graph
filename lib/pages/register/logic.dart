
import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/google_auth.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:select2dot1/select2dot1.dart';
import 'package:dio/dio.dart' as dio;
import 'package:crypto/crypto.dart' ;
class RegisterLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  RxBool loading = RxBool(false);
  TextEditingController nameController = TextEditingController();


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // TextEditingController addressController=TextEditingController();
  TextEditingController affiliateController = TextEditingController();
  RxnInt citySelected = RxnInt(null);

  String? deviceToken;

  SelectDataController? citiesController = SelectDataController(data: []);
  RxnString errorName = RxnString(null);
  RxnString errorEmail = RxnString(null);
  RxnString errorPassword = RxnString(null);
  RxnString errorPhone = RxnString(null);
  RxnString errorCity = RxnString(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    List<SingleItemCategoryModel> listCities = [];
    for (var city in mainController.cities) {
      listCities.add(SingleItemCategoryModel(
          nameSingleItem: "${city.name}", value: city.id));
    }
    citiesController = SelectDataController(data: [
      SingleCategoryModel(singleItemCategoryList: listCities),
    ], isMultiSelect: false);
  }


  Future registerGoogel() async {
   Map<String,String>? user=await GoogleAuth.signin();
   if(user==null){
     return ;
   }

   String input="ali-pasha5${DateTime.now().day}";
   var bytes = utf8.encode(input);
  var hash=md5.convert(bytes);

   loading.value = true;
   mainController.query.value = '''
mutation CreateGoogleUser {
    createGoogleUser(
        input: {
            name: "${user['name']}"
            email: "${user['email']}"
            password: "${user['password']}"
            device_token: "${deviceToken}"
            affiliate:"${affiliateController.text}"
            hash:"$hash"
        }
    ) {
        token
        user {
           $AUTH_FIELDS
        }
    }
}

''';

    try {
      dio.Response? res = await mainController.fetchData();

      // mainController.logger.e(res?.data);
      if (res?.data?['data']?['createGoogleUser']?['token'] != null) {
        await mainController.setToken(
            token: res?.data?['data']?['createGoogleUser']?['token'], isWrite: true);

        await mainController.setUserJson(json: res?.data?['data']?['createGoogleUser']?['user']);
        Get.offAndToNamed(HOME_PAGE);
      }
      if (res?.data?['errors']?[0]?['extensions']['validation'] != null) {

      }
    } on CustomException catch (e) {
      print(e);
    }
    loading.value = false;
  }



  Future<void> register() async {
    loading.value = true;
    mainController.query.value = '''
mutation CreateUser {
    createUser(
        input: {
            name: "${nameController.text}"
            email: "${emailController.text}"
            password: "${passwordController.text}"
            phone: "${phoneController.text}"
            city_id: ${int.tryParse("$citySelected") ?? null}
            device_token: "${deviceToken}"
            affiliate: "${affiliateController.text}"
            
        }
    ) {
        token
        user {
           $AUTH_FIELDS
        }
    }
}

''';

    try {
      dio.Response? res = await mainController.fetchData();

     // mainController.logger.e(res?.data);
      if (res?.data?['data']?['createUser']?['token'] != null) {
        await mainController.setToken(
            token: res?.data?['data']?['createUser']?['token'], isWrite: true);

        await mainController.setUserJson(json: res?.data?['data']?['createUser']?['user']);
        Get.offAndToNamed(VERIFY_EMAIL_PAGE);
      }
      if (res?.data?['errors']?[0]?['extensions']['validation'] != null) {
        (res?.data?['errors'][0]['extensions']['validation']
                as Map<String, dynamic>)
            .forEach((key, value) {
          if (key.contains('email')) {
            errorEmail.value = value[0];
          }
          if (key.contains('name')) {
            errorName.value = value[0];
          }

          if (key.contains('password')) {
            errorPassword.value = value[0];
          }
          if (key.contains('phone')) {
            errorPhone.value = value[0];
          }
          if (key.contains('city')) {
            errorCity.value = value[0];
          }
        });
      }
    } on CustomException catch (e) {
      print(e);
    }
    loading.value = false;
  }

  clearError() {
    errorEmail.value = null;
    errorName.value = null;
    errorPassword.value = null;
    errorPhone.value = null;
    errorCity.value = null;
  }
}
/*
*  name
            seller_name
            email
            level
            phone
            address
            logo
            image
            open_time
            close_time
            is_delivery
            is_restaurant
            affiliate
            info
            city {
                name
            }
            total_balance
            total_point
* */