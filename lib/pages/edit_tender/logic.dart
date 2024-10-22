import 'dart:convert';

import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../Global/main_controller.dart';
import '../../helpers/components.dart';
import '../../models/category_model.dart';
import 'package:dio/dio.dart' as dio;

class EditTenderLogic extends GetxController {
  final formState = GlobalKey<FormBuilderState>();
  final MainController mainController = Get.find<MainController>();
  RxnString errorEndDate = RxnString(null);
  GetStorage box = GetStorage('ali-pasha');
  RxBool loading = RxBool(false);
  int tenderId = Get.arguments;
  Rxn<ProductModel> tender = Rxn<ProductModel>(null);
  RxList<DataImageModel> attachments = RxList<DataImageModel>([]);

  // global
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);

  // formData
  RxString typePost = RxString('tender');

  TextEditingController nameProduct = TextEditingController();
  TextEditingController infoProduct = TextEditingController();

  //product
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  RxBool isAvailable = RxBool(true);
  Rxn<CategoryModel> category = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> subCategory = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> sub2Category = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> sub3Category = Rxn<CategoryModel>(null);
  RxList<XFile> images = RxList<XFile>([]);

  Rx<Map<int, List<int?>>> options = Rx<Map<int, List<int?>>>({});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(options, (value) {
    //  mainController.logger.e(value);
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
    mainCategories (type: "tender"){
        id
        name
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
    
     product(id: "$tenderId}") {
        product {
            id
            category {
                id
            }
            sub1 {
                id
            }
            sub2 {
                id
            }
            sub3 {
                id
            }
            info
            start_date
            end_date
            listOfDocs {
                id
                url
            }
            email
            phone
            url
            code
        }
    }
    
}

''';
    try {
      dio.Response? res = await mainController.fetchData();
   //   mainController.logger.i(res?.data);
      if (res?.data != null && res?.data['data']?['mainCategories'] != null) {
        for (var item in res?.data['data']['mainCategories']) {
          categories.add(CategoryModel.fromJson(item));
        }
      }

      if (res?.data['data']?['product']?['product'] != null) {
        tender.value =
            ProductModel.fromJson(res?.data['data']?['product']?['product']);
        attachments(tender.value?.listOfDocs ?? []);
        infoProduct.value = TextEditingValue(text: "${tender.value?.info}");
        DateTime start = DateTime.parse("${tender.value?.start_date}");
        DateTime end = DateTime.parse("${tender.value?.end_date}");
        startDateController.value =
            TextEditingValue(text: "${start.year}/${start.month}/${start.day}");
        endDateController.value =
            TextEditingValue(text: "${end.year}/${end.month}/${end.day}");
        emailController.value =
            TextEditingValue(text: "${tender.value?.email}");
        phoneController.value =
            TextEditingValue(text: "${tender.value?.phone}");
        urlController.value = TextEditingValue(text: "${tender.value?.url}");
        codeController.value = TextEditingValue(text: "${tender.value?.code}");
        category.value =
            categories.where((el) => el.id == tender.value?.category?.id).first;
        subCategory.value = category.value!.children!
            .where((el) => el.id == tender.value?.sub1?.id)
            .first;
        sub2Category.value = subCategory.value!.children!
            .where((el) => el.id == tender.value?.sub2?.id)
            .first;
        sub3Category.value = sub2Category.value!.children!
            .where((el) => el.id == tender.value?.sub3?.id)
            .first;
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e("Error Get Tender: $tenderId - $e");
    }
    loading.value = false;
  }

  saveData() async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query":
          r"""mutation UpdateTender($id:ID!,$input: CreateTenderInput!) { updateTender(id:$id,input: $input) { id } }""",
      "variables": <String, dynamic>{
        'id':"$tenderId",
        "input": {
          //   "type": "${typePost.value}",
          "attach": null,
          "info": "${infoProduct.text}",
          // "is_available": isAvailable.value,
          "email": "${emailController.text}",
          "phone": "${phoneController.text}",
          "code": "${codeController.text}",
          "start_date": "${startDateController.text}",
          "end_date": "${endDateController.text}",
          'url': "${urlController.text}",
          "category_id": category.value?.id,
          "sub1_id": subCategory.value?.id,
          "sub2_id": sub2Category.value?.id,
          "sub3_id": sub3Category.value?.id,
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
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);
   //   mainController.logger.e(res.data);
      if (res.data?['data']?['updateTender'] != null) {
        showAutoCloseDialog(
            message: "تم إرسال الوظيفة للمراجعة بنجاح", isSuccess: true);
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



  Future<void> deleteMedia(int id) async {
    loading.value=true;
    mainController.query.value = '''
    mutation DeleteMedia {
    deleteMedia(id: "$id") {
        id
    }
}

    ''';

    try {
      dio.Response? res = await mainController.fetchData();
     // mainController.logger.i("Delete :");
     // mainController.logger.i(res?.data);
      if (res?.data?['data']?['deleteMedia'] != null) {
        int index = attachments.indexWhere((el) => el.id == id);
        if (index > -1) {
          attachments.removeAt(index);
        }

        mainController.showToast(text:'تم حذف المرفق بنجاح' );
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {}
    loading.value=false;
  }
}
