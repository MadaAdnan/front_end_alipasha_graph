
import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

//Exchange // https://northsoftit.com/ER

class NetworkManager {
  static String IPWEB = "192.168.11.200";
  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() => _instance;

  late dioo.Dio dio;
  final GetStorage _storage = GetStorage('ali-pasha');

  NetworkManager._internal() {
    dio = dioo.Dio(dioo.BaseOptions(
      // baseUrl: "https://alipasha.mazaya-online.com/graphql/api",
      baseUrl: "http://192.168.11.200:8000/graphql/api",
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // إضافة Interceptor للتوكن
    dio.interceptors.add(dioo.InterceptorsWrapper(
      onRequest: (options, handler) {
        String? token = _storage.read('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));

    // إضافة DioCacheInterceptor
    dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
        // يمكن تخزين البيانات مؤقتًا في الذاكرة
        policy: CachePolicy.forceCache,
        // سيتم استخدام التخزين المؤقت دائمًا دون عمليات تحقق
        hitCacheOnErrorExcept: [
          401,
          403
        ], // سيتم استخدام التخزين المؤقت في حالة الأخطاء إلا في حالات محددة
      ),
    ));
  }

  Future<dioo.Response> executeGraphQLQuery(String query,
      {Map<String, dynamic>? variables}) async {
    try {
      final response = await dio.post(
        '',
        data: {
          'query': query,
          'variables': variables ?? {},
        },
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dioo.Response> executeHttp({required String endPoint, data}) async {
    try {
      final response = await dio.post(
        'api/$endPoint',
        data: data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dioo.Response> executeGraphQLQueryWithFile(
    String query, {
    String? map,
    Map<String, XFile?>? files,
  }) async {
    Map<String, XFile>? fileData = {};
    for (var entry in files!.entries) {
      if (entry.value != null) {
        fileData[entry.key] = entry.value!;
      }
    }


    Map<String,dynamic> dt={};

    dt["operations"]= query;
    dt["map"]= json.encode(json.decode(map!));
    for (var entry in fileData.entries) {
     dt[entry.key] = await dioo.MultipartFile.fromFile(entry.value.path,filename: 'test.png');
    }
Get.find<MainController>().logger.e(dt['map']);
    try {



      final formData = dioo.FormData.fromMap(dt);
      Get.find<MainController>().logger.e(dt);
      final response = await dio.post(
        '',
        data: formData,
        options: dioo.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          },
        ),
      );

      return response;
    } catch (e) {
      throw e;
    }
  }
}
