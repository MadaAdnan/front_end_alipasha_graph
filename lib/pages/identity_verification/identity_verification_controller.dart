import 'dart:convert';
import 'dart:io';
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

class IdentityVerificationController extends GetxController {
  MainController mainController = Get.find<MainController>();
  Rxn<XFile> backImage = Rxn<XFile>();
  Rxn<XFile> frontImage = Rxn<XFile>();
  RxBool isUploading = RxBool(false);
  RxBool loading = RxBool(false);
  RxBool isVerified = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getIdentity();
  }

  Future<void> pickFrontImage() async {
    await _showImageSourceSelectionDialog(
      onCameraSelected: () =>
          _pickImageFromSource(ImageSource.camera, imageType: 'front'),
      onGallerySelected: () =>
          _pickImageFromSource(ImageSource.gallery, imageType: 'front'),
    );
  }

  Future<void> pickBackImage() async {
    await _showImageSourceSelectionDialog(
      onCameraSelected: () =>
          _pickImageFromSource(ImageSource.camera, imageType: 'back'),
      onGallerySelected: () =>
          _pickImageFromSource(ImageSource.gallery, imageType: 'back'),
    );
  }

  Future<void> _showImageSourceSelectionDialog({
    required VoidCallback onCameraSelected,
    required VoidCallback onGallerySelected,
  }) async {
    await Get.defaultDialog(
      title: "اختر مصدر الصورة",
      content: Column(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("الكاميرا"),
            onTap: () {
              Get.back();
              onCameraSelected();
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text("المعرض"),
            onTap: () {
              Get.back();
              onGallerySelected();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromSource(ImageSource source,
      {required String imageType}) async {
    if (imageType == 'front') {
      mainController.pickImage(
          imagSource: source,
          aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 2.5),
          onChange: (XFile? file, int? size) {
            frontImage.value = file;
          });
    } else {
      mainController.pickImage(
          imagSource: source,
          aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 2.5),
          onChange: (XFile? file, int? size) {
            backImage.value = file;
          });
    }
  }

  getIdentity() async {
    loading.value = true;
    mainController.query.value = '''
    query{
      identities{
        ${AUTH_USER}
        identity{
          id
          status
        }
      }
    }
    ''';
    try {
      dio.Response? response = await mainController.fetchData();
      if(response?.data?['data']?['identities']?['user']!=null){
        mainController.setUserJson(json: response?.data?['data']?['identities']?['user']);
      }

        isVerified.value=response?.data?['data']?['identities']?['identity']!=null;


    } catch (e) {
      mainController.showToast(type: "error", text: "حدث خطأ: ${e.toString()}");
    }finally {
      loading.value = false;
    }
  }

  Future<void> uploadIdentityImages() async {
    if (frontImage.value == null || backImage.value == null) {
      mainController.showToast(type: "error", text:"الرجاء اختيار صورتي الهوية الأمامية والخلفية");
      return;
    }
    Map<String, dynamic> datajson = {
      "query": r" mutation VerifyIdentity($input:VerifyIdentityInput!) { "
          r"verifyIdentity(input:$input)"
          "{${AUTH_USER},identity{id,status} }"
          r"}",
      "variables": <String, dynamic>{
        "input": {
          "imageBack": null,
          "imageFront": null,
        },
      }
    };

    String map = '''
    {
  "imageFront": ["variables.input.imageFront"],
  "imageBack": ["variables.input.imageBack"]
}
    ''';

    Map<String, XFile?> data = {
      if (frontImage.value != null) 'imageFront': frontImage.value,
      if (backImage.value != null) 'imageBack': backImage.value,
    };

    try {
      isUploading.value = true;

      // Create dio form data to upload images
      dio.Response response = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);

      if (response.data?['data']?['verifyIdentity']?['identity'] != null) {
        await mainController.storage.write("verified", true);
        isVerified.value = true;
        mainController.showToast(
            type: "success",
            text: "تم رفع صور الهوية بنجاح، سيتم مراجعتها قريباً");
        frontImage.value = null;
        backImage.value = null;
      } else if (response.data?['errors'][0]['message'] != null) {
        mainController.showToast(
            type: "error", text: response.data?['errors'][0]['message']);
      } else {
        mainController.showToast(
            type: "error", text: "حدث خطأ أثناء رفع صور الهوية");
      }
      if(response.data?['data']?['verifyIdentity']?['user'] != null){
        mainController.setUserJson(json: response.data?['data']?['verifyIdentity']?['user']);
      }
    } catch (e, s) {
      mainController.showToast(type: "error", text: "حدث خطأ: ${s.toString()}");
    } finally {
      isUploading.value = false;
    }
  }

  String? getFrontImagePath() {
    return frontImage.value?.path;
  }

  String? getBackImagePath() {
    return backImage.value?.path;
  }
}
