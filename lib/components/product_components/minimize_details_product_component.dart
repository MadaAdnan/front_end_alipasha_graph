import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/product_enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


import '../../routes/routes_url.dart';
import '../seller_name_component.dart';

class MinimizeDetailsProductComponent extends StatelessWidget {
  MinimizeDetailsProductComponent({
    super.key,
    required this.post,
    this.onClick,
    this.cartLoading = false,
    this.TitleColor,
    this.canEdit,
  });

  final Color? TitleColor;
  final ProductModel post;
  final Function()? onClick;
  final bool? cartLoading;
  final bool? canEdit;
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
              color: GrayWhiteColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 0.33.sw,
                  height: 0.33.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r)),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider("${post.image}"),
                          fit: BoxFit.cover)),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (canEdit == true)
                        Positioned(
                          top: 0.05.sh,
                          child: Container(
                            decoration: BoxDecoration(
                                color: WhiteColor.withOpacity(0.6),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  Get.toNamed(Edit_PRODUCT_PAGE,
                                      arguments: post.id);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.edit,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      if (post.active == 'pending')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: OrangeColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'قيد المراجعة',
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.active == 'block')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'محظور',
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.level == 'special' && post.active == 'active')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: GoldColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'مميز',
                            style: H5WhiteTextStyle,
                          ),
                        )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 0.33.sw,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.01.sw, vertical: 0.002.sh),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "${post.name?.length !=0 ? post.name : post.expert} ",
                          style: H1BlackTextStyle.copyWith(
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 0.001.sh,
                        ),
                        SizedBox(height: 0.005.sh,),
                        Expanded(
                            child: Text(
                          '${post.expert}',
                          style: H4GrayTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(height: 0.01.sh,),
                        Container(
                          width: 1.sw,
                          height: 0.04.sh,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Transform.translate(offset: Offset(0,-0.01.sh),child: SellerNameComponent(

                                    textStyle: H4RegularDark,
                                    color: TitleColor,
                                    seller: post.user,
                                    isVerified: post.user?.is_verified == true),),
                              ),
                              SizedBox(height: 0.01.sh,),
                              if(post.active=='active')
                                Transform.translate(
                                  offset: Offset(0, -0.01.sh),
                                  child:GestureDetector(

                                    onTap: () {
                                      mainController.addToCart(product: post);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.002.sh),

                                      child: Icon(
                                        FontAwesomeIcons.cartShopping,
                                        size: 0.05.sw,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: ' ${post.price} \$ ',
                                  style: post.is_discount == true
                                      ? H4GrayTextStyle.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough)
                                      : H3RedTextStyle,
                                ),
                                if (post.is_discount == true)
                                  TextSpan(
                                      text: ' ${post.discount} \$ ',
                                      style: H3RedTextStyle),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          height: 0.06.sw,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if(post.is_delivery==true)
                                SizedBox(width: 0.14.sw,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.truckFast,color: Colors.green,size: 0.04.sw,),
                                    SizedBox(width: 0.099.sw,child: Text('الشحن متوفر',style: H6BlackTextStyle,),),

                                  ],),)
                              ,
                              if(post.is_delivery!=true)
                                SizedBox(width: 0.14.sw,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.truckFast,color: RedColor,size: 0.04.sw,),
                                    SizedBox(width: 0.098.sw,
                                      child:Text('الشحن غير متوفر',style: H6BlackTextStyle,) ,),

                                  ],),),
                              SizedBox(width: 0.002.sw
                                ,),
                              // Icon Eye
                              SizedBox(width: 0.14.sw,child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.eye,
                                    color: DarkColor,
                                    size: 0.04.sw,
                                  ),
                                  SizedBox(
                                    width: 0.08.sw,
                                    child:  Text(
                                      "${post.views_count}".toFormatNumberK(),
                                      style: H5BlackTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                ],
                              ) ,)
                             ,
                              SizedBox(width: 0.14.sw,child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.locationDot,
                                    color: DarkColor,
                                    size: 0.04.sw,
                                  ),
                                  SizedBox(
                                    width: 0.09.sw,
                                    child:  Text(
                                      "${post.city?.name}",
                                      style: H5BlackTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                ],
                              ) ,)
                              ,
                              SizedBox(width: 0.14.sw,child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.calendar,
                                    color: DarkColor,
                                    size: 0.04.sw,
                                  ),
                                  SizedBox(
                                    width: 0.09.sw,
                                    child:  Text(
                                      "${post.created_at}",
                                      style: H5BlackTextStyle,
                                    ),
                                  ),

                                ],
                              ) ,)
                             ,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0.01.sh),
      ],
    );
  }
}

class MinimizeDetailsJobComponent extends StatelessWidget {
  MinimizeDetailsJobComponent({
    super.key,
    required this.post,
    this.onClick,
    this.cartLoading = false,
    this.TitleColor,
    this.canEdit,
  });

  final Color? TitleColor;
  final ProductModel post;
  final Function()? onClick;
  final bool? cartLoading;
  final bool? canEdit;
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
              color: GrayWhiteColor,
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
                          image:
                              CachedNetworkImageProvider("${post.user?.image}"),
                          fit: BoxFit.cover)),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (canEdit == true)
                        Positioned(
                          top: 0.05.sh,
                          child: Container(
                            decoration: BoxDecoration(
                                color: WhiteColor.withOpacity(0.6),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  Get.toNamed(Edit_JOB_PAGE,
                                      arguments: post.id);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.edit,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      if(post.type=='job' && post.active != 'block' && post.active != 'pending')
                        Container(
                        alignment: Alignment.center,
                        width: 0.2.sw,
                        height: 0.03.sh,
                        decoration: BoxDecoration(
                            color: OrangeColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.r),
                                bottomLeft: Radius.circular(20.r))),
                        child: Text(
                          'شاغر وظيفي',
                          style: H5WhiteTextStyle,
                        ),
                      ),
                      if(post.type=='search_job' && post.active != 'block' && post.active != 'pending')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'يبحث عن عمل',
                            style: H5WhiteTextStyle,
                          ),
                        ),

                      if (post.active == 'pending')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color:"${post.active}".getStatusProductColor(),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            '${post.active}'.getStatusProduct(),
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.active == 'block')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                               color:"${post.active}".getStatusProductColor(),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            '${post.active}'.getStatusProduct(),
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.active == 'hidden')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color:"${post.active}".getStatusProductColor(),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            '${post.active}'.getStatusProduct(),
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.level == 'special' && post.active == 'active')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: GoldColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'مميز',
                            style: H5WhiteTextStyle,
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(width: 0.02.sw,),
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
                      AutoSizeText(
                        "${post.name!.length > 5 ? post.name : post.expert} ",
                        style: H1BlackTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 0.002.sh,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: '${post.city?.name ?? ''}',
                            style: H4GrayTextStyle),
                        if (post.category?.name != null)
                          TextSpan(
                              text: ' - ${post.category?.name}',
                              style: H4GrayTextStyle),
                        if (post.sub1?.name != null)
                          TextSpan(
                              text: ' - ${post.sub1?.name}',
                              style: H4GrayTextStyle),
                      ])),
                      Container(
                        child: SellerNameComponent(
                          onTap: onClick,
                            text: 'منشور بواسطة:',
                            textStyle: H4RegularDark,
                            color: TitleColor,
                            seller: post.user,
                            isVerified: post.user?.is_verified == true),
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
                                  "${post.start_date ?? ''}",
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
                                  "${post.end_date ?? ''}",
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
  MinimizeDetailsServiceComponent(
      {super.key,
      required this.post,
      this.onClick,
      this.cartLoading = false,
      this.TitleColor,
      this.canEdit});

  final Color? TitleColor;
  final ProductModel post;
  final Function()? onClick;
  final bool? cartLoading;
  final bool? canEdit;
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
              color: GrayWhiteColor,
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
                          image: CachedNetworkImageProvider("${post.image}",),
                          fit: BoxFit.cover)),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (canEdit == true)
                        Positioned(
                          top: 0.05.sh,
                          child: Container(
                            decoration: BoxDecoration(
                                color: WhiteColor.withOpacity(0.6),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  Get.toNamed(Edit_SERVICE_PAGE,
                                      arguments: post.id);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.edit,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      if (post.active == 'pending')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: OrangeColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'قيد المراجعة',
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.active == 'block')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'محظور',
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.level == 'special' && post.active == 'active')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: GoldColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'مميز',
                            style: H5WhiteTextStyle,
                          ),
                        )
                    ],
                  ),
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
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "${post.name} ${post.expert} ",
                            style: H1BlackTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 0.002.sh,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '${post.city?.name ?? ''}',
                                style: H3GrayTextStyle),
                            if (post.category?.name != null)
                              TextSpan(
                                  text: ' - ${post.category?.name}',
                                  style: H3GrayTextStyle),
                            if (post.sub1?.name != null)
                              TextSpan(
                                  text: ' - ${post.sub1?.name}',
                                  style: H3GrayTextStyle),
                          ])),
                          if (post.user != null)
                            Container(
                              child: RichText(text: TextSpan(children: [
                                TextSpan(text: 'العنوان : ',style: H4RegularDark),
                                TextSpan(text: ' ${post.address}',style: H4RegularDark),
                              ]),), ),
                          if (post.user == null)
                            Container(
                              padding: EdgeInsets.only(bottom: 0.004.sh),
                              child: Text(
                                "${post.name}",
                                style: H4RegularDark,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      )),
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
                                  "${post.updated_at ?? ''}",
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

class MinimizeDetailsTenderComponent extends StatelessWidget {
  MinimizeDetailsTenderComponent({
    super.key,
    required this.post,
    this.onClick,
    this.cartLoading = false,
    this.TitleColor,
    this.canEdit,
  });

  final Color? TitleColor;
  final ProductModel post;
  final Function()? onClick;
  final bool? cartLoading;
  final bool? canEdit;
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
              color: GrayWhiteColor,
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
                          image:
                              CachedNetworkImageProvider("${post.user?.image}"),
                          fit: BoxFit.fitHeight)),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (canEdit == true)
                        Positioned(
                          top: 0.05.sh,
                          child: Container(
                            decoration: BoxDecoration(
                                color: WhiteColor.withOpacity(0.6),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  Get.toNamed(Edit_TENDER_PAGE,
                                      arguments: post.id);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.edit,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      if (post.active == 'pending')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: OrangeColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'قيد المراجعة',
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.active == 'block')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'محظور',
                            style: H5WhiteTextStyle,
                          ),
                        ),
                      if (post.level == 'special' && post.active == 'active')
                        Container(
                          alignment: Alignment.center,
                          width: 0.2.sw,
                          height: 0.03.sh,
                          decoration: BoxDecoration(
                              color: GoldColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r))),
                          child: Text(
                            'مميز',
                            style: H5WhiteTextStyle,
                          ),
                        )
                    ],
                  ),
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
                          seller: post.user,
                          isVerified: post.user?.is_verified == true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: RichText(
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
                                ])),
                          ),
                          Flexible(
                              child: Text(
                            "(${post.type?.toCategoryTypeLabel()})",
                            style: H5RegularDark.copyWith(color: OrangeColor),
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                      AutoSizeText(
                        "${post.name!.length > 5 ? post.name : post.expert}",
                        style: H1RegularDark,
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
                                  "${post.end_date ?? ''}",
                                  style: H5BlackTextStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),)
              ],
            ),
          ),
        ),
        SizedBox(height: 0.01.sh),
      ],
    );
  }
}
