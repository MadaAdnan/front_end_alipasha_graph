

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';

import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';

import 'package:ali_pasha_graph/models/product_model.dart';


import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import "package:dio/dio.dart" as dio;
import 'package:share_plus/share_plus.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';


class PostCard extends StatelessWidget {
  final ProductModel post;

  PostCard({super.key, required this.post});

  RxBool loading = RxBool(false);
  RxBool loadingCommunity = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
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
                       Get.toNamed(PRODUCTS_PAGE, arguments: post.user);
                     },
                     child: Row(
                       children: [
                         CircleAvatar(
                           backgroundColor: GrayLightColor,
                           backgroundImage:
                           NetworkImage("${post.user?.image}"),
                           minRadius: 0.018.sh,
                           maxRadius: 0.023.sh,
                         ),
                         10.horizontalSpace,
                         Column(
                           children: [
                             if (post.user?.seller_name != null)
                               Container(
                                 width: 0.6.sw,
                                 child:SellerNameComponent(isVerified: post.user?.is_verified==true,
                                   textStyle: H1BlackTextStyle,seller: post.user,),
                               ),
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
                                 if (loading.value == false) {
                                   follow();
                                 }
                               },
                               child: Container(
                                 padding: EdgeInsets.symmetric(
                                     horizontal: 0.009.sw, vertical: 0.004.sh),
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(15.r),
                                     border: Border.all(color: RedColor)),
                                 child: Row(
                                   children: [
                                     if (loading.value == true)
                                       Center(
                                         child: AnimateIcon(
                                           key: UniqueKey(),
                                           onTap: () {},
                                           iconType:
                                           IconType.continueAnimation,
                                           height: 0.055.sw,
                                           width: 0.055.sw,
                                           color: RedColor,
                                           animateIcon: AnimateIcons.bell,
                                         ),
                                       ),
                                     if (loading.value == false)
                                       Icon(
                                         FontAwesomeIcons.bell,
                                         color: RedColor,
                                         size: 0.05.sw,
                                       ),
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
                  Visibility(
                    visible: post.type == 'product',
                    child: Positioned(
                      bottom: 20.h,
                      right: 10.w,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(15.r)),
                            height: 90.h,
                            width: 280.w,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        ' ${post.is_discount == true ? post.discount : post.price ?? 0} ',
                                    style: H2WhiteTextStyle.copyWith(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '\$',
                                    style: H2WhiteTextStyle.copyWith(
                                        fontWeight: FontWeight.bold)),
                              ]),
                            ),
                          ),
                          40.horizontalSpace,
                          InkWell(
                            onTap: () async {
                              await mainController.addToCart(product: post);
                              messageBox(
                                  title: 'نجاح العملية',
                                  message: 'تم الإضافة إلى السلة');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: RedColor,
                                  borderRadius: BorderRadius.circular(10.w)),
                              height: 90.h,
                              width: 120.w,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: const Icon(
                                FontAwesomeIcons.cartShopping,
                                color: WhiteColor,
                              ),
                            ),
                          ),
                        ],
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
                if (isAuth())
                  MaterialButton(
                    onPressed: () async {
                      loadingCommunity.value = true;
                      await mainController.createCommunity(
                          sellerId: post.user!.id!);
                      loadingCommunity.value = false;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.comments,
                          size: 0.05.sw,
                        ),
                        10.horizontalSpace,
                        Obx(() {
                          return loadingCommunity.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  'محادثة',
                                  style: H4BlackTextStyle,
                                );
                        })
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

  follow() async {
    if (post.user?.id != null) {
      loading.value = true;
      try {
        mainController.query.value = '''
      mutation FollowAccount {
    followAccount(id: "${post.user?.id}") {
       $AUTH_FIELDS
    }
}
      ''';
        dio.Response? res = await mainController.fetchData();
        //  mainController.logger.e(res?.data);
        if (res?.data?['data']?['followAccount'] != null) {
          mainController.setUserJson(
              json: res?.data?['data']?['followAccount']);
        }
        if(res?.data?['errors']?[0]?['message']!=null){
          mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
        }
      } on CustomException catch (e) {
        mainController.logger.e(e);
      }
      loading.value = false;
    }
  }
}
