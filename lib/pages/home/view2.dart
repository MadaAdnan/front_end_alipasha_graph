import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';

import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/components/product_components/news_card.dart';
import 'package:ali_pasha_graph/components/product_components/post_card.dart';
import 'package:ali_pasha_graph/components/product_components/post_card_loading.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/components/sections_components/section_home_card.dart';
import 'package:ali_pasha_graph/components/seller_component/seller_home_page_card.dart';
import 'package:ali_pasha_graph/components/slider_component/slider_product.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'package:shimmer/shimmer.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../helpers/components.dart';
import '../../models/product_model.dart';
import 'logic.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  final mainController = Get.find<MainController>();

  final logic = Get.find<HomeLogic>();

  final ScrollController _scrollController = ScrollController();

  bool exit = false;

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  RxnString privacy = RxnString('');

  int i = 0;

  @override
  Widget build(BuildContext context) {
    logic.startTutorialMode(context);
    exit = false;
    return WillPopScope(
        child: Scaffold(
          floatingActionButton: Obx(() {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    key: logic.createProductKey,
                    onTap: () {
                      Get.toNamed(CREATE_PRODUCT_PAGE);
                    },
                    child: Container(
                      padding: EdgeInsets.all(0.035.sw),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [PrimaryColor, PrimaryColor.withOpacity(0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: PrimaryColor.withOpacity(0.4),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        FontAwesomeIcons.plus,
                        color: WhiteColor,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  if (mainController.carts.length > 0)
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(CART_SELLER);
                          },
                          child: Container(
                            padding: EdgeInsets.all(0.035.sw),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [PrimaryColor, PrimaryColor.withOpacity(0.8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: PrimaryColor.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              FontAwesomeIcons.cartShopping,
                              color: WhiteColor,
                              size: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          child: Badge.count(
                            count: mainController.carts.length,
                            backgroundColor: PrimaryColor,
                          ),
                          top: 0,
                          right: 0,
                        )
                      ],
                    ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                ],
              ),
            );
          }),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          backgroundColor: WhiteColor,
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent * 0.80 &&
                  !mainController.loading.value &&
                  logic.hasMorePage.value) {
                logic.nextPage();
              }
              if (scrollInfo.metrics.pixels <=
                      scrollInfo.metrics.minScrollExtent - 1 &&
                  !mainController.loading.value &&
                  logic.hasMorePage.value) {}

              if (scrollInfo is ScrollUpdateNotification) {
                if (scrollInfo.metrics.pixels >
                    scrollInfo.metrics.minScrollExtent) {
                  mainController.is_show_home_appbar(false);
                } else {
                  mainController.is_show_home_appbar(true);
                }
              }
              return true;
            },
            child: Column(
              children: [
                HomeAppBarComponent(
                  tenderKey: logic.tenderKey,
                  jobKey: logic.jobKey,
                  communityKey: logic.communityKey,
                  homeKey: logic.homeKey,
                  profileKey: logic.profileKey,
                  sectionKey: logic.sectionKey,
                  serviceKey: logic.serviceKey,
                ),
                Expanded(child: Container(
                  child: Obx(() {
                    return RefreshIndicator(
                        child: ListView(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          cacheExtent: 1000,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 0.03.sw,
                                right: 0.03.sw,
                                top: 0.01.sh,
                                bottom: 0.01.sh,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.012.sh),
                              decoration: BoxDecoration(
                                color: WhiteColor,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(PROFILE_PAGE);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(0.005.sw),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            PrimaryColor.withOpacity(0.3),
                                            PrimaryColor.withOpacity(0.1),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Obx(() {
                                        return Container(
                                          key: logic.loginKey,
                                          width: 0.12.sw,
                                          height: 0.12.sw,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: WhiteColor,
                                              width: 2,
                                            ),
                                            image: DecorationImage(
                                              image: mainController.authUser.value?.image != null
                                                  ? CachedNetworkImageProvider(
                                                      '${mainController.authUser.value?.image}')
                                                  : getUserImage(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    12.horizontalSpace,
                                    Expanded(
                                      child: InkWell(
                                        key: logic.whatsThink,
                                        onTap: () {
                                          Get.toNamed(CREATE_PRODUCT_PAGE);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.04.sw, vertical: 0.012.sh),
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                            color: GrayLightColor.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(25.r),
                                          ),
                                          child: Text(
                                            'ماذا تفكر أن تنشر ...',
                                            style: H3GrayTextStyle.copyWith(
                                              fontWeight: FontWeight.w400,
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
                              color: WhiteColor,
                              height: 0.13.sh,
                              padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                              margin: EdgeInsets.only(bottom: 0.01.sh),
                              child: ListView(
                                key: logic.moreCategoriesKey,
                                scrollDirection: Axis.horizontal,
                                controller: logic.scrollControllerCategories,
                                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                children: [
                                  if (mainController.categories.length == 0)
                                    ...List.generate(
                                        4, (index) => _buildSection()),
                                  ...List.generate(
                                      mainController.categories
                                          .where((el) => el.type == 'product')
                                          .length,
                                      (index) => SectionHomeCard(
                                          sectionKey: index == 0
                                              ? logic.catigoriesKey
                                              : null,
                                          section: mainController.categories
                                              .where(
                                                  (el) => el.type == 'product')
                                              .toList()[index])),
                                  _viewMoreButton(
                                      title: 'عرض المزيد',
                                      color: ShowMoreColor,
                                      img: "assets/images/png/show_more.jpg"),
                                ],
                              ),
                            ),

                            // seller
                            Container(
                              height: 0.17.sh,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    WhiteColor,
                                    GrayLightColor.withOpacity(0.3),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 0.02.sw),
                                semanticChildCount: 4,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildAddStore(),
                                  if (logic.sellers.length == 0 &&
                                      logic.loading.value)
                                    ...List.generate(6, (i) {
                                      return _buildSeller();
                                    })
                                  else
                                    ...List.generate(logic.sellers.length,
                                        (index) {
                                      return SellerHomePageCard(
                                        seller: logic.sellers[index],
                                      );
                                    }),
                                ],
                              ),
                            ),
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    GrayLightColor.withOpacity(0.3),
                                    WhiteColor,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),

                            // products
                            if (logic.loading.value &&
                                logic.products.length == 0)
                              ...List.generate(4, (index) => PostCardLoading()),
                            ...List.generate(
                              logic.products.length +
                                  (logic.loading.value ? 1 : 0),
                              (index) {
                                if (mainController.advices.length > 0) {
                                  if (i < mainController.advices.length &&
                                      index % 5 == 0) {
                                    i++;
                                  }
                                  if (i >= mainController.advices.length) {
                                    i = 0;
                                  }
                                }
                                int adviceLength = 5;
                                if (index < logic.products.length) {
                                  switch (logic.products[index].type) {
                                    case 'job':
                                    case 'search_job':
                                    case "tender":
                                      return Column(
                                        children: [
                                          RepaintBoundary(
                                            child: JobCard(post: logic.products[index]),
                                          ),
                                          if (index % adviceLength == 0 &&
                                              i < mainController.advices.length)
                                            AdviceComponent(
                                              advice: mainController.advices[i],
                                            ),
                                        ],
                                      );
                                    case 'news':
                                      return Column(
                                        children: [
                                          RepaintBoundary(
                                            child: NewsCard(post: logic.products[index]),
                                          ),
                                          if (index % adviceLength == 0 &&
                                              i < mainController.advices.length)
                                            AdviceComponent(
                                              advice: mainController.advices[i],
                                            )
                                        ],
                                      );
                                    default:
                                      return Column(
                                        children: [
                                          RepaintBoundary(
                                            child: PostCard(post: logic.products[index]),
                                          ),
                                          if (index % adviceLength == 0 &&
                                              i < mainController.advices.length)
                                            AdviceComponent(
                                              advice: mainController.advices[i],
                                            ),
                                          if(index==0 && isAuth())
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 0.015.sh),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    WhiteColor,
                                                    GrayLightColor.withOpacity(0.2),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 12.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.015.sh),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 4,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [PrimaryColor, SecondaryColor],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              borderRadius: BorderRadius.circular(2),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'قريبة منك',
                                                            style: H2BlackTextStyle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            FontAwesomeIcons.locationDot,
                                                            color: PrimaryColor,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                                      height: 0.52.sh,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        physics: const BouncingScrollPhysics(),
                                                        cacheExtent: 500,
                                                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                                        itemCount: logic.near!.length,
                                                        itemBuilder: (context, i) {
                                                          return Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 0.015.sw),
                                                            child: RepaintBoundary(
                                                              child: _ProductCard(product: logic.near![i]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if(index==1)
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 0.015.sh),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    WhiteColor,
                                                    GrayLightColor.withOpacity(0.2),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 12.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.015.sh),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 4,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [PrimaryColor, SecondaryColor],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              borderRadius: BorderRadius.circular(2),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'وصل حديثاً',
                                                            style: H2BlackTextStyle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            FontAwesomeIcons.star,
                                                            color: SecondaryColor,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                                      height: 0.52.sh,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        physics: const BouncingScrollPhysics(),
                                                        cacheExtent: 500,
                                                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                                        itemCount: logic.latest!.length,
                                                        itemBuilder: (context, i) {
                                                          return Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 0.015.sw),
                                                            child: RepaintBoundary(
                                                              child: _ProductCard(product: logic.latest![i]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if(index==2)
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 0.015.sh),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    WhiteColor,
                                                    GrayLightColor.withOpacity(0.2),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 12.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.015.sh),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 4,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [PrimaryColor, SecondaryColor],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              borderRadius: BorderRadius.circular(2),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'شاهدها بالفيديو',
                                                            style: H2BlackTextStyle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            FontAwesomeIcons.video,
                                                            color: PrimaryColor,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                                      height: 0.52.sh,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        physics: const BouncingScrollPhysics(),
                                                        cacheExtent: 500,
                                                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                                        itemCount: logic.videos!.length,
                                                        itemBuilder: (context, i) {
                                                          return Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 0.015.sw),
                                                            child: RepaintBoundary(
                                                              child: _ProductCard(product: logic.videos![i]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if(index==3 && logic.nearSellers!.length>0)
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 0.015.sh),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    WhiteColor,
                                                    GrayLightColor.withOpacity(0.2),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 12.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.015.sh),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 4,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [PrimaryColor, SecondaryColor],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              borderRadius: BorderRadius.circular(2),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'تجار قريبون',
                                                            style: H2BlackTextStyle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            FontAwesomeIcons.store,
                                                            color: PrimaryColor,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                                      height: 0.18.sh,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        physics: const BouncingScrollPhysics(),
                                                        cacheExtent: 500,
                                                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                                        itemCount: logic.nearSellers!.length,
                                                        itemBuilder: (context, i) {

                                                          return Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 0.015.sw),
                                                            child: RepaintBoundary(
                                                              child: _SellerCard(seller: logic.nearSellers![i]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if(index==4)
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 0.015.sh),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    WhiteColor,
                                                    GrayLightColor.withOpacity(0.2),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 12.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.015.sh),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 4,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [PrimaryColor, SecondaryColor],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              borderRadius: BorderRadius.circular(2),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'مميز',
                                                            style: H2BlackTextStyle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            FontAwesomeIcons.fire,
                                                            color: SecondaryColor,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                                      height: 0.52.sh,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        physics: const BouncingScrollPhysics(),
                                                        cacheExtent: 500,
                                                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                                        itemCount: logic.activity!.length,
                                                        itemBuilder: (context, i) {
                                                          return Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 0.015.sw),
                                                            child: RepaintBoundary(
                                                              child: _ProductCard(product: logic.activity![i]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if(index==5)
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 0.015.sh),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    WhiteColor,
                                                    GrayLightColor.withOpacity(0.2),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(bottom: 12.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.015.sh),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 4,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [PrimaryColor, SecondaryColor],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                              borderRadius: BorderRadius.circular(2),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'عروض خاصة',
                                                            style: H2BlackTextStyle.copyWith(
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            FontAwesomeIcons.tag,
                                                            color: PrimaryColor,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                                      height: 0.52.sh,
                                                      child: ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        physics: const BouncingScrollPhysics(),
                                                        cacheExtent: 500,
                                                        padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                                                        itemCount: logic.specials!.length,
                                                        itemBuilder: (context, i) {
                                                          return Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 0.015.sw),
                                                            child: RepaintBoundary(
                                                              child: _ProductCard(product: logic.specials![i]),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          // فاصل بعد القسم الأخير
                                          if(index==5)
                                            Container(
                                              height: 0.01.sh,
                                              margin: EdgeInsets.symmetric(vertical: 0.01.sh),
                                              color: GrayLightColor.withOpacity(0.5),
                                            ),



                                        ],
                                      );
                                  }
                                }

                                if (logic.loading.value) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: Container(
                                              height: 0.06.sh,
                                              child: ProgressLoading())),
                                      Flexible(
                                          child: Text(
                                        'جاري جلب المزيد',
                                        style: H4GrayTextStyle,
                                      ))
                                    ],
                                  );
                                }
                                return Container();
                              },
                            ),

                            if (!logic.hasMorePage.value)
                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'لا يوجد مزيد من النتائج',
                                  style: H3GrayTextStyle,
                                ),
                              )),
                          ],
                        ),
                        onRefresh: () async {
                          if (logic.page.value > 1) {
                            logic.page.value == 1;
                          } else {
                            await logic.getProduct();
                          }
                        });
                  }),
                ))
              ],
            ),
          ),
        ),
        onWillPop: () {
          if (exit == true) {
            return Future.value(true);
          } else {
            _scrollController.animateTo(0,
                duration: Duration(microseconds: 100), curve: Curves.linear);
            exit = true;
          }
          return Future.value(false);
        });
  }
  _ProductCard({required ProductModel product}) {
    return Container(
      width: 0.65.sw,
      height: 0.52.sh,
      decoration: BoxDecoration(
        color: WhiteColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(PRODUCT_PAGE, arguments: product.id, id: product.id);
              },
              child: Stack(
                children: [
                  Builder(
                    builder: (context) {
                      return SizedBox(
                        width: 0.7.sw,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            "${product.image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.visibility, color: Colors.white, size: 16),
                          SizedBox(width: 5),
                          Text(
                            "${product.views_count}".toFormatNumberK(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
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

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      color: GrayDarkColor,
                      size: 11,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${product.created_at}",
                      style: TextStyle(
                        fontSize: 10,
                        color: GrayDarkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      color: PrimaryColor,
                      size: 11,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${product.city?.name}",
                      style: TextStyle(
                        fontSize: 10,
                        color: GrayDarkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            child: Text(
              "${product.name}",
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: DarkColor,
                height: 1.3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            child: Text(
              "${product.expert}",
              maxLines: 2,
              style: TextStyle(
                fontSize: 12,
                color: SubTitleColor,
                overflow: TextOverflow.ellipsis,
                height: 1.3,
              ),
            ),
          ),

          SizedBox(height: 6.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: InkWell(
              onTap: () {
                Get.offNamed(PRODUCTS_PAGE,
                    parameters: {"id": "${product.user?.id}"});
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: product.user?.image != null
                        ? CachedNetworkImageProvider("${product.user?.image}")
                        : null,
                    backgroundColor: GrayLightColor,
                    child: product.user?.image == null
                        ? Icon(Icons.store, size: 12, color: GrayDarkColor)
                        : null,
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: AutoSizeText(
                      "${product.user?.seller_name}",
                      maxLines: 1,
                      style: H4RedTextStyle.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (product.user?.is_verified == true) SizedBox(width: 3),
                  if (product.user?.is_verified == true)
                    Icon(Icons.verified, color: Colors.blue, size: 16),
                ],
              ),
            ),
          ),

          // Spacer لدفع السعر وزر السلة للأسفل
          Spacer(),

          // السعر وزر الإضافة - مثبت في الأسفل
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // زر السلة
                Container(
                  width: 0.11.sw,
                  height: 0.11.sw,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [PrimaryColor, PrimaryColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: PrimaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (mainController.authUser.value?.id != null) {
                        mainController.addToCart(product: product);
                        mainController.showToast(
                            text: 'تمت إضافة المنتج إلى السلة',
                            type: 'success');
                      } else {
                        mainController.showToast(
                            text: 'الرجاء تسجيل الدخول', type: 'error');
                      }
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                  ),
                ),
                SizedBox(width: 8.w),
                // السعر - ارتفاع ثابت
                Container(
                  height: 0.11.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // السعر الحالي (مع أو بدون خصم)
                      Text(
                        "\$ ${product.is_discount == true ? product.discount : product.price}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: product.is_discount == true ? PrimaryColor : DarkColor,
                          height: 1.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // السعر القديم (فقط إذا كان هناك خصم)
                      if (product.is_discount == true)
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            "\$ ${product.price}",
                            style: TextStyle(
                              fontSize: 12,
                              color: GrayDarkColor,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: PrimaryColor,
                              decorationThickness: 2,
                              height: 1.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _viewMoreButton(
      {required Color color, required String title, String? img}) {
    return InkWell(
      onTap: () {
        Get.toNamed(SECTIONS_PAGE);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 0.150.sw,
              width: 0.150.sw,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: img != null
                      ? DecorationImage(
                          image: AssetImage(img),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: img == null
                    ? Icon(
                        FontAwesomeIcons.ellipsis,
                        color: WhiteColor,
                        size: 32,
                      )
                    : null,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: H4BlackTextStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection() {
    return Shimmer.fromColors(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0.001.sw),
          height: 0.096.sh,
          width: 0.185.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
          ),
          margin: EdgeInsets.symmetric(horizontal: 0.0059.sw),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(0.02.sw),
                  height: 0.150.sw,
                  width: 0.150.sw,
                  decoration: BoxDecoration(
                    color: GrayLightColor,
                    borderRadius: BorderRadius.circular(0.03.sw),
                  ),
                  child: Container(
                    color: GrayLightColor,
                  ),
                ),
              ]),
        ),
        baseColor: GrayLightColor,
        highlightColor: GrayWhiteColor);
  }

  Widget _buildSeller() {
    return Shimmer.fromColors(
        child: Container(
          width: 0.27.sw,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: GrayLightColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20.h, right: 20.w),
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: WhiteColor,
              radius: 40.r,
            ),
          ),
        ),
        baseColor: GrayLightColor,
        highlightColor: GrayWhiteColor);
  }

  _buildAddStore() {
    return InkWell(
      key: logic.sellerKey,
      onTap: () {
        if (isAuth()) {
          String message =
              "ID:${mainController.authUser.value?.id} - اسم المتجر : ${mainController.authUser.value?.seller_name} - نوع الطلب إضافة متجر مميز";
          openUrl(
              url:
                  "https://wa.me/${mainController.settings.value.social?.phone}?text=${Uri.encodeComponent(message.toString())}");
        } else {
          Get.toNamed(LOGIN_PAGE);
        }
      },
      child: Container(
        width: 0.32.sw,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              GrayLightColor.withOpacity(0.3),
              GrayLightColor.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: GrayDarkColor.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: GrayDarkColor.withOpacity(0.15),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: GrayDarkColor.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: GrayDarkColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 42.r,
                backgroundColor: WhiteColor,
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: GrayDarkColor,
                  size: 28,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'أضـف مـتجـــرك',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: GrayDarkColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'هـنــــــا',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: GrayDarkColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget? _SellerCard({required UserModel seller}) {
    return InkWell(
      onTap: () {
        Get.offNamed(PRODUCTS_PAGE, parameters: {"id": "${seller.id}"});
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    PrimaryColor,
                    SecondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: PrimaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundImage: CachedNetworkImageProvider("${seller.image}"),
                backgroundColor: GrayLightColor,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: AutoSizeText(
                    "${seller.seller_name ?? seller.name}555555",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: DarkColor,
                    ),
                  ),
                ),
                if (seller.is_verified == true) SizedBox(width: 3),
                if (seller.is_verified == true)
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 14,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
