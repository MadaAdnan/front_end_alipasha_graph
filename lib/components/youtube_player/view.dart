import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubePlayerComponent extends StatefulWidget {
  const YoutubePlayerComponent({super.key,required this.vedioUrl});
  final String vedioUrl;
  @override
  State<YoutubePlayerComponent> createState() => _YoutubePlayerComponentState();
}

class _YoutubePlayerComponentState extends State<YoutubePlayerComponent> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=YoutubePlayerController(
      initialVideoId:"${YoutubePlayer.convertUrlToId(widget.vedioUrl)}",
      flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
          useHybridComposition: true,
          controlsVisibleAtStart: true,
          disableDragSeek: false,
          hideControls: false,
          isLive: false,
          forceHD: false,
          hideThumbnail: false
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor:RedColor,
      aspectRatio: 1,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true,),
        FullScreenButton(controller: _controller,)
      ],
      onReady: () {
         _controller.play();
      },
    );
  }
}




/*class YoutubePlayerComponent extends StatelessWidget {
  YoutubePlayerComponent({Key? key,required this.vedioUrl}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor:RedColor,
      onReady: () {
        // _controller.play();
      },
    );
  }
}*/
