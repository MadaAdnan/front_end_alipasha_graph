import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'identity_verification_controller.dart';

class IdentityVerificationPage extends StatelessWidget {
  final controller = Get.put(IdentityVerificationController());
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('توثيق الحساب'),
        backgroundColor: PrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.loading.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.loading.value == false &&
            controller.isVerified.value == true &&
            mainController.authUser.value?.is_verified == true) {
          return SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            Center(
              child: Icon(
                Icons.verified,
                color: Colors.blue,
                size: 0.5.sw,
              ),
            ),
                SizedBox(
                  height: 0.02.sh,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    'تم توثيق حسابك والتاكد من الهوية بنجاح',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status message
                Obx(() {
                  if (controller.isVerified.value) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Text(
                        'تم رفع صور الهوية بنجاح، وسيتم مراجعتها من قبل فريق الدعم قريباً.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
                SizedBox(height: 20),
                Text(
                  'يرجى تحميل صور الهوية التالية للتحقق من حسابك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),

                // Front ID Image Selection
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'الوجه الأمامي للهوية',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() => _buildImageCard(
                            imagePath: controller.getFrontImagePath(),
                            hasImage: controller.frontImage.value != null,
                            onTap: () => controller.pickFrontImage(),
                            label: 'اختر صورة الوجه الأمامي',
                          )),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Back ID Image Selection
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'الوجه الخلفي للهوية',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() => _buildImageCard(
                            imagePath: controller.getBackImagePath(),
                            hasImage: controller.backImage.value != null,
                            onTap: () => controller.pickBackImage(),
                            label: 'اختر صورة الوجه الخلفي',
                          )),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // Upload Button
                Obx(() => ElevatedButton(
                      onPressed: controller.isUploading.value ||
                              controller.isVerified.value
                          ? null
                          : () => controller.uploadIdentityImages(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: controller.isUploading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : controller.isVerified.value
                              ? Text('تم التحقق من الهوية')
                              : Text('إرسال للتحقق'),
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildImageCard({
    required String? imagePath,
    required bool hasImage,
    required VoidCallback onTap,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
