import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../routes/routes_url.dart';

class NewsCard {
  final ProductModel post;

  NewsCard({ required this.post});
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 0.002.sw),
      width: double.infinity,
      height: 1.sw + 0.187.sh,
      decoration: BoxDecoration(
          color: WhiteColor,
          border: Border(
              bottom: BorderSide(color: GrayLightColor, width: 0.01.sh))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 0.018.sw, vertical: 0.008.sh),
            width: double.infinity,
            decoration: const BoxDecoration(color: WhiteColor),
            height: 0.12.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex: 3,child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(NEW_DETAILS, arguments: post);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: GrayLightColor,
                            backgroundImage:
                            NetworkImage("${post.image}"),
                            minRadius: 0.018.sh,
                            maxRadius: 0.023.sh,
                          ),
                          10.horizontalSpace,
                          Column(
                            children: [
                             /* if (post.user?.seller_name != null)
                                Container(
                                  width: 0.6.sw,
                                  child:SellerNameComponent(isVerified: post.user?.is_verified==true,
                                    textStyle: H1BlackTextStyle,seller: post.user,),
                                ),*/
                              Container(
                                width: 0.6.sw,
                                child: Text(
                                  '${post.city?.name ?? ''} - ${post.category?.name ?? ''} - ${post.sub1?.name ?? ''}',
                                  style: H4GrayOpacityTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Obx(() {
                      if (mainController.authUser.value != null) {
                        // Check Is Follower
                        if (mainController.authUser.value != null &&
                            mainController.authUser.value!.followers != null &&
                            post.user != null &&
                            post.user!.id != null) {
                          int index = mainController.authUser.value!.followers!
                              .indexWhere(
                                (el) => el.seller?.id == post.user?.id,
                          );

                          if (index > -1) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.009.sw, vertical: 0.004.sh),
                              decoration: BoxDecoration(
                                  color: RedColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(color: RedColor)),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidBell,
                                    color: WhiteColor,
                                    size: 0.05.sw,
                                  ),
                                  3.horizontalSpace,
                                  Text(
                                    "أتابعه",
                                    style: H5WhiteTextStyle,
                                  )
                                ],
                              ),
                            );
                          } else if (post.user?.id !=
                              mainController.authUser.value?.id) {
                            return Obx(() {
                              return InkWell(
                                onTap: () {
                                /*  if (loading.value == false) {
                                    follow();
                                  }*/
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.009.sw, vertical: 0.004.sh),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(color: RedColor)),
                                  child: Row(
                                    children: [

                                      3.horizontalSpace,
                                      Text(
                                        "متابعة",
                                        style: H5RedTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),),
                15.verticalSpace,
                Flexible(flex: 2,child: InkWell(onTap: (){ Get.toNamed(PRODUCT_PAGE, arguments: post.id);},child: Container(
                  width: 1.sw,

                  child: Text(
                    "${post.expert!.length.isGreaterThan(5) ? post.expert : post.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: H3GrayTextStyle,
                  ),
                ), ), )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(PRODUCT_PAGE, arguments: post.id);
            },
            child: Container(
              width: 1.sw,
              height: 1.sw,
              decoration: BoxDecoration(
                  color: GrayDarkColor,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "${post.image}",
                      ),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  if(post.video!=null && post.video!.length>3)
                    Positioned(child:Container(
                      alignment: Alignment.center,
                      width: 1.sw,
                      height: 1.sw,
                      color: Colors.black.withOpacity(0.3),
                      child:Container(
                        alignment: Alignment.center,
                        width: 0.18.sw,
                        height: 0.18.sw,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(colors: [WhiteColor.withOpacity(0.5),WhiteColor.withOpacity(0.2),WhiteColor.withOpacity(0.2),GrayLightColor.withOpacity(0.6)])
                        ),
                        child: IconButton(onPressed: (){
                          Get.toNamed(VIDEO_PLAYER_POST_PAGE,arguments: "${post.video}");
                        }, icon: Icon(FontAwesomeIcons.play,size: 0.08.sw,color: WhiteColor,)),
                      ),
                    )),
                  if (post.level == 'special')
                    Positioned(
                      top: 20.h,
                      left: 10.w,
                      child: Container(
                        decoration: BoxDecoration(
                            color: OrangeColor,
                            borderRadius: BorderRadius.circular(15.r)),
                        height: 70.h,
                        width: 150.w,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'مميز',
                              style: H4WhiteTextStyle,
                            ),
                            10.horizontalSpace,
                            Icon(
                              FontAwesomeIcons.solidStar,
                              color: GoldColor,
                              size: 50.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  Visibility(
                    visible: post.is_discount == true,
                    child: Positioned(
                      bottom: 100.h,
                      right: 40.w,
                      child: Transform.rotate(
                        angle: 270,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: GrayDarkColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          height: 90.h,
                          width: 280.w,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: ' ${post.price ?? 0}',
                                  style: H2BlackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough)),
                              TextSpan(
                                  text: '\$',
                                  style: H2BlackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.05.sh,
            alignment: Alignment.center,
            color: WhiteColor,
            padding:
            EdgeInsets.symmetric(horizontal: 0.001.sw, vertical: 0.005.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.eye,
                        size: 0.05.sw,
                      ),
                      10.horizontalSpace,
                      Text(
                        '${post.views_count ?? 0}'.toFormatNumber(),
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Get.toNamed(COMMENTS_PAGE,
                        parameters: {"id":"${post.id}" });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.message,
                        size: 0.05.sw,
                      ),
                      10.horizontalSpace,
                      Text(
                        'تعليق',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),

                MaterialButton(
                  onPressed: () {
                    Share.share("https://ali-pasha.com/products/${post.id}");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.shareNodes,
                        size: 0.05.sw,
                      ),
                      10.horizontalSpace,
                      Text(
                        'مشاركة',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}