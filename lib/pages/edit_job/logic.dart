import 'dart:convert';

import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

import '../../Global/main_controller.dart';
import '../../helpers/components.dart';
import '../../models/category_model.dart';
class EditJobLogic extends GetxController {
  final formState = GlobalKey<FormBuilderState>();
  final MainController mainController = Get.find<MainController>();
  RxnString errorEndDate = RxnString(null);
  GetStorage box = GetStorage('ali-pasha');
  RxBool loading = RxBool(false);
int jobId=Get.arguments;
Rxn<ProductModel> job=Rxn<ProductModel>(null);
  // global
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<DataImageModel> attachments = RxList<DataImageModel>([]);



  TextEditingController nameProduct = TextEditingController();
  TextEditingController infoProduct = TextEditingController();
  RxnString typeProduct = RxnString(null);

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
    loading.value=true;
    mainController.query.value = '''
query MainCategories {
    mainCategories (type: "job"){
        id
        name
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
     product(id: "$jobId") {
        product {
            id
            info
            type
            start_date
            end_date
            listOfDocs {
                id
                url
            }
            code
            url
            email
            phone
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
            attributes{
                attribute_id
            }
        }
    }
    
}

''';
    try{
      dio.Response? res = await mainController.fetchData();

      if (res?.data != null && res?.data['data']?['mainCategories'] != null) {
        for (var item in res?.data['data']['mainCategories']) {
          categories.add(CategoryModel.fromJson(item));
        }
      }

      if (res?.data != null && res?.data['data']?['product']?['product'] != null) {
        job.value=ProductModel.fromJson(res?.data['data']?['product']?['product']);
      //  mainController.logger.w("${job.value?.type}");
        attachments(job.value?.listOfDocs);
        infoProduct.value=TextEditingValue(text: "${job.value?.info}");
        typeProduct.value= "${job.value?.type}";
        DateTime? start = DateTime.tryParse("${job.value?.start_date}");
        DateTime? end = DateTime.tryParse("${job.value?.end_date}");
        startDateController.value =
            TextEditingValue(text: "${start?.year}/${start?.month}/${start?.day}");
        endDateController.value =
            TextEditingValue(text: "${end?.year}/${end?.month}/${end?.day}");
        emailController.value =
            TextEditingValue(text: "${job.value?.email}");
        phoneController.value =
            TextEditingValue(text: "${job.value?.phone}");
        urlController.value = TextEditingValue(text: "${job.value?.url}");
        codeController.value = TextEditingValue(text: "${job.value?.code}");
        category.value =
            categories.where((el) => el.id == job.value?.category?.id).first;
        subCategory.value = category.value!.children!
            .where((el) => el.id == job.value?.sub1?.id)
            .first;
        sub2Category.value = subCategory.value!.children!
            .where((el) => el.id == job.value?.sub2?.id)
            .first;
        sub3Category.value = sub2Category.value!.children!
            .where((el) => el.id == job.value?.sub3?.id)
            .first;
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    }catch(e){
      mainController.logger.e("Error Get Job $jobId - Error: $e");
    }

    loading.value=false;
  }

  saveData() async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query":
      r"""mutation UpdateJob($id:ID!,$input: CreateJobInput!) { updateJob(id:$id,input: $input) { id } }""",
      "variables": <String, dynamic>{
        'id':"${jobId}",
        "input": {
          "type":"${typeProduct.value}",
          "attach": null,
          "info": "${infoProduct.text}",
          "is_available": isAvailable.value,
          "email": "${emailController.text}",
          "phone": "${phoneController.text}",
          "code": "${typeProduct.value != 'job' ? '' : codeController.text}",
          'url':"${typeProduct.value != 'job' ? '' :urlController.text}",
          "category_id": category.value?.id,
          "sub1_id": subCategory.value?.id,
          "sub2_id": sub2Category.value?.id,
          "sub3_id": sub3Category.value?.id,
          "start_date":
          "${typeProduct.value != 'job' ? '' : startDateController.text}",
          "end_date":
          "${typeProduct.value != 'job' ? '' : endDateController.text}",
          "options":
          options.value.values.map((el) => el).expand((i) => i).toList(),
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
    //  mainController.logger.e(res.data);
      if (res.data?['data']?['updateJob'] != null) {
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
      if(res.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
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
      //mainController.logger.i("Delete :");
    //  mainController.logger.i(res?.data);
      if (res?.data?['data']?['deleteMedia'] != null) {
        int index = attachments.indexWhere((el) => el.id == id);
        if (index > -1) {
          attachments.removeAt(index);
        }

        mainController.showToast(text:'تم حذف المرفق بنجاح', );

      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data?['errors']?[0]?['message']}',type: 'error' );
      }
    } catch (e) {}
    loading.value=false;
  }
}
