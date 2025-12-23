import 'dart:io';
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'identity_verification_model.dart';
import '../../helpers/dio_network_manager.dart';
import 'package:dio/dio.dart' as dio;
class IdentityVerificationController extends GetxController {
  final IdentityVerificationModel _model = IdentityVerificationModel();
 MainController mainController=Get.find<MainController>();

  IdentityVerificationModel get model => _model;

  Future<void> pickFrontImage() async {
    final pickedFile = await _pickImageFromSource(ImageSource.gallery);
    if (pickedFile != null) {
      _model.frontImage = File(pickedFile.path);
      update();
    }
  }

  Future<void> pickBackImage() async {
    final pickedFile = await _pickImageFromSource(ImageSource.gallery);
    if (pickedFile != null) {
      _model.backImage = File(pickedFile.path);
      update();
    }
  }

  Future<XFile?> _pickImageFromSource(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    return pickedFile;
  }

  Future<void> uploadIdentityImages() async {
    if (_model.frontImage == null || _model.backImage == null) {
      Get.snackbar("خطأ", "الرجاء اختيار صورتي الهوية الأمامية والخلفية");
      return;
    }

    try {
      _model.isUploading = true;
      update();

      // Upload images to server
      dio.Response? response = await mainController.fetchData();

      if (response != null ) {
        _model.isVerified = true;
        Get.snackbar("نجاح", "تم رفع صور الهوية بنجاح، سيتم مراجعتها قريباً");
      } else {
        Get.snackbar("خطأ", "حدث خطأ أثناء رفع صور الهوية");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ: ${e.toString()}");
    } finally {
      _model.isUploading = false;
      update();
    }
  }

  String? getFrontImagePath() {
    return _model.frontImage?.path;
  }

  String? getBackImagePath() {
    return _model.backImage?.path;
  }

  RxBool hasFrontImage = RxBool(false);
  Rxn<XFile> hasBackImage =Rxn<XFile>(null);
 RxBool isUploading = RxBool(false);
RxBool isVerified =RxBool(false);
}