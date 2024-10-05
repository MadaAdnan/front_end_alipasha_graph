import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';



class YoutubePlayerComponent extends StatefulWidget {
  const YoutubePlayerComponent({super.key,required this.vedioUrl});
  final String vedioUrl;
  @override
  State<YoutubePlayerComponent> createState() => _YoutubePlayerComponentState();
}

class _YoutubePlayerComponentState extends State<YoutubePlayerComponent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
 return Container();
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
