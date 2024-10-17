



import 'dart:convert';
import 'dart:io';

import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Global/main_controller.dart';

import 'package:dio/dio.dart' as dio;

import '../../helpers/components.dart';
class CreateCommunityLogic extends GetxController {
String type=Get.arguments??'group';
MainController mainController = Get.find<MainController>();
TextEditingController nameController=TextEditingController();
Rxn<XFile> avatar=Rxn<XFile>(null);
String? message='';
RxBool loading=RxBool(false);
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(type=='group'){
      message="يمكنك إنشاء مجموعة تتواصل بها مع الزبائن والتجار من خلال المحادثة";
    }else{
      message="يمكنك إنشاء قناة تقوم من خلالها بنشر أخبار متجرك والجديد والعروض وغيرها لإعلام الزبائن بكل جديد";
    }
  }

saveData() async {
  loading.value = true;

  Map<String, dynamic> datajson = {};
  if (type == 'group') {
    datajson = {
      "query": r"""mutation CreateGroup($name:String!,$image:Upload!) { createGroup(name:$name,image:$image) {   id
      name
      type
      url
      users_count
      last_update
      created_at
      manager {
        id
        name
        seller_name
        image
        is_verified
      }
      users {
        id
        name
        seller_name
        is_verified
        image
      } }}""",
      "variables": <String, dynamic>{
        "name": nameController.value.text ?? '',
        "image": null,
      },
    };
  } else {
    type = 'channel';
    datajson = {
      "query": r"""mutation CreateChannel($name:String!,$image:Upload!) { createChannel(name:$name,image:$image) {   id
      name
      type
      url
      users_count
      last_update
      created_at
      manager {
        id
        name
        seller_name
        image
        is_verified
      }
      users {
        id
        name
        seller_name
        is_verified
        image
      } }}""",
      "variables": <String, dynamic>{
        "name": nameController.value.text ?? '',
        "image": null,
      },
    };
  }

  String map = '''
  {
    "image": ["variables.image"]
  }
''';


  Map<String, XFile?> data = {
    if (avatar.value != null) 'image': avatar.value,

  };
  print(datajson);

  try {
    dio.Response res = await mainController.dio_manager
        .executeGraphQLQueryWithFile(json.encode(datajson),
        map: map, files: data);
    mainController.logger.d(res.data);
    if (res.data['data']['createChannel'] != null) {
     CommunityModel community=CommunityModel.fromJson(res.data['data']['createChannel']);

      messageBox(
          title: 'نجاح العملية',
          message: 'تم إنشاء ${type == 'group' ? 'المجموعة' : 'القناة'}',
          isError: false);
      if(community.type=='channel'){
        Get.offAndToNamed(CHANNEL_PAGE,arguments: community);
      }
    }

    if (res.data['data']['createGroup'] != null) {
      CommunityModel community=CommunityModel.fromJson(res.data['data']['createGroup']);

      messageBox(
          title: 'نجاح العملية',
          message: 'تم إنشاء ${type == 'group' ? 'المجموعة' : 'القناة'}',
          isError: false);
      if(community.type=='group'){
        Get.offAndToNamed(GROUP_PAGE,arguments: community);
      }

      // mainController.authUser.value=UserModel.fromJson(res.data['data']['updateUser']);
    }
    if (res.data['errors'][0]['message'] != null) {
      messageBox(
          title: 'فشل العملية',
          message: 'تم إنشاء ${type == 'group' ? 'المجموعة' : 'القناة'}',
          isError: true);
    }
  } catch (e) {
    mainController.logger.e("Error Create Community ${e.toString()}");
  }
  loading.value = false;
}


Future<void> pickAvatar(
    {required ImageSource imagSource,
      required Function(XFile? file, int? fileSize) onChange,
      int? width,
      int? height}) async {
  XFile? selected = await ImagePicker().pickImage(source: imagSource);
  if (selected != null) {
    XFile? response =
    await cropAvatar(selected, width: width, height: height);
    if (response != null) {
      File compressedFile = File(response.path);
      int fileSize = await compressedFile.length();
      onChange(response, fileSize);
    }
  }
}

Future<XFile?> cropAvatar(XFile file, {int? width, int? height}) async {
  try {
    double ratioY=1;
    if(width!=null && height!=null && width>0){
      ratioY=height/width;
    }
    CroppedFile? cropped = await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.png,
      sourcePath: file.path,
      maxWidth: width ?? 300,
      maxHeight: height ?? 300,
      compressQuality: 80,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: ratioY),
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
      return await mainController.commpressImage(file: XFile(cropped.path,),width: 300,height: 300);
    }
    return null;
  } catch (e) {
    return file;
  }
}
}
