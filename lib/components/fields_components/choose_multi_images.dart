import 'dart:io';

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChooseMultiImages extends StatelessWidget {
  ChooseMultiImages({super.key, this.width, required this.onFileChanged});

  final double? width;
  RxList<XFile?> files = RxList<XFile?>([]);
  final void Function(List<XFile?>) onFileChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01.sh),
      width: width,
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

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
                      'مزيد من الصور',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                    files.length,
                        (index) => Stack(
                      children: [
                        Container(
                          width: width! *0.25,
                          height: width! *0.25,
                          margin: EdgeInsets.symmetric(vertical: 0.01.sh,horizontal: 0.002.sw),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            border: Border.all(color: GrayDarkColor),
                            borderRadius: BorderRadius.circular(0.02.sw),
                            image: files[index] != null
                                ? DecorationImage(
                              image: FileImage(File(files[index]!.path)),
                              fit: BoxFit.cover, // تحديد التكبير والتصغير
                            )
                                : const DecorationImage(
                              image: AssetImage(
                                  'assets/images/png/no-img.png'),
                            ),
                          ),
                        ),
                        if (files[index] != null)
                          IconButton(
                            onPressed: () {
                              _clear(index);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.trash,
                              size: 20,
                              color: RedColor,
                            ),
                          ),
                      ],
                    ))
              ],
            )

          ],
        );
      }),
    );
  }

  Future<void> _pickImage({required ImageSource imagSource}) async {
    if(files.length<3){
      XFile? selected = await ImagePicker().pickImage(source: imagSource);
      if (selected != null) {
        files.add(selected);
        for(var item in files){
          if(item==null){
            files.remove(item);
          }
        }
        await _cropImage(files.length - 1);
      }
    }else{
      Get.snackbar('Error', 'لا يمكنك رفع أكثر من 3 صور');
    }

  }

  Future<void> _cropImage(index) async {
    try {
      if (files[index] != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: files[index]!.path,
          maxWidth: 300,
          maxHeight: 300,
          compressQuality: 80,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'قص الصورة',
              cropStyle: CropStyle.rectangle,
              activeControlsWidgetColor: Colors.red,
              backgroundColor: Colors.grey.withOpacity(0.4),
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
          ],
        );
        if (cropped != null) {
          files[index] = XFile(cropped.path);
          for(var item in files){
            if(item==null){
              files.remove(item);
            }
          }
          onFileChanged(files.value.toList());
        }
      }
    } catch (e) {
      // Handle the error appropriately

      Get.snackbar('خطأ', 'لم يتمكن ممن قص الصورة');
    }
  }

  void _clear(index) {
   files.removeAt(index);
    onFileChanged(files.toList());
  }
}
