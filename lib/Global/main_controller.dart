import 'dart:io';

import 'package:ali_pasha_graph/helpers/cart_helper.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:ali_pasha_graph/models/cart_model.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/setting_model.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:laravel_flutter_pusher_plus/laravel_flutter_pusher_plus.dart';
import 'package:logger/logger.dart';

import '../exceptions/custom_exception.dart';
import '../helpers/colors.dart';
import '../helpers/dio_network_manager.dart';
import '../helpers/pusher_service.dart';
import '../models/city_model.dart';

class MainController extends GetxController {
  RxList<CartModel> carts = RxList<CartModel>([]);
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
  RxList<SliderModel> sliders = RxList<SliderModel>([]);

  Rx<SettingModel> settings =
      Rx(SettingModel(weather_api: '02b438a76f5345c3857124556240809'));
  RxBool is_show_home_appbar = RxBool(true);
  Logger logger = Logger();
  // late LaravelFlutterPusher pusher;

  @override
  void onInit() {
    super.onInit();
    CartHelper.getCart().then((value) {
      carts(value);
    });
    try {
      // pusher = PusherService.init(token: "$token");
    } catch (e) {}

    getAdvices();

    ever(token, (value) {
      logger.e(token.value);
      try {
        // pusher = PusherService.init(token: "$token");
      } catch (e) {}
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

   /* pusher.connect(
      onConnectionStateChange: (p0) =>
          logger.e("STATE NOW: " + p0.currentState),
    );*/
  }

  Future<dio.Response?> fetchData() async {
    loading.value = true;
    DateTime startDate = DateTime.now();
    try {
      dio.Response res = await dio_manager.executeGraphQLQuery(query.value!,
          variables: variables.value);
      // logger.e(res.data);
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

  getUser() {
    if (storage.hasData('user')) {
      var json = storage.read('user');
      authUser.value = UserModel.fromJson(json);
    }
  }

  setUserJson({required Map<String, dynamic> json}) async {
    try {
      if (storage.hasData('user')) {
        await storage.remove('user');
      }
      await storage.write('user', json);

      authUser.value = UserModel.fromJson(json);
    } catch (e) {
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

  createCommunity({required int sellerId,String? message}) async {
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
        Get.toNamed(CHAT_PAGE, arguments: community,parameters: {"msg":"$message"});
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

  Future<XFile?> commpressImage(
      {required XFile? file, int? width, int? height}) async {
    if (file != null) {
      print("COMPRESSOR");
      // Compress and convert to WebP
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
          file.path, file.path + '.webp',
          format: CompressFormat.webp,
          quality: 80,
          minHeight: height ?? 300,
          minWidth: width ?? 300,
          rotate: 0,
          numberOfRetries: 10);

      if (compressedFile != null) {
        return XFile(compressedFile.path);
      }
      return null;
    }
  }

  Future<void> pickImage(
      {required ImageSource imagSource,
      required Function(XFile? file, int? fileSize) onChange}) async {
    XFile? selected = await ImagePicker().pickImage(source: imagSource);
    if (selected != null) {
      XFile? response = await cropImage(selected);
      if (response != null) {
        File compressedFile = File(response.path);
        int fileSize = await compressedFile.length();
        onChange(response, fileSize);
      }
    }
  }

  Future<XFile?> cropImage(XFile file) async {
    try {
      CroppedFile? cropped = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.png,
        sourcePath: file.path,
        maxWidth: 300,
        maxHeight: 300,
        compressQuality: 80,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),

        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'قص الصورة',
            cropStyle: CropStyle.rectangle,
            activeControlsWidgetColor: RedColor,
            backgroundColor: Colors.grey.withOpacity(0.4),
            toolbarColor: RedColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,

          ),
          IOSUiSettings(

            minimumAspectRatio: 1.0,
          ),
        ],
      );
      if (cropped != null) {
        return await commpressImage(file: XFile(cropped.path));
      }
      return null;
    } catch (e) {
      return file;
    }
  }

  Future<void> addToCart({required ProductModel product}) async {
    List<CartModel> cartsItem = await CartHelper.addToCart(product: product);
    carts(cartsItem);

  }
  Future<void> removeBySeller({ int? sellerId}) async {
    List<CartModel> cartsItem = await CartHelper.removeBySeller(sellerId: sellerId);
    carts(cartsItem);

  }

  Future<void> minFromCart({required ProductModel product}) async {
    List<CartModel> cartsItem = await CartHelper.minFromCart(product: product);
    carts(cartsItem);
  }

  Future<void> deleteFromCart({required ProductModel product}) async {
    List<CartModel> cartsItem = await CartHelper.removeCart(product: product);
    carts(cartsItem);
  }

  Future<void> emptyCart() async {
    List<CartModel> cartsItem = await CartHelper.emptyCart();
    carts(cartsItem);
  }
  Future<void> increaseQty({required int productId}) async {
    List<CartModel> cartsItem = await CartHelper.increaseQty(productId: productId);
    carts(cartsItem);

  }
  Future<void> decreaseQty({required int productId}) async {
    List<CartModel> cartsItem = await CartHelper.decreaseQty(productId: productId);
    carts(cartsItem);

  }
}
