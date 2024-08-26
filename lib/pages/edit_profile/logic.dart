import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

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
        infoController.value =
            TextEditingController(text: user.value!.info);
      }
    });
  }

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

  saveData()async{
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
}
