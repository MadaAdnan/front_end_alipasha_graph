import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:animated_icon/animated_icon.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/expand_search.dart';
import '../../components/seller_name_component.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/curve_profile.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);

  final logic = Get.find<ProductsLogic>();
  MainController mainController = Get.find<MainController>();
  RxBool followLoading = RxBool(false);
ScrollController scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Obx(() {
        return Container(
          width: 0.1.sw,
          height: 0.1.sh,
          child: Column(
            children: [
              if (mainController.carts.length > 0)
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(CART_SELLER);
                      },
                      child: Container(
                        padding: EdgeInsets.all(0.02.sw),
                        decoration: BoxDecoration(
                          color: RedColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.cartShopping,
                          color: WhiteColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Badge.count(
                        count: mainController.carts.length,
                        backgroundColor: RedColor,
                      ),
                    )
                  ],
                ),

            ],
          ),
        );
      }),
      backgroundColor: WhiteColor,
      body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            mainController.logger.d(scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent * 0.8 );
            mainController.logger.w(logic.hasMorePage.value);

        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent * 0.8 &&
            logic.hasMorePage.value && !logic.loadingProducts.value) {
          logic.nextPage();
        }
        return true;
      }, child: Obx(() {
        Color? color = logic.seller.value?.is_verified == true
            ? logic.seller.value?.id_color!.toColor()
            : RedColor;
        if (logic.loading.value && logic.page.value==1) {
          return ListView(
            controller: scrollController,
            children: [
              Shimmer.fromColors(
                  baseColor: GrayLightColor,
                  highlightColor: GrayWhiteColor,
                  child: Container(
                    width: 1.sw,
                    height: 0.2.sh,
                    color: Colors.red,
                  )),
              Shimmer.fromColors(
                  baseColor: GrayLightColor,
                  highlightColor: GrayWhiteColor,
                  child: Container(
                    width: 1.sw,
                    height: 0.2.sh,
                    color: Colors.red,
                  )),
              ...List.generate(
                  3, (index) => MinimizeDetailsProductComponentLoading())
            ],
          );
        }

        UserModel? seller = mainController.authUser.value?.followers
            ?.firstWhereOrNull((el) => el.seller?.id == logic.seller.value?.id)
            ?.seller;
        return Stack(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.02.sw, horizontal: 0.02.sw),
                    width: 1.sw,
                    height: 0.25.sh,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "${logic.seller.value?.logo}"),
                            fit: BoxFit.cover)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 0.85.sw,
                            height: 0.06.sh,
                            child: Visibility(
                              visible: true,
                              child: ExpandSearch(
                                controller: logic.searchController,
                                onEditDone: () {
                                  logic.search.value =
                                      logic.searchController.text;
                                  return logic.searchController.text;
                                },
                              ),
                            )),
                        Container(
                          width: 0.1.sw,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle

                          ),
                          child:  PopupMenuButton(
                            iconColor: WhiteColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(value: '1',child:Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.shareNodes,
                                    color: color,
                                    size: 0.05.sw,
                                  ),
                                  Text('مشاركة الملف الشخصي',style: H4RegularDark,)
                                ],
                              ) ,),
                              PopupMenuItem(value: '2',child:Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.headset,
                                    color: color,
                                    size: 0.05.sw,
                                  ),
                                  SizedBox(width: 0.01.sw,),
                                  Text('إبلاغ عن مشكلة',style: H4RegularDark,)
                                ],
                              ) ,),
                            ],
                            onSelected: (value){
                              String? msg='إبلاغ عن المتجر : ${logic.seller.value?.seller_name} - تم الإبلاغ عن من قبل المستخدم : ${mainController.authUser.value?.name}';
                              switch(value){
                                case '1':
                                  Share.share(
                                      'https://ali-pasha.com/products?id=${mainController
                                          .authUser.value?.id}');
                                  break;
                                case '2':
                               if(mainController.settings.value.support?.id !=null){

                                 mainController.createCommunity(sellerId: mainController.settings.value.support!.id!,message: msg);
                               }else{

                                 openUrl(url: "https://wa.me/${mainController.settings.value.social?.phone}?text=$msg");
                               }
                                  break;
                              }
                            },offset: Offset(0, 0.05.sh),),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  child: Expanded(
                      child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (logic.seller.value?.is_verified == true)
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.007.sh),
                                        child: InkWell(
                                          onTap: () {
                                            openUrl(
                                                url:
                                                    "${logic.seller.value?.social?.instagram}");
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.instagram,
                                            color: color,
                                            size: 0.06.sw,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.007.sh),
                                        child: InkWell(
                                            onTap: () {
                                              openUrl(
                                                  url:
                                                      "${logic.seller.value?.social?.face}");
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.facebook,
                                              color: color,
                                              size: 0.06.sw,
                                            )),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.007.sh),
                                        child: InkWell(
                                          onTap: () {
                                            openUrl(
                                                url:
                                                    "${logic.seller.value?.social?.linkedin}");
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.linkedin,
                                            color: color,
                                            size: 0.06.sw,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.007.sh),
                                        child: InkWell(
                                          onTap: () {
                                            openUrl(
                                                url:
                                                    "${logic.seller.value?.social?.linkedin}");
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.tiktok,
                                            color: color,
                                            size: 0.06.sw,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.007.sh),
                                        child: InkWell(
                                          onTap: () {
                                            openUrl(
                                                url:
                                                    "https://wa.me/${logic.seller.value?.phone}");
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.whatsapp,
                                            color: color,
                                            size: 0.06.sw,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.007.sh),
                                        child: InkWell(
                                          onTap: () {
                                            openUrl(
                                                url:
                                                    "${logic.seller.value?.social?.twitter}");
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.xTwitter,
                                            color: color,
                                            size: 0.06.sw,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              Expanded(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 0.04.sh,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: SellerNameComponent(
                                        alignment: MainAxisAlignment.center,
                                        white: false,
                                        color: color,
                                        isVerified:
                                            logic.seller.value?.is_verified ??
                                                false,
                                        seller: logic.seller.value,
                                      ),
                                    ),
                                    if (logic.seller.value?.info?.length != 0)
                                      Container(
                                        height: 0.05.sh,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0.01.sh),
                                        child: logic.seller.value
                                                    ?.is_verified ==
                                                true
                                            ? Text(
                                                "${logic.seller.value?.info}",
                                                style: H4GrayTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : null,
                                      ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: ((logic.seller.value?.address !=
                                                  null &&
                                              logic.seller.value?.address !=
                                                  ''))
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                    child: AutoSizeText(
                                                  "${logic.seller.value?.address}",
                                                  style: H4GrayTextStyle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                                Icon(
                                                  FontAwesomeIcons.locationDot,
                                                  color: GrayDarkColor,
                                                  size: 0.04.sw,
                                                ),
                                              ],
                                            )
                                          : null,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0.02.sh),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                    '${logic.seller.value?.followingCount}'
                                                        .toFormatNumberK(),
                                                    style:
                                                        H0RegularDark.copyWith(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: color),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  );
                                                }),
                                                Text(
                                                  "متابعين",
                                                  style: H4RegularDark,
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${logic.seller.value?.total_views}"
                                                      .toFormatNumberK(),
                                                  style: H0RegularDark.copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: color),
                                                  textDirection:
                                                      TextDirection.ltr,
                                                ),
                                                Text(
                                                  "مشاهدات",
                                                  style: H4RegularDark,
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            child: Column(
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                    '${logic.seller.value?.followers!.length}'
                                                        .toFormatNumberK(),
                                                    style:
                                                        H0RegularDark.copyWith(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: color),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  );
                                                }),
                                                Text(
                                                  "أتابعه",
                                                  style: H4RegularDark,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (logic.seller.value?.is_verified ==
                                            true)
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(GALLERY_PAGE,
                                                  arguments:
                                                      logic.seller.value?.id);
                                            },
                                            child: Container(
                                              width: 0.22.sw,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.01.sh,
                                                  horizontal: 0.02.sw),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  color: logic.seller.value
                                                              ?.is_verified ==
                                                          true
                                                      ? color
                                                      : RedColor),
                                              child: Text(
                                                'معرض الصور',
                                                style: H4WhiteTextStyle,
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          width: 0.02.sw,
                                        ),
                                        InkWell(
                                          onTap: () {

                                            if (mainController.authUser.value !=
                                                null && !mainController.createCommunityLodaing.value) {
                                              mainController.createCommunity(
                                                  sellerId:
                                                      logic.seller.value!.id!);
                                            }else{
                                              mainController.showToast(text: 'يرجى تسجيل الدخول أولاً',type: 'error');

                                            }
                                          },
                                          child: Container(
                                            width: 0.22.sw,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0.01.sh,
                                                horizontal: 0.02.sw),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                color: logic.seller.value
                                                            ?.is_verified ==
                                                        true
                                                    ? color
                                                    : RedColor),
                                            child: Text(
                                              'رسالة خاصة',
                                              style: H4WhiteTextStyle,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0.02.sw,
                                        ),
                                        Obx(() {
                                          if (followLoading.value) {
                                            return Center(
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
                                            );
                                          }
                                          return InkWell(
                                            onTap: () async {
                                              if (mainController
                                                          .authUser.value !=
                                                      null &&
                                                  mainController.authUser.value
                                                          ?.followers
                                                          ?.firstWhereOrNull(
                                                              (el) =>
                                                                  el.seller
                                                                      ?.id ==
                                                                  logic
                                                                      .seller
                                                                      .value!
                                                                      .id!) ==
                                                      null) {
                                                followLoading.value = true;
                                                await mainController.follow(
                                                    sellerId: logic
                                                        .seller.value!.id!);
                                                followLoading.value = false;
                                              }else{
                                                mainController.showToast(text: 'يرجى تسجيل الدخول أولاً',type: 'error');

                                              }
                                            },
                                            child: Container(
                                              width: 0.22.sw,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.01.sh,
                                                  horizontal: 0.02.sw),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                  color: logic.seller.value
                                                              ?.is_verified ==
                                                          true
                                                      ? color
                                                      : RedColor),
                                              child: seller != null
                                                  ? Text(
                                                      'أتابعه',
                                                      style: H4WhiteTextStyle,
                                                    )
                                                  : Text(
                                                      'متابعة',
                                                      style: H4WhiteTextStyle,
                                                    ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.03.sh,
                          ),
                          Container(
                            width: 1.sw,
                            height: 0.04.sh,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                InkWell(
                                  onTap: () {
                                    logic.categoryId.value = null;
                                  },
                                  child: Container(
                                    width: 0.25.sw,
                                    margin: EdgeInsets.only(right: 0.02.sw),
                                    alignment: Alignment.center,
                                    height: 0.02.sh,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.002.sh,
                                        horizontal: 0.02.sw),
                                    decoration: BoxDecoration(
                                        color: logic.categoryId.value != null
                                            ? GrayDarkColor
                                            : color,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Text(
                                      'الكل',
                                      style: H4WhiteTextStyle,
                                    ),
                                  ),
                                ),
                                ...List.generate(
                                    logic.categories.length,
                                    (index) => InkWell(
                                          onTap: () {
                                            logic.categoryId.value =
                                                logic.categories[index].id;
                                          },
                                          child: Container(
                                            width: 0.25.sw,
                                            margin:
                                                EdgeInsets.only(right: 0.02.sw),
                                            alignment: Alignment.center,
                                            height: 0.02.sh,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0.002.sh,
                                                horizontal: 0.02.sw),
                                            decoration: BoxDecoration(
                                                color: logic.categoryId.value !=
                                                        logic.categories[index]
                                                            .id
                                                    ? GrayDarkColor
                                                    : color,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.r)),
                                            child: Text(
                                              '${logic.categories[index].name}',
                                              style: H4WhiteTextStyle,
                                            ),
                                          ),
                                        ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Obx(() {
                        if (logic.loadingProducts.value && logic.page.value==1) {
                          return Column(
                            children: [
                              ...List.generate(
                                  3,
                                  (i) =>
                                      MinimizeDetailsProductComponentLoading())
                            ],
                          );
                        }
                        return Column(
                          children: [
                            ...List.generate(
                              logic.products.length,
                              (index) => Column(
                                children: [
                                  if (logic.advices.length > 0 &&
                                      index % 5 == 0)
                                    AdviceComponent(
                                        advice: logic.advices[
                                            index % logic.advices.length]),
                                  Obx(() {
                                   if(logic.products[index].type=='product'){
                                     return MinimizeDetailsProductComponent(
                                       post: logic.products[index],
                                       cartLoading:
                                       mainController.cartLoading.value,
                                       TitleColor: color,
                                       onClick: () {
                                         Get.toNamed(PRODUCT_PAGE,
                                             arguments:
                                             logic.products[index].id);
                                       },
                                     );
                                   } else if( logic.products[index].type=='tender'){
                                     return MinimizeDetailsTenderComponent(
                                       post: logic.products[index],
                                       cartLoading:
                                       mainController.cartLoading.value,
                                       TitleColor: color,
                                       onClick: () {
                                         Get.toNamed(PRODUCT_PAGE,
                                             arguments:
                                             logic.products[index].id);
                                       },
                                     );
                                   }
                                   else{
                                     return MinimizeDetailsJobComponent(
                                       post: logic.products[index],
                                       cartLoading:
                                       mainController.cartLoading.value,
                                       TitleColor: color,
                                       onClick: () {
                                         Get.toNamed(PRODUCT_PAGE,
                                             arguments:
                                             logic.products[index].id);
                                       },
                                     );
                                   }
                                  }),
                                ],
                              ),
                            ),
                            if (logic.loadingProducts.value && logic.page.value>1)
                              Container(
                                height: 0.05.sw,
                                child: ProgressLoading(width: 0.05.sw,),
                              )
                          ],
                        );

                      }),
                    ],
                  )),
                ),
                // if is_verified
              ],
            ),
            Positioned(
              top: 0.16.sh,
              child: Builder(
                  builder: (context) => InkWell(
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
                                      imageUrl: '${logic.seller.value?.image}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            child: Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
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
                                        '', // وصف الصورة
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
                          width: 1.sw,
                          height: 0.12.sh,
                          decoration: BoxDecoration(
                              border: Border.all(color: WhiteColor),
                              color: GrayLightColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "${logic.seller.value?.image}"),
                                  fit: BoxFit.fitHeight)),
                        ),
                      )),
            ),
          ],
        );
      })),
    );
  }
}
