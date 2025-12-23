import 'package:get/get.dart';
import 'identity_verification_controller.dart';

class IdentityVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IdentityVerificationController>(IdentityVerificationController());
  }
}