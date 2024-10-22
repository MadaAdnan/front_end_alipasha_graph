import 'dart:convert';

import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Global/main_controller.dart';
import '../../helpers/components.dart';
import '../../models/category_model.dart';
import 'package:dio/dio.dart' as dio;

class CreateServiceLogic extends GetxController {
  final formState = GlobalKey<FormBuilderState>();
  final MainController mainController = Get.find<MainController>();
  RxnString errorEndDate = RxnString(null);
  GetStorage box = GetStorage('ali-pasha');
  RxBool loading = RxBool(false);
  RxList<CityModel> cities = RxList<CityModel>([]);

  // global
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);

  // formData
  RxString typePost = RxString('service');

  TextEditingController nameProduct = TextEditingController();
  TextEditingController infoProduct = TextEditingController();

  //product
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  Rxn<CategoryModel> category = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> subCategory = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> sub2Category = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> sub3Category = Rxn<CategoryModel>(null);
  RxList<XFile> images = RxList<XFile>([]);
  Rxn<CityModel> citySelected = Rxn<CityModel>(null);
  Rx<Map<int, List<int?>>> options = Rx<Map<int, List<int?>>>({});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(options, (value) {
     // mainController.logger.e(value);
    });
    ever(category, (value) {
      subCategory.value = null;
    });
    ever(subCategory, (value) {
      sub2Category.value = null;
    });
    ever(sub2Category, (value) {
      sub3Category.value = null;
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getDataForCreate();
  }

  fillDataFromDraft() {
    var data = box.read<Map<String, dynamic>>('draft');
  }

  Future<void> getDataForCreate() async {
    loading.value=true;
    mainController.query.value = r'''
query MainCategories {
    mainCategories (type: "service"){
        id
        name
        type
        has_color
        children {
            id
            name
            children {
                id
                name
                children {
                    id
                    name
                }
            }
        }
    }
    cities{
    name
    id
    } 
    
}

''';
    dio.Response? res = await mainController.fetchData();
    loading.value=false;
    if (res?.data != null && res?.data['data']?['mainCategories'] != null) {
      for (var item in res?.data['data']['mainCategories']) {
        categories.add(CategoryModel.fromJson(item));
      }
    }

    if (res?.data != null && res?.data['data']?['cities'] != null) {
      for (var item in res?.data['data']['cities']) {
        cities.add(CityModel.fromJson(item));
      }
    }
    if(res?.data?['errors']?[0]?['message']!=null){
      mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
    }
    loading.value=false;
  }

  saveData() async {

    loading.value = true;
    Map<String, dynamic> datajson = {
      "query":
          r"""mutation CreateService($input: CreateServiceInput!) { createService(input: $input) { id } }""",
      "variables": <String, dynamic>{
        "input": {

          "attach": null,
          "city_id":citySelected.value?.id,
          "info": "${infoProduct.text}",

          "email": "${emailController.text}",
          "phone": "${phoneController.text}",
          'url': "${urlController.text}",
          'address': "${addressController.text}",
          "category_id": category.value?.id,
          "sub1_id": subCategory.value?.id,

        }
      }
    };

    Map<String, XFile?> data = {};
    String map = '{';

    for (int i = 0; i < images.length; i++) {
      data['attach$i'] = images[i];
      map += '"attach$i": ["variables.input.attach.$i"]';
      if (i < images.length - 1) {
        map += ',';
      }
    }

    map += '}';
    try {
      mainController.logger.e( formState.currentState?.value);
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);
      mainController.logger.e(res.data);
      if (res.data?['data']?['createService'] != null) {
        infoProduct.clear();
        emailController.clear();
        phoneController.clear();
        urlController.clear();
        /* category.value = null;
        subCategory.value = null;
        sub2Category.value = null;
        sub3Category.value = null;
        options.value.clear();*/
        images.clear();
        formState.currentState?.patchValue({
          'url':'',
          'info':''
        });
        formState.currentState?.reset();
        showAutoCloseDialog(
            message: "تم إرسال الوظيفة للمراجعة بنجاح", isSuccess: true);
      } else if (res.data?['errors']?[0]?['extensions']['validation'] != null) {
        // جلب الكائن validation
        Map<String, dynamic> validation =
            res.data['errors'][0]['extensions']['validation'];

        // جلب أول قيمة من الكائن بغض النظر عن ال key
        String firstErrorMessage = validation.values.first.first;
        mainController.showToast(text:'فشل العملية',type: 'error' );

      }
      if(res.data['errors'][0]['message']!=null){
        mainController.showToast(text:'${res.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e("Error get Profile $e");
    }
    loading.value = false;
  }

  Future<void> saveToDraft() async {
    var data = {
      'type': typePost.value,
      'info': infoProduct.text,
      'price': 90,
      'mainImage': 90
    };
    await box.write('draft', data);
  }
}
