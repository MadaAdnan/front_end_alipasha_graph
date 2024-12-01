import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Global/main_controller.dart';
import 'package:dio/dio.dart' as dio;

import '../../models/category_model.dart';
import '../../models/product_model.dart';

class EditProductLogic extends GetxController {
  final MainController mainController = Get.find<MainController>();
  RxnString errorEndDate = RxnString(null);
  GetStorage box = GetStorage('ali-pasha');
  RxBool loading = RxBool(false);
  RxBool isDelivery = RxBool(false);
  int productId = Get.arguments;
  Rxn<ProductModel> product = Rxn<ProductModel>(null);
  RxList<DataImageModel> attachments = RxList([]);

  // global
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<ColorModel> colors = RxList<ColorModel>([]);

  // formData
  RxString typePost = RxString('product');
  RxnInt periodProduct = RxnInt(360);

  TextEditingController infoProduct = TextEditingController();
  TextEditingController nameController = TextEditingController();

  //product
  TextEditingController priceController = TextEditingController(text: '0');
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
    //var data = box.read<Map<String, dynamic>>('draft');
  }

  Future<void> getDataForCreate() async {
    loading.value = true;
    mainController.query.value = '''
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
     product(id: "$productId") {
        product {
            info
            name
            price
            discount
            is_available
            is_delivery
            video
            listOfImages {
                id
                url
            }
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
            colors {
                id
            }
            attributes {
                attribute_id
            }
        }
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

      if (res?.data != null &&
          res?.data?['data']?['product']?['product'] != null) {
        product.value =
            ProductModel.fromJson(res?.data?['data']?['product']?['product']);

        attachments(product.value?.listOfImages);
        infoProduct.value = TextEditingValue(text: "${product.value?.info}");
        priceController.value =
            TextEditingValue(text: "${product.value?.price}");
        discountController.value =
            TextEditingValue(text: "${product.value?.discount}");
        nameController.value = TextEditingValue(text: "${product.value?.name}");
        videoController.value =
            TextEditingValue(text: "${product.value?.video}");

        isAvailable.value =
            bool.tryParse("${product.value?.is_available}") ?? false;
        isDelivery.value =
            bool.tryParse("${product.value?.is_delivery}") ?? false;
        colorIds(
            product.value?.colors!.map((el) => int.parse("${el.id}")).toList());
        category.value = categories
            .where((el) => el.id == product.value?.category?.id)
            .first;
        subCategory.value = category.value?.children!
            .where((el) => el.id == product.value?.sub1?.id)
            .first;
        sub2Category.value = subCategory.value?.children!
            .where((el) => el.id == product.value?.sub2?.id)
            .first;
        sub3Category.value = sub2Category.value?.children!
            .where((el) => el.id == product.value?.sub3?.id)
            .first;

     //   mainController.logger.i(colorIds);
      }
      if(res?.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e('Error Get  Product $productId -Error : $e');
    }
    loading.value = false;
  }

  saveData() async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query":
          r"""mutation UpdateProduct($id:ID!,$input: UpdateProductInput!) { updateProduct(id:$id,input: $input) { id } }""",
      "variables": <String, dynamic>{
        'id': "$productId",
        "input": {
          'name': nameController.text ,
          "images": null,
          "info": infoProduct.text ,
          "is_available": isAvailable.value,
          "price": double.tryParse(priceController.text) ?? 0,
          "discount": double.tryParse(discountController.text),
          "category_id": category.value?.id,
          "sub1_id": subCategory.value?.id,
          "sub2_id": sub2Category.value?.id,
          "sub3_id": sub3Category.value?.id,
          "colors": colorIds.toList(),
          'video': videoController.text ,
        }
      }
    };

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

      if (res.data?['data']?['updateProduct'] != null) {
        mainController.showToast(text:'تم إرسال المنتج للمراجعة بنجاح');
      }
      if(res.data?['errors']?[0]?['message']!=null){
        mainController.showToast(text:'${res.data?['errors']?[0]?['message']}',type: 'error');
      }
    } catch (e) {
      mainController.logger.e("Error get Profile $e");
    }
    loading.value = false;
  }

  Future<void> deleteMedia(int id) async {
    loading.value = true;
    mainController.query.value = '''
    mutation DeleteMedia {
    deleteMedia(id: "$id") {
        id
    }
}

    ''';

    try {
      dio.Response? res = await mainController.fetchData();

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
    loading.value = false;
  }
}
