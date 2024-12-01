import 'package:get/get.dart';

class VideoPlayerPostLogic extends GetxController {
 RxnString idVideo=RxnString(null);

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if("${Get.arguments}".contains('shorts')){
     idVideo.value="${Get.arguments}".split('/').last;
    }else{
     idVideo.value=extractYouTubeId("${Get.arguments}");
    }
  }
 String? extractYouTubeId(String url) {
  final RegExp regExp = RegExp(
      r'(?:\?v=|\/embed\/|\/v\/|youtu\.be\/|\/watch\?v=)([a-zA-Z0-9_-]{11})');
  final Match? match = regExp.firstMatch(url);
  return match != null ? match.group(1) : null;
 }
}
