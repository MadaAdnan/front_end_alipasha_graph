import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String videoId;
  final bool isLive;

  final Function(bool) onFullScreenChange;

  YoutubeVideoPlayer({required this.videoId,this.isLive=false,required this.onFullScreenChange});

  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  RxBool isMute=false.obs;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        isLive: widget.isLive,
        showLiveFullscreenButton: widget.isLive,
        captionLanguage: 'ar',
        controlsVisibleAtStart: true,
        enableCaption: false,
        hideThumbnail: true,
        useHybridComposition: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: YoutubePlayer(
          bottomActions: [
            IconButton(onPressed: (){
              _controller.toggleFullScreenMode();
              widget.onFullScreenChange(_controller.value.isFullScreen);
            }, icon:Icon(FontAwesomeIcons.expand,color: WhiteColor,)),
            Obx(() {
              if(isMute.value){
                return  IconButton(onPressed: (){

                  _controller.unMute();
                  isMute.value=false;

                }, icon: Icon(FontAwesomeIcons.volumeMute,color: WhiteColor,));
              }
              return  IconButton(onPressed: (){

                _controller.mute();
                isMute.value=true;

              }, icon: Icon(FontAwesomeIcons.volumeHigh,color: WhiteColor,));
            })

          ],
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          onReady: () {
            print('Player is ready.');
          },
          
        ),
        onWillPop: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          return Future.value(true);
        });
  }
}
