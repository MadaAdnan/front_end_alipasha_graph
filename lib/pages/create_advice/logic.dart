import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';

class CreateAdviceLogic extends GetxController {
  RxBool loading = RxBool(false);
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  Rxn<CategoryModel> category = Rxn(null);

  Rxn<XFile> image = Rxn(null);

  MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  saveAdvice() async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query": r"""mutation CreateAdvice($input:CreateAdviceInput!) {
       createAdvice(input: $input){
          id
          name
          image
          expired_date
       }
      }""",
      "variables": <String, dynamic>{
        "input": {
          'name': "${nameController.text ?? ''}",
          'url': "${urlController.text ?? ''}",
          'image': null,
          if (category.value != null) 'category_id': category.value?.id ?? '',
        },
      }
    };
    String map = '''
    {
  "image": ["variables.input.image"]
}
    ''';

    Map<String, XFile?> data = {if (image.value != null) 'image': image.value};
    Logger().e(data);
    try {
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);

      if (res.data?['data']?['createAdvice'] != null) {
        image.value = null;
        nameController.clear();
        urlController.clear();
        image.value = null;
        mainController.showToast(
            text: 'تم إرسال الإعلان إلى المراجعة قبل تفعيله', type: 'success');
      }
      if (res?.data?['errors']?[0]?['message'] != null) {
        mainController.showToast(
            text: '${res?.data['errors'][0]['message']}', type: 'error');
        mainController.logger.e("Error Send ${res?.data['errors']}");
      }

    } catch (e) {}
    loading.value = false;
  }
}
