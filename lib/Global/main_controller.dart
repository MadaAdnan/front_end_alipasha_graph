import 'dart:io';

import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:dio/dio.dart' as dio;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:laravel_flutter_pusher_plus/laravel_flutter_pusher_plus.dart';
import 'package:logger/logger.dart';

import '../helpers/dio_network_manager.dart';
import '../helpers/pusher_service.dart';
import '../models/city_model.dart';

class MainController extends GetxController {
  //'1|XoDW3fzMyn4aDNe9WclH6wgYObtcuYmucJrfdAqO643da6f4'
  RxnString token = RxnString(null);
  Rxn<UserModel> authUser = Rxn<UserModel>(null);
  NetworkManager dio_manager = NetworkManager();
  GetStorage storage = GetStorage('ali-pasha');
  RxnString query = RxnString(null);
  Rxn<Map<String, dynamic>> variables = Rxn(null);
  RxBool loading = RxBool(false);
  RxList<Map<String, dynamic>> errors = RxList<Map<String, dynamic>>([]);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<CityModel> cities = RxList<CityModel>([]);
  RxList<ColorModel> colors = RxList<ColorModel>([]);
  RxList<AdviceModel> advices = RxList<AdviceModel>([]);
  RxBool is_show_home_appbar = RxBool(true);
  Logger logger = Logger();
  late LaravelFlutterPusher pusher;

  @override
  void onInit() {
    super.onInit();
    getAdvices();
    // pusher= PusherService.init(token:"$token");
    ever(token, (value) {
      logger.e(token.value);
      pusher = PusherService.init(token: "$token");
      if (value == null) {
        storage.remove('token');
        storage.remove('user');
      }
    });
    ever(authUser, (value) {
      //  logger.i(value?.toJson());
    });
  }

  @override
  void onReady() {
    getUserFromStorage();

    pusher.connect(
      onConnectionStateChange: (p0) =>
          logger.e("STATE NOW: " + p0.currentState),
    );
  }

  Future<dio.Response?> fetchData() async {
    loading.value = true;
    DateTime startDate = DateTime.now();
    try {
      dio.Response res = await dio_manager.executeGraphQLQuery(query.value!,
          variables: variables.value);
      // logger.e(res.data);
      /* if (res.data?['errors']!=null) {
        throw CustomException(
            errors: res.data?['errors'][0]['extensions'],
            message:res.data?['errors'][0]['message']);
      }*/
      loading.value = false;
      DateTime endDate = DateTime.now();
      Duration responseTime = endDate.difference(startDate);
      logger.i(
          "Duration Response : ${responseTime.inMilliseconds / 1000} Seconds");
      logger.i("Response Size: ${res.data.toString().length} Byte");
      return res;
    } on dio.DioException catch (e) {
      loading.value = false;
      throw CustomException(errors: {"errors": e}, message: e.message);
    } on HttpException catch (e) {
      loading.value = false;
      throw CustomException(errors: {"errors": e}, message: e.message);
    } catch (e) {
      loading.value = false;
      throw CustomException(errors: {"errors": e}, message: "خطأ بالسيرفر");
    }
  }

/*  setUser({required UserModel user, bool isWrite = false}) async {
    if (isWrite) {
      if (storage.hasData('user')) {
        await storage.remove('user');
      }
      await storage.write('user', user.toJson());
    }
    authUser.value = user;
  }*/
  getUser() {
    if (storage.hasData('user')) {
      var json = storage.read('user');
      authUser.value = UserModel.fromJson(json);
    }
  }

  setUserJson({required Map<String, dynamic> json}) async {
   try{
     if (storage.hasData('user')) {
       await storage.remove('user');
     }
     await storage.write('user', json);

     authUser.value = UserModel.fromJson(json);
   }catch(e){
     logger.e("Error Write Storage : $e");
   }

  }

  Future<void> setToken({String? token, bool isWrite = false}) async {
    if (isWrite) {
      if (storage.hasData('token')) {
        await storage.remove('token');
      }
      if (token != null) {
        await storage.write('token', token);
      }
    }
  }

  getUserFromStorage() {
    if (storage.hasData('user')) {
      var user = storage.read('user');
      authUser.value = UserModel.fromJson(user);
    }

    if (storage.hasData('token')) {
      String? tokenStored = storage.read('token');
      token.value = tokenStored;
    }
  }

  logout() async {
    if (storage.hasData('user')) {
      await storage.remove('user');
    }
    if (storage.hasData('token')) {
      await storage.remove('token');
    }
    token.value = null;
    authUser.value = null;
    Get.offAndToNamed(HOME_PAGE);
  }

  loginByGoogle() {}

  handelExceptopn(e) {
    if (e is Exception && e.toString().contains('Exception: {')) {
      var errorData = e.toString();

      // استخراج المعلومات من النص
      RegExp exp = RegExp(r'CustomException: \{(.*)\}');
      var matches = exp.firstMatch(errorData);
      var errorMap = matches != null ? matches.group(1) : null;

      // تحويل النص المستخرج إلى Map
      if (errorMap != null) {
        Map<String, dynamic> errorDetails = {};
        errorMap.split(', ').forEach((pair) {
          var keyVal = pair.split(': ');
          if (keyVal.length == 2) {
            var key = keyVal[0];
            var val = keyVal[1];
            errorDetails[key] = val;
          }
          logger.i(pair);
        });

        // استخدام المعلومات المستخرجة
        print("Error: ${errorDetails['message']}");
        print("Details: ${errorDetails['errors']}");
      }
    } else {
      // إذا كان الاستثناء ليس من النوع المتوقع، يمكن طباعة أو التعامل مع e مباشرةً
      print("Unexpected error: $e");
    }
  }

  createCommunity({required int sellerId}) async {
    if (authUser.value == null) return;
    query.value = '''
    mutation CreateCommunity {
    createCommunity(userId: ${authUser.value?.id}, sellerId: $sellerId) {
        id
        last_change
        not_seen_count
        created_at
        user {
            id
            name
            seller_name
            image
            logo
        }
        seller {
            id
            name
            seller_name
            image
            logo
        }
    }
}

     ''';
    try {
      dio.Response? res = await fetchData();
      logger.w(res?.data);
      if (res?.data?['data']['createCommunity'] != null) {
        CommunityModel community =
            CommunityModel.fromJson(res?.data?['data']['createCommunity']);
        Get.toNamed(CHAT_PAGE, arguments: community);
      }
    } catch (e) {
      logger.e("Error Create Community $e");
    }
  }

  getAdvices() async {
    query.value = '''
    query Advices {
    advices {
        name
        user {
            id
            name
            seller_name
        }
        url
        image
        id
    }
}
    ''';
    try {
      dio.Response? res = await fetchData();
      if (res?.data?['data']['advices'] != null) {
        for (var item in res?.data?['data']['advices']) {
          advices.add(AdviceModel.fromJson(item));
        }
      }
    } catch (e) {
      logger.e("Error GetAdvices $e");
    }
  }
}
