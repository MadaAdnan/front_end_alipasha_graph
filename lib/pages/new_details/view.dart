import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';

import '../../helpers/colors.dart';
import 'logic.dart';

class NewDetailsPage extends StatelessWidget {
  final logic = Get.put(NewDetailsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sw),
        child: Obx(() {
          if (logic.loading.value) {
            return Container(
              width: 1.sw,
              height: 1.sh,
              alignment: Alignment.center,
              child: ProgressLoading(
                width: 0.3.sw,
              ),
            );
          }
          return Column(
            children: [
              Container(
                child: Text(
                  "${logic.post.value?.name}",
                  style: H1BlackTextStyle,
                ),
              ),
              // slider
              Container(
                child: FlutterCarousel(
                  items: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: '${logic.post.value?.image}',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          child: Image(
                                            image: imageProvider,
                                          ),
                                        )),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    icon: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: WhiteColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: DarkColor,
                                                blurRadius: 0.02.sw)
                                          ]),
                                      child: const Icon(Icons.close,
                                          color: RedColor, size: 30),
                                    ),
                                    onPressed: () => Get.back(),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    color: Colors.black.withOpacity(0.7),
                                    child: Text(
                                      'Image', // وصف الصورة
                                      style: H4BlackTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 0.79.sw,
                        height: 0.79.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "${logic.post.value?.image}"),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    ...List.generate(
                      logic.post.value?.images.length ?? 0,
                      (index) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                      imageUrl:
                                          '${logic.post.value?.images[index]}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            child: Image(
                                              image: imageProvider,
                                            ),
                                          )),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: WhiteColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: DarkColor,
                                                  blurRadius: 0.02.sw)
                                            ]),
                                        child: const Icon(Icons.close,
                                            color: RedColor, size: 30),
                                      ),
                                      onPressed: () => Get.back(),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      color: Colors.black.withOpacity(0.7),
                                      child: Text(
                                        'Image', // وصف الصورة
                                        style: H4BlackTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 0.79.sw,
                          height: 0.79.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "${logic.post.value?.images[index]}"),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    )
                  ],
                  options: FlutterCarouselOptions(
                      height: 0.79.sw,
                      initialPage: 0,
                      autoPlay: true,
                      aspectRatio: 1 / 1,
                      floatingIndicator: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      allowImplicitScrolling: true,
                      slideIndicator: CircularSlideIndicator(
                          slideIndicatorOptions: const SlideIndicatorOptions(
                        enableHalo: false,
                        currentIndicatorColor: RedColor,
                        enableAnimation: true,
                      ))),
                ),
              ),

              Container(
                child: Html(
                  data: "${logic.post.value?.info}",
                  onAnchorTap: (url, context, attributes, element) =>
                      openUrl(url: "$url"),
                  style: {"*":Style.fromTextStyle(H3RegularDark)},
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(COMMENTS_PAGE,
                      parameters: {'id': "${logic.post.value?.id}"});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 0.4.sw,
                  height: 0.04.sh,
                  decoration: BoxDecoration(
                    color: RedColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    'التعليقات',
                    style: H4WhiteTextStyle,
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
