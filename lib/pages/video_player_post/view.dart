import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/youtube_player/view.dart';
import 'logic.dart';

class VideoPlayerPostPage extends StatelessWidget {
  VideoPlayerPostPage({Key? key}) : super(key: key);

  final logic = Get.find<VideoPlayerPostLogic>();

  RxBool isFullScreen = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          return true;
        },
        child: Container(
          width: 1.sw,
          height: 1.sh,
          child: Container(
            child: YoutubeVideoPlayer(
              videoId: "${logic.idVideo.value}",
              onFullScreenChange: (value) {
                isFullScreen.value = value;
              },
              isLive: false,
            ),
          ),
        ),
      ),
    );
  }
}
