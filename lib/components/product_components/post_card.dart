import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/youtube_player/view.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';

import 'package:ali_pasha_graph/models/product_model.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import "package:dio/dio.dart" as dio;

import '../../helpers/colors.dart';
import '../../helpers/style.dart';

class PostCard extends StatelessWidget {
  final ProductModel? post;

  PostCard({super.key, this.post});

  RxBool loading = RxBool(false);
  RxBool loadingCommunity = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric( horizontal: 0.002.sw),
      width: double.infinity,
      height: 1.sw+0.187.sh,

      decoration: BoxDecoration(
          color: WhiteColor,
          border: Border(bottom: BorderSide(color: GrayLightColor,width: 0.01.sh))
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(

            padding:
                EdgeInsets.symmetric(horizontal: 0.018.sw, vertical: 0.008.sh),
            width: double.infinity,
            decoration: BoxDecoration(color: WhiteColor),
            height: 0.12.sh,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(PRODUCTS_PAGE, arguments: post?.user);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: GrayLightColor,
                            backgroundImage:
                                NetworkImage("${post?.user?.logo}"),
                            minRadius: 0.018.sh,
                            maxRadius: 0.023.sh,
                          ),
                          10.horizontalSpace,
                          Column(
                            children: [
                              if (post?.user?.seller_name != null)
                                Container(
                                  width: 0.6.sw,
                                  child: Text(
                                    "${post?.user?.seller_name}",
                                    style: H1BlackTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              Container(
                                width: 0.6.sw,
                                child: Text(
                                  '${post?.city?.name ?? ''} - ${post?.category?.name ?? ''} - ${post?.sub1?.name ?? ''}',
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
                            post != null &&
                            post!.user != null &&
                            post!.user!.id != null) {
                          int index = mainController.authUser.value!.followers!
                              .indexWhere(
                            (el) => el.seller?.id == post?.user?.id,
                          );

                          if (index > -1) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.007.sw, vertical: 0.001.sh),
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
                          } else {
                            return InkWell(
                              onTap: () {
                                follow();
                              },
                              child: Obx(() {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.007.sw, vertical: 0.001.sh),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(color: RedColor)),
                                  child: Row(
                                    children: [
                                      if (loading.value == true)
                                        const Center(
                                          child: CircularProgressIndicator(),
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
                                );
                              }),
                            );
                          }
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
                15.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.044.sh,
                  child: Text(
                    "${post?.expert}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: H3GrayTextStyle,
                    /* trimCollapsedText: "عرض المزيد",
                    trimExpandedText: "عرض أقل",


                    trimLines: 1,
                    trimMode: TrimMode.Line,*/
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(PRODUCT_PAGE, arguments: post!.id);
            },
            child: Container(
              width: 1.sw,
              height: 1.sw,
              decoration: BoxDecoration(
                  color: GrayDarkColor,
                  image: DecorationImage(
                      image: NetworkImage(
                        "${post?.image}",
                      ),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  if (post?.level == 'special')
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
                                  text: ' ${post?.price ?? 0}',
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
                    visible: post?.is_discount == true,
                  ),
                  Visibility(
                    visible: post?.type == 'product',
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
                                        ' ${post?.is_discount == true ? post?.discount : post?.price ?? 0} ',
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
                            onTap: ()async {
                            await  mainController.addToCart(product: post!);
                            messageBox(title: 'نجاح العملية',message: 'تم الإضافة إلى السلة');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: RedColor,
                                  borderRadius: BorderRadius.circular(10.w)),
                              height: 90.h,
                              width: 120.w,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Icon(
                                FontAwesomeIcons.cartShopping,
                                color: WhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
                        '${post?.views_count ?? 0}'.toFormatNumber(),
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.comment,
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
                          sellerId: post!.user!.id!);
                      loadingCommunity.value = false;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.headset,
                          size: 0.05.sw,
                        ),
                        10.horizontalSpace,
                        Obx(() {
                          return loadingCommunity.value
                              ? Center(
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
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.share,
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
    if (post?.user?.id != null) {
      loading.value = true;
      try {
        mainController.query.value = '''
      mutation FollowAccount {
    followAccount(id: "${post?.user?.id}") {
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
      } on CustomException catch (e) {
        mainController.logger.e(e);
      }
      loading.value = false;
    }
  }
}
