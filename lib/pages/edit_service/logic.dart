import 'dart:convert';

import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:cherry_toast/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

import '../../Global/main_controller.dart';
import '../../helpers/components.dart';
import '../../models/category_model.dart';
import '../../models/city_model.dart';

class EditServiceLogic extends GetxController {
  final formState = GlobalKey<FormBuilderState>();
  final MainController mainController = Get.find<MainController>();
  RxnString errorEndDate = RxnString(null);
  GetStorage box = GetStorage('ali-pasha');
  RxBool loading = RxBool(false);
  RxList<CityModel> cities = RxList<CityModel>([]);
  int serviceId = Get.arguments;
  Rxn<ProductModel> service = Rxn<ProductModel>(null);

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
      mainController.logger.e(value);
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
    mainController.query.value = '''
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
    
     product(id: "$serviceId") {
        product {
            id
            city {
                id
              
            }
            category {
                id
                
            }
            sub1 {
                id
               
            }
            info
            phone
            email
            address
            url
        }
    }
    
}

''';
    dio.Response? res = await mainController.fetchData();
    loading.value = false;
    if (res?.data['data']?['mainCategories'] != null) {
      for (var item in res?.data['data']['mainCategories']) {
        categories.add(CategoryModel.fromJson(item));
      }
    }

    if (res?.data['data']?['cities'] != null) {
      for (var item in res?.data['data']['cities']) {
        cities.add(CityModel.fromJson(item));
      }
    }
    if (res?.data['data']?['product']?['product'] != null) {
      service.value =
          ProductModel.fromJson(res?.data['data']?['product']?['product']);
      infoProduct.value = TextEditingValue(text: '${service.value?.info}');
      addressController.value =
          TextEditingValue(text: '${service.value?.address}');
      emailController.value = TextEditingValue(text: '${service.value?.email}');
      phoneController.value = TextEditingValue(text: '${service.value?.phone}');
      urlController.value = TextEditingValue(text: '${service.value?.url}');
      citySelected.value =
          cities.where((el) => el.id == service.value?.city?.id).first;
      mainController.logger.e(citySelected.value?.toJson());
      category.value =
          categories.where((el) => el.id == service.value?.category?.id).first;
      subCategory.value = category.value?.children!
          .where((el) => el.id == service.value?.sub1?.id)
          .first;
    }

    loading.value = false;
  }

  saveData() async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query":
          r"""mutation UpdateService($id:ID!,$input: CreateServiceInput!) { updateService(id:$id,input: $input) { id } }""",
      "variables": <String, dynamic>{
        "id": "${service.value?.id}",
        "input": {
          "attach": null,
          "city_id": citySelected.value?.id,
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
      mainController.logger.e(formState.currentState?.value);
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);
      mainController.logger.e(res.data);
      if (res.data?['data']?['updateService'] != null) {

        showAutoCloseDialog(
            message: "تم إرسال الخدمة للمراجعة بنجاح", isSuccess: true);
      } else if (res.data?['errors']?[0]?['extensions']['validation'] != null) {
        // جلب الكائن validation
        Map<String, dynamic> validation =
            res.data['errors'][0]['extensions']['validation'];

        // جلب أول قيمة من الكائن بغض النظر عن ال key
        String firstErrorMessage = validation.values.first.first;

        showAutoCloseDialog(
            title: 'فشل العملية',
            message: "$firstErrorMessage",
            isSuccess: false);
      }
    } catch (e) {
      mainController.logger.e("Error get Profile $e");
    }
    loading.value = false;
  }
}
