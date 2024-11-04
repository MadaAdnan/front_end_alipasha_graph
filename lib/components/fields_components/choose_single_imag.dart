

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChooseSingleImage extends StatelessWidget {
  ChooseSingleImage(
      {super.key,
      this.width,
      required this.onFileChanged,
      required this.viewImage});

  final double? width;
  Widget viewImage;
  final void Function(XFile?) onFileChanged;
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01.sh),
      width: width,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              _pickImage(imagSource: ImageSource.camera);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 0.003.sh,
                horizontal: 0.018.sw,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(0.016.sw),
              ),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.image,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10.w),
                  const Text(
                    'الصورة الرئيسية',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          viewImage,
        ],
      ),
    );
  }

  Future<void> _pickImage({required ImageSource imagSource}) async {
    file = null;
    XFile? selected = await ImagePicker().pickImage(source: imagSource);
    if (selected != null) {
      file = selected;
      await _cropImage();
    }
  }

  Future<void> _cropImage() async {
    try {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: file!.path,
        maxWidth: 300,
        maxHeight: 300,
        compressQuality: 80,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
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
        file = XFile(cropped.path);
        onFileChanged(file);
      }
    } catch (e) {
      // Handle the error appropriately

      Get.snackbar('Error', 'Failed to crop image');
    }
  }

}
