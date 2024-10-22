import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';

import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dio/dio.dart' as dio;

import '../../helpers/components.dart';

class CreateProductLogic extends GetxController {
  final MainController mainController = Get.find<MainController>();
  RxnString errorEndDate = RxnString(null);
  GetStorage box = GetStorage('ali-pasha');
  RxBool loading = RxBool(false);
  RxnString errorImage = RxnString(null);

  // global
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<ColorModel> colors = RxList<ColorModel>([]);

  // formData
  RxString typePost = RxString('product');
  RxnInt periodProduct = RxnInt(360);
  TextEditingController nameProduct = TextEditingController();
  TextEditingController infoProduct = TextEditingController();

  //product
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  RxBool isAvailable = RxBool(true);
  Rxn<CategoryModel> category = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> subCategory = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> sub2Category = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> sub3Category = Rxn<CategoryModel>(null);
  RxList<XFile> images = RxList<XFile>([]);
  RxList<int> colorIds = RxList<int>([]);
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
    loading.value = true;
    mainController.query.value = r'''
query MainCategories {
    mainCategories (type: "product"){
        id
        name
        type
        has_color
        children {
            id
            name
            attributes {
                id
                name
                type
                attributes {
                    id
                    name
                }
            }
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
     colors {
        id
        code
    }
    
}

''';
    try {
      dio.Response? res = await mainController.fetchData();

      if (res?.data != null && res?.data['data']?['mainCategories'] != null) {
        for (var item in res?.data['data']['mainCategories']) {
          if (item['type'] == 'product') {
            categories.add(CategoryModel.fromJson(item));
          }
        }
      }

      if (res?.data != null && res?.data['data']['colors'] != null) {
        for (var item in res?.data['data']['colors']) {
          colors.add(ColorModel.fromJson(item));
        }
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e('Error Get Data CreateProduct : $e');
    }

    loading.value = false;
  }

  saveData() async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query":
          r"""mutation CreateProduct($input: CreateProductInput!) { createProduct(input: $input) { id } }""",
      "variables": <String, dynamic>{
        "input": {
          "name": "${nameController.text}",
          "images": null,
          "info": "${infoProduct.text}",
          "is_available": isAvailable.value,
          "price": double.tryParse(priceController.text) ?? 0,
          "discount": double.tryParse(discountController.text),
          "category_id": category.value?.id,
          "sub1_id": subCategory.value?.id,
          "sub2_id": sub2Category.value?.id,
          "sub3_id": sub3Category.value?.id,
          "period": periodProduct.value,
          "colors": colorIds.toList(),
          'video': "${videoController.text}",
          "options":
              options.value.values.map((el) => el).expand((i) => i).toList(),
        }
      }
    };
    //mainController.logger.i(datajson['variables']);

    Map<String, XFile?> data = {};
    String map = '{';

    for (int i = 0; i < images.length; i++) {
      data['image$i'] = images[i];
      map += '"image$i": ["variables.input.images.$i"]';
      if (i < images.length - 1) {
        map += ',';
      }
    }

    map += '}';
    try {
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);
     // mainController.logger.e(res.data);
      if (res.data?['data']?['createProduct'] != null) {
        infoProduct.clear();
        priceController.clear();
        discountController.clear();
        nameController.clear();
        videoController.clear();
        category.value = null;
        subCategory.value = null;
        sub2Category.value = null;
        sub3Category.value = null;
        options.value.clear();
        images.clear();
        colorIds.clear();
        showAutoCloseDialog(
            message: "تم إرسال المنتج للمراجعة بنجاح", isSuccess: true);
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
      'selectedEndDate': periodProduct.value,
      'mainImage': 90
    };
    await box.write('draft', data);
  }
}
