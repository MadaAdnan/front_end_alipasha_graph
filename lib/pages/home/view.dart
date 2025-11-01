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

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      padding: EdgeInsets.all(0.02.sw),
                      decoration: BoxDecoration(
                        color: PrimaryColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.plus,
                        color: WhiteColor,
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
                            padding: EdgeInsets.all(0.02.sw),
                            decoration: BoxDecoration(
                              color: PrimaryColor.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              FontAwesomeIcons.cartShopping,
                              color: WhiteColor,
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
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(PROFILE_PAGE);
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 0.02.sw),
                                width: 1.sw,
                                height: 0.06.sh,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(0.002.sw),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: GrayDarkColor,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(0.002.sw),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: WhiteColor,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(0.002.sw),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: Obx(() {
                                            return Container(
                                              key: logic.loginKey,
                                              width: 0.1.sw,
                                              height: 0.1.sw,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: mainController
                                                                  .authUser
                                                                  .value
                                                                  ?.image !=
                                                              null
                                                          ? CachedNetworkImageProvider(
                                                              '${mainController.authUser.value?.image}')
                                                          : getUserImage())),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    Expanded(
                                      child: InkWell(
                                        key: logic.whatsThink,
                                        onTap: () {
                                          Get.toNamed(CREATE_PRODUCT_PAGE);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.02.sw),
                                          alignment: Alignment.centerRight,
                                          height: 0.05.sh,
                                          decoration: BoxDecoration(
                                            color: WhiteColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: GrayDarkColor,
                                                  blurRadius: 3),
                                              BoxShadow(
                                                  color:
                                                      GrayDarkColor.withOpacity(
                                                          0.4),
                                                  blurRadius: 3),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(50.w),
                                          ),
                                          child: Text(
                                            'ماذا تفكر أن تنشر ...',
                                            style: H3GrayTextStyle,
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
                              height: 0.115.sh,
                              padding: EdgeInsets.symmetric(vertical: 0.002.sh),
                              child: ListView(
                                key: logic.moreCategoriesKey,
                                scrollDirection: Axis.horizontal,
                                controller: logic.scrollControllerCategories,
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
                              height: 0.157.sh,
                              width: double.infinity,
                              color: WhiteColor,
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
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
                            Divider(
                              color: GrayDarkColor,
                              height: 0.0017.sh,
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
                                          JobCard(post: logic.products[index]),
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
                                          NewsCard(post: logic.products[index]),
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
                                          PostCard(post: logic.products[index]),
                                          if (index % adviceLength == 0 &&
                                              i < mainController.advices.length)
                                            AdviceComponent(
                                              advice: mainController.advices[i],
                                            ),
                                          if (index == 0 &&
                                              isAuth() &&
                                              logic.near.length > 0)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'قريبة منك',
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.51.sh,
                                                  padding: EdgeInsetsGeometry
                                                      .symmetric(vertical: 2),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount:
                                                        logic.near.length,
                                                    itemBuilder: (context, i) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsGeometry
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.01.sw),
                                                      child: _ProductCard(
                                                          product:
                                                              logic.near![i]),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 7 &&
                                              logic.latest.length > 0)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'وصل حديثاً',
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.51.sh,
                                                  padding: EdgeInsetsGeometry
                                                      .symmetric(vertical: 2),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount:
                                                        logic.latest.length,
                                                    itemBuilder: (context, i) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsGeometry
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.01.sw),
                                                      child: _ProductCard(
                                                          product:
                                                              logic.latest![i]),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 14 &&
                                              logic.videos.length > 0)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'شاهدها بالفيديو',
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.51.sh,
                                                  padding: EdgeInsetsGeometry
                                                      .symmetric(vertical: 2),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount:
                                                        logic.videos.length,
                                                    itemBuilder: (context, i) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsGeometry
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.01.sw),
                                                      child: _ProductCard(
                                                          product:
                                                              logic.videos![i],video: true),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 21 &&
                                              logic.nearSellers.length > 0)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'تجار قريبون',
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.3.sh,
                                                  padding: EdgeInsetsGeometry
                                                      .symmetric(vertical: 2),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount: logic
                                                        .nearSellers.length,
                                                    itemBuilder: (context, i) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsGeometry
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.01.sw),
                                                      child: _SellerCard(
                                                          seller: logic
                                                              .nearSellers[i]),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 28 &&
                                              logic.activity.length > 0)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'الأكثر تفاعلاً',
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.51.sh,
                                                  padding: EdgeInsetsGeometry
                                                      .symmetric(vertical: 2),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount:
                                                        logic.activity.length,
                                                    itemBuilder: (context, i) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsGeometry
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.01.sw),
                                                      child: _ProductCard(
                                                          product: logic
                                                              .activity![i]),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 35 &&
                                              logic.specials.length > 0)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'مختارات علي باشا',
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.51.sh,
                                                  padding: EdgeInsetsGeometry
                                                      .symmetric(vertical: 2),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount:
                                                        logic.specials.length,
                                                    itemBuilder: (context, i) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsGeometry
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.01.sw),
                                                      child: _ProductCard(
                                                          product: logic
                                                              .specials![i]),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (index == 42 &&
                                              logic.activitySeller.length > 0)
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'أنشط المتاجر',
                                                    style: H2BlackTextStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.3.sh,
                                                  padding: EdgeInsetsGeometry
                                                      .symmetric(vertical: 2),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount: logic
                                                        .activitySeller.length,
                                                    itemBuilder: (context, i) =>
                                                        Padding(
                                                      padding:
                                                          EdgeInsetsGeometry
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.01.sw),
                                                      child: _SellerCard(
                                                          seller: logic
                                                              .activitySeller[i]),
                                                    ),
                                                  ),
                                                ),
                                              ],
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

  _ProductCard({required ProductModel product, bool video = false}) {
    return Container(
      height: 0.5.sh,
      width: 0.65.sw,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.01),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: video == true && product.video!.length > 3
                ? Positioned(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                      alignment: Alignment.center,
                      width: 1.sw,

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
                                  arguments: "${product.video}");
                            },
                            icon: Icon(
                              FontAwesomeIcons.play,
                              size: 0.08.sw,
                              color: WhiteColor,
                            )),
                      ),
                                        ),
                    ))
                : InkWell(
                    onTap: () {
                      Get.toNamed(PRODUCT_PAGE, arguments: product.id);
                    },
                    child: Stack(
                      children: [
                        Builder(builder: (context) {
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
                        }),
                        Positioned(
                          left: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.visibility,
                                    color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  "${product.views_count}".toFormatNumberK(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.grey,
                      size: 30.r,
                    ),
                    Text(
                      " ${product.created_at}",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.grey,
                      size: 30.r,
                    ),
                    Text(
                      "${product.city?.name}",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "${product.name}",
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "${product.expert}",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                Get.offNamed(PRODUCTS_PAGE,
                    parameters: {"id": "${product.user?.id}"});
              },
              child: Row(
                children: [
                  if (product.user?.is_verified == true) SizedBox(width: 4),
                  Expanded(
                    child: AutoSizeText(
                      "${product.user?.seller_name}",
                      maxLines: 1,
                      style: H4RedTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  if (product.user?.is_verified == true)
                    Icon(Icons.verified, color: Colors.blue, size: 16),
                ],
              ),
            ),
          ),

          const Spacer(),

          // السعر وزر الإضافة
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 0.1.sw,
                  height: 0.1.sw,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  ),
                  child: IconButton(
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
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                ),
                2.horizontalSpace,
                if (product.is_discount == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          AutoSizeText(
                            "${product.price} \$",
                            textDirection: TextDirection.rtl,
                            style: H4GrayOpacityTextStyle,
                          ),
                          Positioned(
                            top: 0.02.sw,
                            height: 0.005.sw,
                            width: 0.11.sw,
                            child: Transform.rotate(
                              angle: -0.3, // زاوية الميلان (بالتقدير الرادياني)
                              child: Container(
                                height: 0.07.sw,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      15.horizontalSpace,
                      AutoSizeText(
                        "${product.discount} \$",
                        softWrap: false,
                        style: H2BlackTextStyle.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                const SizedBox(width: 8),
                if (product.is_discount != true)
                  AutoSizeText(
                    "\$ ${product.price}",
                    style: H3BlackTextStyle.copyWith(color: Colors.black),
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
        padding: EdgeInsets.symmetric(vertical: 0.001.sw),
        height: 0.096.sh,
        width: 0.185.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 0.0059.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // padding: EdgeInsets.all(0.007.sw),
              height: 0.150.sw,
              width: 0.150.sw,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(150.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150.r),
                  image: DecorationImage(
                    image: AssetImage("${img}"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: H4BlackTextStyle,
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
          openUrl(
              url:
                  "https://wa.me/${mainController.settings.value.social?.phone}?text=طلب متجر مميز");
        } else {
          Get.toNamed(LOGIN_PAGE);
        }
      },
      child: Container(
        width: 0.27.sw,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: GrayLightColor,
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
                image: AssetImage('assets/images/png/no-image.png'),
                fit: BoxFit.fill,
                opacity: 0.7)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.h, right: 20.w),
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: WhiteColor,
                radius: 40.r,
                child: Icon(FontAwesomeIcons.plus),
              ),
            ),
            InkWell(
              onTap: () {
                if (isAuth()) {
                  String message =
                      "ID:${mainController.authUser.value?.id} - اسم المتجر : ${mainController.authUser.value?.seller_name} - نوع الطلب إضافة متجر مميز";
                  openUrl(
                      url:
                          "https://wa.me/${mainController.settings.value.social?.phone}?text=${Uri.encodeComponent('${message!.toString()}')}");
                } else {
                  Get.toNamed(LOGIN_PAGE);
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ' أضـف مـتجـــرك',
                        style: H3GrayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ' هـنــــــا',
                        style: H3GrayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget? _SellerCard({required UserModel seller}) {
    return Container(
      alignment: Alignment.center,
      width: 0.6.sw,
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          color: Colors.white,
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.01.sw),
            child: Stack(
              children: [
                Positioned(
                    top: 0.01.sh,
                    left: 0.01.sw,
                    child: Obx(() {
                      return InkWell(
                          onTap: () {
                            if (mainController.authUser.value!.followers!
                                        .indexWhere((el) =>
                                            el.seller?.id == seller?.id) ==
                                    -1 &&
                                seller.id != null) {
                              logic.follow(sellerId: seller.id!);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(30.r),
                              color: mainController.authUser.value!.followers!
                                          .indexWhere((el) =>
                                              el.seller?.id == seller?.id) >
                                      -1
                                  ? PrimaryColor
                                  : Colors.grey,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.004.sh),
                            child: Icon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.white,
                            ),
                          ));
                    })),
                InkWell(
                    onTap: () {
                      Get.toNamed(PRODUCTS_PAGE,
                          arguments: seller,
                          parameters: {"id": "${seller.id}"});
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.01.sw, vertical: 0.03.sh),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  PrimaryColor,
                                  PrimaryColor.withOpacity(0.7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                CachedNetworkImageProvider("${seller.image}"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "${seller.seller_name ?? seller.name}",
                              overflow: TextOverflow.ellipsis,
                              style: H2BlackTextStyle.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
                              textAlign: TextAlign.center,
                            ),
                            if (seller.is_verified == true)
                              Icon(
                                Icons.verified,
                                color: Colors.blue,
                              ),
                          ],
                        ),
                        SizedBox(
                            width: 1.sw,
                            child: AutoSizeText(
                              "${seller.address}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
