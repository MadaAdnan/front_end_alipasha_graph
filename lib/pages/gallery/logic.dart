import 'dart:convert';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

class GalleryLogic extends GetxController {
  RxInt sellerId = RxInt(Get.arguments ?? Get.parameters['id']);
  RxBool loading = RxBool(false);

  RxList<DataImageModel> images = RxList<DataImageModel>([]);
  Rxn<UserModel> seller = Rxn<UserModel>(null);
  MainController mainController = Get.find<MainController>();
  RxnInt deleteId = RxnInt(null);
  RxBool loadingDelete = RxBool(false);
  Rxn<XFile> imageGallaery = Rxn<XFile>(null);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(imageGallaery, (value)=>uploadFileToGallery());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getGallery();
  }

  getGallery() async {
    loading.value = true;
    mainController.query.value = '''


query User {
    user(id: "${sellerId.value}") {
    id
        name
        seller_name
        image
        city {
            name
        }
        is_verified
        gallery {
            id
            url
        }
    }
}
 ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['user'] != null) {
        seller.value = UserModel.fromJson(res?.data?['data']?['user']);
        images(seller.value!.gallery);
      }
    } catch (e) {}

    loading.value = false;
  }

  deleteMedia(int id) async {
    loadingDelete.value = true;
    deleteId.value=id;
    if (deleteId.value != null) {
      mainController.query.value = '''
    mutation DeleteMedia {
    deleteMedia(id: "${deleteId.value}") {
        id
    }
}
    ''';
      try {
        dio.Response? res = await mainController.fetchData();
        mainController.logger.e(res?.data);
        if(res?.data['data']?['deleteMedia']!=null){
          int? id=int.tryParse("${res?.data['data']?['deleteMedia']?['id']}");
          int index=images.indexWhere((el)=>el.id==id);
          if(index>-1){
            images.removeAt(index);
            mainController.showToast(text: 'تم حذف الصورة من المعرض');
          }
        }
      } catch (ex) {}
    }
    loadingDelete.value = true;
    deleteId.value = null;
  }

  uploadFileToGallery() async {
    if (imageGallaery.value == null) {
      return;
    }
    loading.value = true;

    Map<String, dynamic> datajson = {
      "query":
      r"""mutation AddToGallery( $image: Upload!) {
         addToGallery( image: $image){
          id
          url    
          }
      }""",
      "variables": <String, dynamic>{
        "image": null
      }
    };
    String map = '''
    {
  "image": ["variables.image"]
}
    ''';

    Map<String, XFile?> data = {'image': imageGallaery.value};

    try {
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
          map: map, files: data);
      mainController.logger.e(res.data);
      if(res.data?['data']?['addToGallery']!=null){
        images.add(DataImageModel.fromJson(res.data?['data']?['addToGallery']));
        mainController.showToast(text:'تم إضافة الصورة بنجاح' );
        Get.back();


      }else{
        mainController.showToast(text:'${res.data['errors'][0]['message']}',type: 'error' );
      }
    } catch (e) {
      mainController.logger.e('Error Upload $e');
    }
    loading.value = false;
  }
}
