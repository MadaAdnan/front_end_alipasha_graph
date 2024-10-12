import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../routes/routes_url.dart';
import '../seller_name_component.dart';

class MinimizeDetailsProductComponent extends StatelessWidget {
  MinimizeDetailsProductComponent({
    super.key,
    required this.post,
    this.onClick,
    this.cartLoading = false,
    this.TitleColor,
  });

  final Color? TitleColor;
  final ProductModel post;
  final Function()? onClick;
  final bool? cartLoading;
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              color: GrayLightColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 0.3.sw,
                  height: 0.3.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider("${post.image}"))),
                ),
                Expanded(
                    child: Container(
                  height: 0.3.sw,
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.01.sw, vertical: 0.002.sh),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SellerNameComponent(
                          color: TitleColor,
                          sellerName: "${post.user?.seller_name ?? ''}",
                          isVerified: post.user?.is_verified == true),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '${post.city?.name ?? ''}',
                            style: H5GrayTextStyle),
                        if (post.category?.name != null)
                          TextSpan(
                              text: ' - ${post.category?.name}',
                              style: H5GrayTextStyle),
                        if (post.sub1?.name != null)
                          TextSpan(
                              text: ' - ${post.sub1?.name}',
                              style: H5GrayTextStyle),
                      ])),
                      Text(
                        "${post.expert!.length < 5 && post.name!.length > 5 ? post.name : post.expert}",
                        style: H4RegularDark,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 0.01.sh,
                      ),
                      Expanded(
                        child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: ' ${post.price} \$ ',
                                style: post.is_discount == true
                                    ? H4GrayTextStyle.copyWith(
                                        decoration: TextDecoration.lineThrough)
                                    : H4RedTextStyle,
                              ),
                              if (post.is_discount == true)
                                TextSpan(
                                    text: ' ${post.discount} \$ ',
                                    style: H4RedTextStyle),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 0.06.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Icon Eye
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.eye,
                                  color: DarkColor,
                                  size: 0.04.sw,
                                ),
                                SizedBox(
                                  width: 0.007.sw,
                                ),
                                Text(
                                  "${post.views_count}",
                                  style: H5BlackTextStyle,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.calendar,
                                  color: DarkColor,
                                  size: 0.04.sw,
                                ),
                                SizedBox(
                                  width: 0.007.sw,
                                ),
                                Text(
                                  "${post.created_at} 2024-05-03",
                                  style: H5BlackTextStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        SizedBox(height: 0.01.sh),
      ],
    );
  }

/* getCol() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.004.sh),
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: GrayDarkColor,
            ),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(text: "معرف المنتج : ", style: H4BlackTextStyle),
                    TextSpan(text: "${post.id}", style: H4RedTextStyle),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.eye,
                    size: 0.04.sw,
                  ),
                  10.horizontalSpace,
                  Text(
                    "${post.views_count}",
                    style: H4RedTextStyle,
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      mainController.addToCart(product: post);
                    },
                    child: Icon(
                      FontAwesomeIcons.edit,
                      size: 0.05.sw,
                      color: OrangeColor,
                    ),
                  ),
                  50.horizontalSpace,
                ],
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(vertical: 0.003.sh, horizontal: 0.02.sw),
              width: 0.4.sw,
              height: 0.19.sh,
              child: Stack(
                children: [
                  Container(
                    width: 0.8.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        image: DecorationImage(
                            image: NetworkImage('${post.image}'),
                            fit: BoxFit.fitWidth)),
                  ),
                  if (post.level == 'special')
                    Positioned(
                      top: 10,
                      child: Container(
                        alignment: Alignment.center,
                        //padding: EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.003.sh),
                        width: 0.4.sw,
                        height: 0.02.sh,

                        decoration:
                            BoxDecoration(color: DarkColor.withOpacity(0.6)),
                        child: Text(
                          'مميز',
                          style: H4OrangeTextStyle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.003.sw, vertical: 0.006.sh),
              width: 0.6.sw,
              child: Column(
                children: [
                  Text(
                    "${post.expert}",
                    style: H3BlackTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  50.verticalSpace,
                  Row(
                    children: [
                      Text(
                        '${post.category?.name} ',
                        style: H4GrayOpacityTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        ' - ${post.sub1?.name} ',
                        style: H4GrayOpacityTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (post.active != '')
                        Container(
                          width: 0.2.sw,
                          padding: const EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 0.04.sh),
                          decoration: BoxDecoration(
                            color: post.active!.active2Color(),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${post.active!.active2Arabic()}',
                                style: H4WhiteTextStyle,
                              ),
                              Icon(
                                post.active!.active2Icon(),
                                color: WhiteColor,
                                size: 0.03.sw,
                              )
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }*/
}


class MinimizeDetailsJobComponent extends StatelessWidget {
  MinimizeDetailsJobComponent({
    super.key,
    required this.post,
    this.onClick,
    this.cartLoading = false,
    this.TitleColor,
  });

  final Color? TitleColor;
  final ProductModel post;
  final Function()? onClick;
  final bool? cartLoading;
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              color: GrayLightColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 0.3.sw,
                  height: 0.3.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider("${post.user?.image}"),fit: BoxFit.fitHeight)),
                ),
                Expanded(
                    child: Container(
                      height: 0.3.sw,
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.01.sw, vertical: 0.002.sh),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SellerNameComponent(
                              color: TitleColor,
                              sellerName: "${post.user?.seller_name ?? ''}",
                              isVerified: post.user?.is_verified == true),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Flexible(flex: 3,child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: '${post.city?.name ?? ''}',
                                      style: H5GrayTextStyle),
                                  if (post.category?.name != null)
                                    TextSpan(
                                        text: ' - ${post.category?.name}',
                                        style: H5GrayTextStyle),
                                  if (post.sub1?.name != null)
                                    TextSpan(
                                        text: ' - ${post.sub1?.name}',
                                        style: H5GrayTextStyle),
                                ])),),Flexible(child: Text("(${post.type?.toCategoryTypeLabel()})", style: H5RegularDark.copyWith(color: OrangeColor),overflow: TextOverflow.ellipsis,))],),
                          Text(
                            "${post.expert!.length < 5 && post.name!.length > 5 ? post.name : post.expert}",
                            style: H4RegularDark,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Expanded(
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '',
                                    style: post.is_discount == true
                                        ? H4GrayTextStyle.copyWith(
                                        decoration: TextDecoration.lineThrough)
                                        : H4RedTextStyle,
                                  ),
                                  if (post.is_discount == true)
                                    TextSpan(
                                        text: ' ${post.discount} \$ ',
                                        style: H4RedTextStyle),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 0.06.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon Eye
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.eye,
                                      color: DarkColor,
                                      size: 0.04.sw,
                                    ),
                                    SizedBox(
                                      width: 0.007.sw,
                                    ),
                                    Text(
                                      "${post.views_count}",
                                      style: H5BlackTextStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.calendar,
                                      color: DarkColor,
                                      size: 0.04.sw,
                                    ),
                                    SizedBox(
                                      width: 0.007.sw,
                                    ),
                                    Text(
                                      "${post.created_at??''}",
                                      style: H5BlackTextStyle,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        SizedBox(height: 0.01.sh),
      ],
    );
  }


}

class MinimizeDetailsServiceComponent extends StatelessWidget {
  MinimizeDetailsServiceComponent({
    super.key,
    required this.post,
    this.onClick,
    this.cartLoading = false,
    this.TitleColor,
  });

  final Color? TitleColor;
  final ProductModel post;
  final Function()? onClick;
  final bool? cartLoading;
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              color: GrayLightColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 0.3.sw,
                  height: 0.3.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider("${post.image}"),fit: BoxFit.fitHeight)),
                ),
                Expanded(
                    child: Container(
                      height: 0.3.sw,
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.01.sw, vertical: 0.002.sh),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(post.user!=null)
                          SellerNameComponent(
                              color: TitleColor,
                              sellerName: "${post.user?.seller_name ?? ''}",
                              isVerified: post.user?.is_verified == true),
                          if(post.user==null)
                            Container(
                              padding:EdgeInsets.only(bottom: 0.004.sh),
                              child: Text("${post.name}",style: H1BlackTextStyle,overflow: TextOverflow.ellipsis,),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(flex: 3,child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '${post.city?.name ?? ''}',
                                        style: H5GrayTextStyle),
                                    if (post.category?.name != null)
                                      TextSpan(
                                          text: ' - ${post.category?.name}',
                                          style: H5GrayTextStyle),
                                    if (post.sub1?.name != null)
                                      TextSpan(
                                          text: ' - ${post.sub1?.name}',
                                          style: H5GrayTextStyle),
                                  ])),),
                              Flexible(child: Text("(${post.type?.toCategoryTypeLabel()})", style: H5RegularDark.copyWith(color: OrangeColor),overflow: TextOverflow.ellipsis,))],),
                          Text(
                            "${post.expert!.length < 5 && post.name!.length > 5 ? post.name : post.expert}",
                            style: H4RegularDark,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Expanded(
                            child: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '',
                                    style: post.is_discount == true
                                        ? H4GrayTextStyle.copyWith(
                                        decoration: TextDecoration.lineThrough)
                                        : H4RedTextStyle,
                                  ),
                                  if (post.is_discount == true)
                                    TextSpan(
                                        text: ' ${post.discount} \$ ',
                                        style: H4RedTextStyle),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 0.06.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon Eye
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.eye,
                                      color: DarkColor,
                                      size: 0.04.sw,
                                    ),
                                    SizedBox(
                                      width: 0.007.sw,
                                    ),
                                    Text(
                                      "${post.views_count}",
                                      style: H5BlackTextStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.calendar,
                                      color: DarkColor,
                                      size: 0.04.sw,
                                    ),
                                    SizedBox(
                                      width: 0.007.sw,
                                    ),
                                    Text(
                                      "${post.updated_at??''}",
                                      style: H5BlackTextStyle,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        SizedBox(height: 0.01.sh),
      ],
    );
  }


}