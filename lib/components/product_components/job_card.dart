import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/queries.dart';

import 'package:ali_pasha_graph/models/product_model.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import "package:dio/dio.dart" as dio;


import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';
import '../../helpers/colors.dart';
import '../../helpers/style.dart';

class JobCard extends StatelessWidget {
  final ProductModel? post;

  JobCard({super.key, this.post});

  RxBool loading = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Container(

      padding: EdgeInsets.symmetric(vertical: 0.002.sh, horizontal: 0.002.sw),
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
            color: WhiteColor,
            height: 0.12.sh,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: GrayLightColor,
                          backgroundImage: CachedNetworkImageProvider("${post?.user?.image}"),
                          minRadius: 0.018.sh,
                          maxRadius: 0.023.sh,
                        ),
                        10.horizontalSpace,
                        Column(
                          children: [
                            SizedBox(
                              width: 0.6.sw,
                              child: Text(
                                "${post?.user?.seller_name}",
                                style: H1BlackTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(onTap: (){ Get.toNamed(PRODUCT_PAGE, arguments: post?.id);},child:SizedBox(
                              width: 0.6.sw,
                              child: Text(
                                '${post?.city?.name ?? ''} - ${post?.category?.name ?? ''} - ${post?.sub1?.name ?? ''}',
                                style: H4GrayOpacityTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                          ],
                        )
                      ],
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
                          } else {
                            return InkWell(
                              onTap: () {
                                follow();
                              },
                              child: Obx(() {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.009.sw, vertical: 0.004.sh),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(color: RedColor)),
                                  child: Row(
                                    children: [
                                      if (loading.value == true)
                                         SizedBox(width: 0.04.sw,height:0.04.sw,child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),),
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
                SizedBox(
                  width: 1.sw,
                  height: 0.044.sh,
                  child: Text(
                    "${post?.expert}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: H3RegularDark.copyWith(color: Colors.black),
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
              Get.toNamed(PRODUCT_PAGE,arguments: post?.id);
            },
            child: Container(
              width:1.sw,
              height:1.sw,
              decoration: BoxDecoration(
                  color: GrayDarkColor,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "${post?.user?.image}",
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
                    visible: (post?.type == 'job' || post?.type == 'search_job' ||post?.type == 'tender') && post!.code!.length>0,
                    child: Positioned(
                      bottom: 20.h,
                      right: 10.w,
                      child: InkWell(
                        onTap: () async {
                          Clipboard.setData(
                              await ClipboardData(text: post?.code ?? ''));
                          Toast.show('تم النسخ إلى الحافظة',
                              duration: Toast.lengthLong,
                              gravity: Toast.center);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: RedColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          height: 90.h,
                          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: ' كود الوظيفة : ',
                                  style: H2WhiteTextStyle.copyWith(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: '${post!.code ?? ''}',
                                  style: H2WhiteTextStyle.copyWith(
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),

                          /*  Text(
                            ,
                            style: H3WhiteTextStyle,
                          ),*/
                        ),
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
                  onPressed: () {

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.eye,size: 0.05.sw,),
                      10.horizontalSpace,
                      Text(
                        '${post?.views_count ?? 0}'.toFormatNumber(),
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
              /*  MaterialButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.comment),
                      10.horizontalSpace,
                      Text(
                        'تعليق',
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
                        FontAwesomeIcons.headset,
                      ),
                      10.horizontalSpace,
                      Text(
                        'محادثة',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),*/
                Row(
                  children: [
                    Icon(FontAwesomeIcons.calendar,size: 0.05.sw,),
                    Text("${post?.end_date}",style: H4BlackTextStyle,)
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    Share.share("https://ali-pasha.com/products/${post?.id}");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.shareNodes,size: 0.05.sw,),
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
       // mainController.logger.e(res?.data);
        if (res?.data?['data']?['followAccount'] != null) {
          mainController.setUserJson(json: res?.data?['data']?['followAccount']);
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
