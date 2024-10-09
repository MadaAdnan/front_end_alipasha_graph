import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/components/youtube_player/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'logic.dart';

class LivePage extends StatelessWidget {
  LivePage({Key? key}) : super(key: key);

  final logic = Get.find<LiveLogic>();

  RxBool isFullScreen = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (logic.scrollController.position.atEdge &&
              scrollInfo.metrics.pixels == 0 &&
              !mainController.loading.value &&
              logic.hasMorePage.value) {
            logic.nextPage();
          }

          return true;
        },
        child: Container(
          width: 1.sw,
          height: 1.sh,
          child: Obx(() {
            if (isFullScreen.value) {
              return Container(
                child: YoutubeVideoPlayer(
                  videoId: "${mainController.settings.value.live_id}",
                  onFullScreenChange: (value) {
                    isFullScreen.value = value;
                  },
                  isLive: false,
                ),
              );
            }
            return Column(
              children: [
                Container(
                  height: 0.35.sh,
                  width: 1.sw,
                  child: YoutubeVideoPlayer(
                    videoId: "${mainController.settings.value.live_id}",
                    onFullScreenChange: (value) {
                      isFullScreen.value = value;
                    },
                    isLive: false,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: WhiteColor,
                    width: 1.sw,
                    child: Obx(() {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                        controller: logic.scrollController,
                        children: [
                          if (logic.loading.value)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0.02.sh),
                              child: Center(
                                child: Text(
                                  'جلب الرسائل  ...',
                                  style: H4GrayTextStyle,
                                ),
                              ),
                            ),
                          ...List.generate(
                            logic.messages.length,
                            (index) =>logic.messages[index].user?.id==mainController.authUser.value?.id? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  constraints: BoxConstraints(minWidth: 0.00001.sw),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.01.sh, horizontal: 0.02.sw),
                                  margin: EdgeInsets.only(top: 0.01.sh),
                                  decoration: BoxDecoration(
                                      color: GrayLightColor,
                                      borderRadius:
                                      BorderRadius.circular(15.r)),
                                  child:  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${logic.messages[index].user?.name}",
                                        style: H5OrangeTextStyle.copyWith(color: Colors.brown),
                                      ),
                                      Container(
                                        constraints: BoxConstraints(minWidth: 0.001.sw,maxWidth: 0.7.sw),
                                        child: Text(
                                          "${logic.messages[index].body}",
                                          style: H4RegularDark,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(


                                        transformAlignment: Alignment.bottomLeft,
                                        alignment: Alignment.bottomLeft,
                                        child:  Text(
                                          "${logic.messages[index].createdAt}",
                                          style: H5GrayTextStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 0.014.sh),
                                  child: Container(
                                    width: 0.09.sw,
                                    height: 0.09.sw,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                "${logic.messages[index].user?.image}"),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ],
                            ):
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Container(
                                  padding: EdgeInsets.only(top: 0.014.sh),
                                  child: Container(
                                    width: 0.09.sw,
                                    height: 0.09.sw,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                "${logic.messages[index].user?.image}"),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(minWidth: 0.00001.sw),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.01.sh, horizontal: 0.02.sw),
                                  margin: EdgeInsets.only(top: 0.01.sh),
                                  decoration: BoxDecoration(
                                      color: GrayLightColor,
                                      borderRadius:
                                      BorderRadius.circular(15.r)),
                                  child:  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${logic.messages[index].user?.name}",
                                        style: H5OrangeTextStyle,
                                      ),
                                      Container(
                                        constraints: BoxConstraints(minWidth: 0.001.sw,maxWidth: 0.7.sw),
                                        child: Text(
                                          "${logic.messages[index].body}",
                                          style: H4RegularDark,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        transformAlignment: Alignment.bottomLeft,
                                        alignment: Alignment.bottomLeft,
                                        child:  Text(
                                          "${logic.messages[index].createdAt}",
                                          style: H5GrayTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                if (isAuth())
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxHeight: 0.07.sh),
                    width: 1.sw,
                    height: 0.07.sh,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 0.95.sw,
                          child: FormBuilderTextField(
                            name: 'msg',
                            controller: logic.msgController,
                            style: H2RegularDark.copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'أكتب شيئاً ...',
                              hintStyle: H5GrayTextStyle.copyWith(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0.02.sw),
                              suffixIcon: Obx(() {
                                if (logic.loadingSend.value) {
                                  return Container(
                                    width: 0.04.sw,
                                    height: 0.04.sw,
                                    child: Container(
                                        padding: EdgeInsets.all(7),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(7),
                                            child: CircularProgressIndicator(),
                                          ),
                                        )),
                                  );
                                }
                                return Container(
                                  decoration: BoxDecoration(
                                      color: RedColor, shape: BoxShape.circle),
                                  child: Transform.flip(
                                    child: IconButton(
                                        onPressed: () {
                                          if (logic.msgController.text
                                                  .trim()
                                                  .length >
                                              0) {
                                            logic.sendMessage();
                                          }
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.paperPlane,
                                          color: WhiteColor,
                                        )),
                                    flipX: true,
                                  ),
                                );
                              }),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(150.r),
                                borderSide: BorderSide(
                                  color: RedColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(150.r),
                                borderSide: BorderSide(
                                  color: RedColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(150.r),
                                borderSide: BorderSide(
                                  color: RedColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
