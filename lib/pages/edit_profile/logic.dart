import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  Rxn<UserModel> user = Rxn<UserModel>(null);
  RxBool loading = RxBool(false);
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
    is_seller
        id
        name
        seller_name
        email
        phone
        address
        image
        logo
        open_time
        close_time
        is_delivery
        affiliate
        info
    }
}
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['me'] != null) {
        user.value = UserModel.fromJson(res?.data?['data']?['me']);
      }
    } catch (e) {
      mainController.logger.e("Error get Profile $e");
    }
    loading.value = false;
  }

  saveData() async {
    loading.value = true;
    mainController.query.value = '''
    mutation UpdateUser {
    updateUser(
        input: {
            name: "${nameController.value.text}"
            email: "${emailController.value.text}"
            password: "${nameController.value.text}"
            phone: "${phoneController.value.text}"
            city_id: 4
            seller_name: "${sellerNameController.value.text}"
            address: "${addressController.value.text}"
            close_time: "${closeTimeController.value.text}"
            open_time: "${openTimeController.value.text}"
            info: "${infoController.value.text}"
            image: null
            logo: null
            is_delivery: true
        }
    ) {
        name
        id
        seller_name
        email
        phone
        address
        image
        logo
        open_time
        close_time
        is_delivery
        info
        plans {
            id
        }
        city {
            id
        }
        total_balance
        total_point
        followers {
            user {
                name
                id
            }
            seller {
                id
                seller_name
            }
        }
    }
}

    
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      if (res?.data?['data']?['me'] != null) {
        user.value = UserModel.fromJson(res?.data?['data']?['me']);
      }
    } catch (e) {
      mainController.logger.e("Error get Profile $e");
    }
    loading.value = false;
  }

  Future<void> pickAvatar({required ImageSource imagSource}) async {
    avatar.value = null;
    XFile? selected = await ImagePicker().pickImage(source: imagSource);
    if (selected != null) {
      avatar.value = selected;
      cropAvatar();
    }
  }

  Future<void> cropAvatar() async {
    try {
      CroppedFile? cropped = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.png,
        sourcePath: avatar.value!.path,
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
        avatar.value = XFile(cropped.path);
      }
    } catch (e) {
      // Handle the error appropriately
      print('Error cropping image: $e');
      Get.snackbar('Error', 'Failed to crop image');
    }
  }
}
