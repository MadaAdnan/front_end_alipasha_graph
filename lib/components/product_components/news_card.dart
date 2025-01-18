import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart' as dio;
import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../pages/home/logic.dart';
import '../../routes/routes_url.dart';

class NewsCard extends StatelessWidget {
  final ProductModel post;

  NewsCard({key, required this.post});

  MainController mainController = Get.find<MainController>();
RxBool is_like=RxBool(false);
  @override
  Widget build(BuildContext context) {
    is_like.value=post.is_like!;
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
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(NEW_DETAILS, arguments: post,parameters: {"id":"${post.id}"});
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: GrayLightColor,
                              backgroundImage: NetworkImage("${post.image}"),
                              minRadius: 0.018.sh,
                              maxRadius: 0.023.sh,
                            ),
                            SizedBox(
                              width: 0.02.sw,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 0.8.sw,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${post.name}",
                                    style: H2BlackTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  width: 0.6.sw,
                                  child: Text(
                                    ' ${post.category?.name ?? ''} - ${post.sub1?.name ?? ''}',
                                    style: H4GrayOpacityTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                15.verticalSpace,
                Flexible(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(NEW_DETAILS, arguments: post.id, parameters: {'id':"${post.id}"});
                    },
                    child: Container(
                      width: 1.sw,
                      child: Text(
                        "${post.expert!.length.isGreaterThan(5) ? post.expert : post.name}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: H2RegularDark.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(NEW_DETAILS, arguments: post.id,parameters: {'id':"${post.id}"});
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
                  if (post.video != null && post.video!.length > 3)
                    Positioned(
                        child: Container(
                      alignment: Alignment.center,
                      width: 1.sw,
                      height: 1.sw,
                      color: Colors.black.withOpacity(0.3),
                      child: Container(
                        alignment: Alignment.center,
                        width: 0.18.sw,
                        height: 0.18.sw,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(colors: [
                              WhiteColor.withOpacity(0.5),
                              WhiteColor.withOpacity(0.2),
                              WhiteColor.withOpacity(0.2),
                              GrayLightColor.withOpacity(0.6)
                            ])),
                        child: IconButton(
                            onPressed: () {
                              Get.toNamed(VIDEO_PLAYER_POST_PAGE,
                                  arguments: "${post.video}");
                            },
                            icon: Icon(
                              FontAwesomeIcons.play,
                              size: 0.08.sw,
                              color: WhiteColor,
                            )),
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
                EdgeInsets.symmetric(horizontal: 0.015.sw, vertical: 0.005.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return InkWell(
                    onTap: () {
                      if(isAuth()){
                        like();
                      }

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          is_like.value == true
                              ? FontAwesomeIcons.solidThumbsUp
                              : FontAwesomeIcons.thumbsUp,
                          size: 0.05.sw,
                          color: is_like.value == true ? RedColor : null,
                        ),
                        SizedBox(
                          width: 0.004.sw,
                        ),
                        Text('${post.likes_count}'.toFormatNumberK(),style: H4BlackTextStyle,)
                      ],
                    ),
                  );
                }),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.eye,
                        size: 0.05.sw,
                      ),
                      SizedBox(
                        width: 0.004.sw,
                      ),
                      Text(
                        '${post.views_count ?? 0}'.toFormatNumber(),
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(COMMENTS_PAGE,
                        parameters: {"id": "${post.id}"});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.message,
                        size: 0.05.sw,
                      ),
                      SizedBox(
                        width: 0.004.sw,
                      ),
                      Text(
                        post.comments_count==0?'تعليق':"${post.comments_count}",
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),


                InkWell(
                  onTap: () {
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
                      SizedBox(
                        width: 0.004.sw,
                      ),
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

  like() async {
    is_like.value = !is_like.value;
    mainController.query.value = '''
    mutation AddLike{
addLike(product_id:"${post.id}"){
    id
            name
            expert
            type
            is_discount
            is_delivery
            is_available
            price
            views_count
            discount
            end_date
            type
            is_like
            likes_count
            level
            image
            video
            created_at
            user {
              id
              name
              id_color
              seller_name
              image
              logo
              is_verified
            }
          
            city {
                name
            }
            start_date
              sub1 {
                name
            }
            category {
                name
            }
}
}
    
    ''';
    try {
      dio.Response? res = await mainController.fetchData();
      mainController.logger.w(res?.data);
      if (res?.data?['data']?['addLike'] != null) {
        ProductModel product = ProductModel.fromJson(
            res?.data?['data']?['addLike']);
        int index = Get
            .find<HomeLogic>()
            .products
            .indexWhere((el) => el.id == product.id);
        is_like.value = product.is_like!;
        if (index > -1) {
          Get
              .find<HomeLogic>()
              .products[index] = product;
        }
      }
    } catch (e) {

    }
  }
}
