import 'dart:convert';
import 'dart:io';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  Rxn<UserModel> user = Rxn<UserModel>(null);
  RxList<CityModel> cities = RxList<CityModel>([]);
  RxBool loading = RxBool(false);
  RxnInt cityId = RxnInt(null);
  Rx<TextEditingController> nameController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> emailController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> phoneController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> addressController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> sellerNameController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> openTimeController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> closeTimeController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> infoController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> passwordController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> confirmPasswordController =
      Rx<TextEditingController>(TextEditingController());

  Rxn<XFile> avatar = Rxn<XFile>(null);
  Rxn<XFile> logo = Rxn<XFile>(null);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUser();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(user, (value) {
      if (value != null) {
        nameController.value = TextEditingController(text: user.value!.name);
        emailController.value = TextEditingController(text: user.value!.email);
        phoneController.value = TextEditingController(text: user.value!.phone);
        addressController.value =
            TextEditingController(text: user.value!.address);
        sellerNameController.value =
            TextEditingController(text: user.value!.seller_name);
        openTimeController.value =
            TextEditingController(text: user.value!.open_time);
        closeTimeController.value =
            TextEditingController(text: user.value!.close_time);
        infoController.value = TextEditingController(text: user.value!.info);
        passwordController.value = TextEditingController();
        confirmPasswordController.value = TextEditingController();
      }
    });
  }

  clearData() {}

  getUser() async {
    loading.value = true;
    mainController.query.value = '''
  query Me {
    me {
   $AUTH_FIELDS
    }
    cities{
    name
    id
    }
}
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.d(res?.data);
      if (res?.data?['data']?['me'] != null) {
        mainController.logger.d(res?.data?['data']?['me']);
        user.value = UserModel.fromJson(res?.data?['data']?['me']);
        cityId.value = user.value?.city?.id;
        mainController.setUserJson(json: res?.data?['data']?['me']);
      }

      if (res?.data?['data']?['cities'] != null) {
        for (var item in res?.data?['data']?['cities']) {
          cities.add(CityModel.fromJson(item));
        }
      }
    } catch (e) {
      mainController.logger.e("Error get Profile $e");
    }
    loading.value = false;
  }

  saveData() async {
    loading.value = true;
    Map<String, dynamic> datajson = {
      "query":
          r" mutation UpdateUser($input:UpdateUserInput!) { "
              r"updateUser(input:$input) "
              "{$AUTH_FIELDS }"
              r"}",
      "variables": <String, dynamic>{
        "input":{
          "name": nameController.value.text ?? '',
          "email": emailController.value.text ?? '',
          "password": passwordController.value.text ?? '',
          "phone": phoneController.value.text ?? '',
          "city_id": cityId.value,
          "seller_name": sellerNameController.value.text ?? '',
          "address": addressController.value.text ?? '',
          "close_time": closeTimeController.value.text ?? '',
          "open_time": openTimeController.value.text ?? '',
          "info": infoController.value.text ?? '',
          "image": null,
          "logo": null,
          "is_delivery": true,
        },

      }
    };


    String map = '''
    {
  "image": ["variables.input.image"],
  "logo": ["variables.input.logo"]
}
    ''';

    Map<String, XFile?> data = {
      if (avatar.value != null) 'image': avatar.value,
      if (logo.value != null) 'logo': logo.value,
    };
    mainController.logger.e(avatar.value?.path);
    try {
      dio.Response res = await mainController.dio_manager
          .executeGraphQLQueryWithFile(json.encode(datajson),
              map: map, files: data);
      if (res.data['data']['updateUser'] != null) {
        mainController.setUserJson(json: res.data['data']['updateUser']);

        messageBox(
            title: 'نجاح العملية',
            message: 'تم تعديل الملف الشخصي بنجاح',
            isError: false);
        // mainController.authUser.value=UserModel.fromJson(res.data['data']['updateUser']);
      }
      //mainController.logger.e(res.data);
      if(res.data['errors'][0]['message']!=null){
       // mainController.logger.i(res.data['errors'][0]['message']);
      }
    } catch (e) {
      mainController.logger.e("Error get Profile $e");
    }
    loading.value = false;
  }

  Future<void> pickAvatar(
      {required ImageSource imagSource,
      required Function(XFile? file, int? fileSize) onChange}) async {
    XFile? selected = await ImagePicker().pickImage(source: imagSource);
    if (selected != null) {
      XFile? response = await cropAvatar(selected);
      if (response != null) {
        File compressedFile = File(response.path);
        int fileSize = await compressedFile.length();
        onChange(response, fileSize);
      }
    }
  }

  Future<XFile?> cropAvatar(XFile file) async {
    try {
      CroppedFile? cropped = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.png,
        sourcePath: file.path,
        maxWidth: 300,
        maxHeight: 300,
        compressQuality: 80,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'قص الصورة',
            cropStyle: CropStyle.rectangle,
            activeControlsWidgetColor: Colors.red,
            backgroundColor: Colors.grey.withOpacity(0.4),
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );
      if (cropped != null) {
        return await mainController.commpressImage(file: XFile(cropped.path));
      }
      return null;
    } catch (e) {
      return file;
    }
  }
}
