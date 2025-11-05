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
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/components.dart';
import '../../models/product_model.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MainController mainController = Get.find<MainController>();
  final HomeLogic logic = Get.find<HomeLogic>();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool _exit = false;
  int _currentAdviceIndex = 0;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.80 &&
          !mainController.loading.value &&
          logic.hasMorePage.value) {
        logic.nextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logic.startTutorialMode(context);
    _exit = false;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        floatingActionButton: _buildFloatingActions(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        backgroundColor: WhiteColor,
        body: Column(
          children: [
            HomeAppBarComponent(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ Widget Building Methods ============

  Widget _buildFloatingActions() {
    return Obx(() {
      return AnimatedOpacity(
        opacity: logic.loading.value ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildCreateProductButton(),
            SizedBox(height: 0.01.sh),
            if (mainController.carts.isNotEmpty) _buildCartButton(),
            SizedBox(height: 0.02.sh),
          ],
        ),
      );
    });
  }

  Widget _buildCreateProductButton() {
    return FloatingActionButton(
      key: mainController.createProductKey,
      onPressed: () => Get.toNamed(CREATE_PRODUCT_PAGE),
      backgroundColor: PrimaryColor.withOpacity(0.7),
      mini: true,
      child: const Icon(FontAwesomeIcons.plus, color: WhiteColor),
    );
  }

  Widget _buildCartButton() {
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: () => Get.toNamed(CART_SELLER),
          backgroundColor: PrimaryColor.withOpacity(0.7),
          mini: true,
          child: const Icon(FontAwesomeIcons.cartShopping, color: WhiteColor),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Badge.count(
            count: mainController.carts.length,
            backgroundColor: PrimaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: CustomScrollView(
        cacheExtent: 300,
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildUserHeader()),
          SliverToBoxAdapter(child: _buildCategoriesSection()),
          SliverToBoxAdapter(child: _buildSellersSection()),
          const SliverToBoxAdapter(
              child: Divider(color: GrayDarkColor, height: 1)),
          _buildProductsSliverList(),
          SliverToBoxAdapter(child: _buildNoMoreResults()),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
      width: 1.sw,
      height: 0.06.sh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildUserAvatar(),
          SizedBox(width: 10.w),
          _buildWhatAreYouThinking(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return InkWell(
        onTap: () {
          if (isAuth()) {
            Get.toNamed(PROFILE_PAGE);
          } else {
            Get.toNamed(LOGIN_PAGE);
          }
        },
        child: Container(
          padding: EdgeInsets.all(0.002.sw),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: GrayDarkColor,
          ),
          child: Container(
            padding: EdgeInsets.all(0.002.sw),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: WhiteColor,
            ),
            child: Obx(() {
              return Container(
                key: mainController.loginKey,
                width: 0.1.sw,
                height: 0.1.sw,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
        ));
  }

  Widget _buildWhatAreYouThinking() {
    return Expanded(
      child: InkWell(
        key: mainController.whatsThink,
        onTap: () => Get.toNamed(CREATE_PRODUCT_PAGE),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
          alignment: Alignment.centerRight,
          height: 0.05.sh,
          decoration: BoxDecoration(
            color: WhiteColor,
            borderRadius: BorderRadius.circular(50.w),
            border: Border.all(
              color: GrayLightColor,
              width: 1.0,
            ),
          ),
          child: Text(
            'ماذا تفكر أن تنشر ...',
            style: H3GrayTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      color: WhiteColor,
      height: 0.115.sh,
      padding: EdgeInsets.symmetric(vertical: 0.002.sh),
      child: Obx(() {
        return ListView.builder(
          cacheExtent: 200,
          key: mainController.moreCategoriesKey,
          scrollDirection: Axis.horizontal,
          controller: logic.scrollControllerCategories,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
          itemCount: mainController.categories.isEmpty
              ? 4
              : mainController.categories
              .where((el) => el.type == 'product')
              .length +
              1,
          itemBuilder: (context, index) {
            if (mainController.categories.isEmpty) {
              return _buildSectionShimmer();
            } else {
              if (index <
                  mainController.categories
                      .where((el) => el.type == 'product')
                      .length) {
                return SectionHomeCard(
                  sectionKey: index == 0 ? mainController.catigoriesKey : null,
                  section: mainController.categories
                      .where((el) => el.type == 'product')
                      .toList()[index],
                );
              } else {
                return _buildViewMoreButton();
              }
            }
          },
        );
      }),
    );
  }

  List<Widget> _buildCategoryCards() {
    final productCategories =
    mainController.categories.where((el) => el.type == 'product').toList();

    return List.generate(productCategories.length, (index) {
      return SectionHomeCard(
        sectionKey: index == 0 ? mainController.catigoriesKey : null,
        section: productCategories[index],
      );
    });
  }

  Widget _buildViewMoreButton() {
    return _ViewMoreButton(
      title: 'عرض المزيد',
      color: ShowMoreColor,
      image: "assets/images/png/show_more.jpg",
      onTap: () => Get.toNamed(SECTIONS_PAGE),
    );
  }

  Widget _buildSellersSection() {
    return Obx(() {
      final sellers = logic.sellers;
      final isLoading = logic.loading.value;
      return Container(
        height: 0.157.sh,
        color: WhiteColor,
        child: ListView.builder(
          // ← استبدال ListView بـ ListView.builder
          cacheExtent: 200,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          scrollDirection: Axis.horizontal,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
          itemCount: logic.sellers.isEmpty && logic.loading.value
              ? 6
              : logic.sellers.length + 1,
          itemBuilder: (context, index) {
            if (sellers.isEmpty && isLoading) {
              return _buildSellerShimmer();
            }

            // آخر عنصر = زر إضافة متجر
            if (index == sellers.length) {
              return _buildAddStore();
            }

            // باقي العناصر = بطاقات البائعين
            return SellerHomePageCard(seller: sellers[index]);
          },
        ),
      );
    });
  }

  Widget _buildAddStore() {
    return InkWell(
      key: mainController.sellerKey,
      onTap: _handleAddStoreTap,
      child: Container(
        width: 0.27.sw,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: GrayLightColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.h, right: 20.w),
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: WhiteColor,
                radius: 40.r,
                child: const Icon(FontAwesomeIcons.plus),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(' أضـف مـتجـــرك', style: H3GrayTextStyle),
                  Text(' هـنــــــا', style: H3GrayTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // الدالة القديمة - محفوظة للتوافق
  Widget _buildProductsSection() {
    return Obx(() {
      return Column(
        children: [
          if (logic.loading.value && logic.products.isEmpty)
            ...List.generate(4, (index) => PostCardLoading()),
          ..._buildProductList(),
        ],
      );
    });
  }

  // الدالة الجديدة المحسّنة - تستخدم SliverList بدلاً من Column
  Widget _buildProductsSliverList() {
    return Obx(() {
      // إذا كانت البيانات تُحمّل لأول مرة، عرض شيمر
      if (logic.loading.value && logic.products.isEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => PostCardLoading(),
            childCount: 4,
          ),
        );
      }

      // عرض المنتجات باستخدام SliverList.builder للأداء الأفضل
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            if (index < logic.products.length) {
              return _buildProductItem(index);
            }
            // عرض مؤشر التحميل في النهاية
            if (logic.loading.value) {
              return _buildLoadingIndicator();
            }
            return const SizedBox.shrink();
          },
          childCount: logic.products.length + (logic.loading.value ? 1 : 0),
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
        ),
      );
    });
  }

  List<Widget> _buildProductList() {
    return List.generate(
      logic.products.length + (logic.loading.value ? 1 : 0),
          (index) {
        if (index < logic.products.length) {
          return _buildProductItem(index);
        }
        return _buildLoadingIndicator();
      },
    );
  }

  Widget _buildProductItem(int index) {
    final product = logic.products[index];
    final widgets = <Widget>[];

    // إضافة البطاقة الرئيسية
    widgets.add(_buildProductCard(product));

    // إضافة الإعلانات كل 5 منتجات
    if (index % 5 == 0 && _currentAdviceIndex < mainController.advices.length) {
      widgets.add(
          AdviceComponent(advice: mainController.advices[_currentAdviceIndex]));
      _currentAdviceIndex++;
      if (_currentAdviceIndex >= mainController.advices.length) {
        _currentAdviceIndex = 0;
      }
    }

    // إضافة الأقسام الخاصة
    widgets.addAll(_buildSpecialSections(index));

    return Column(children: widgets);
  }

  Widget _buildProductCard(ProductModel product) {
    switch (product.type) {
      case 'job':
      case 'search_job':
      case "tender":
        return JobCard(post: product);
      case 'news':
        return NewsCard(post: product);
      default:
        return PostCard(post: product);
    }
  }

  List<Widget> _buildSpecialSections(int index) {
    final sections = <Widget>[];

    if (index == 0 && isAuth() && logic.near.isNotEmpty) {
      sections.add(_buildSpecialSection(
        title: 'قريب منك',
        icon: FontAwesomeIcons.locationDot,
        iconColor: PrimaryColor,
        products: logic.near,
      ));
    }

    if (index == 7 && logic.latest.isNotEmpty) {
      sections.add(_buildSpecialSection(
        title: 'وصل حديثاً',
        icon: FontAwesomeIcons.star,
        iconColor: SecondaryColor,
        products: logic.latest,
      ));
    }

    if (index == 14 && logic.nearSellers.isNotEmpty) {
      sections.add(_buildSpecialSection(
        title: 'تجار قريبون',
        icon: FontAwesomeIcons.store,
        iconColor: PrimaryColor,
        sellers: logic.nearSellers,
        isSeller: true,
      ));
    }

    if (index == 21 && logic.videos.isNotEmpty) {
      sections.add(_buildSpecialSection(
        title: 'شاهدها بالفيديو',
        icon: FontAwesomeIcons.video,
        iconColor: PrimaryColor,
        products: logic.videos,
        isVideo: true,
      ));
    }

    if (index == 28 && logic.specials.isNotEmpty) {
      sections.add(_buildSpecialSection(
        title: 'مختارات علي باشا',
        icon: FontAwesomeIcons.fire,
        iconColor: SecondaryColor,
        products: logic.specials,
      ));
    }

    if (index == 35 && logic.activitySeller.isNotEmpty) {
      sections.add(_buildSpecialSection(
        title: 'أنشط المتاجر',
        icon: FontAwesomeIcons.chartLine,
        iconColor: SecondaryColor,
        sellers: logic.activitySeller,
        isSeller: true,
      ));
    }

    if (index == 42 && logic.activity.isNotEmpty) {
      sections.add(_buildSpecialSection(
        title: 'الأكثر تفاعلا',
        icon: FontAwesomeIcons.comments,
        iconColor: SecondaryColor,
        products: logic.activity,
      ));
    }

    return sections;
  }

  Widget _buildSpecialSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    List<ProductModel>? products,
    List<UserModel>? sellers,
    bool isSeller = false,
    bool isVideo = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(title, icon, iconColor),
        Container(
          height: isSeller ? 0.3.sh : 0.51.sh,
          color: Colors.white,
          child: ListView.builder(
            cacheExtent: 200,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: true,
            itemCount: isSeller ? sellers!.length : products!.length,
            itemBuilder: (context, i) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
              child: isSeller
                  ? SellerCard(seller: sellers![i], logic: logic)
                  : _ProductCard(product: products![i], video: isVideo),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color iconColor) {
    return Padding(
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
          SizedBox(width: 10.w),
          Text(title,
              style: H2BlackTextStyle.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          Icon(icon, color: iconColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: Container(height: 0.06.sh, child: ProgressLoading())),
        Flexible(child: Text('جاري جلب المزيد', style: H4GrayTextStyle)),
      ],
    );
  }

  Widget _buildNoMoreResults() {
    return Obx(() {
      return Visibility(
        visible: !logic.hasMorePage.value,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('لا يوجد مزيد من النتائج', style: H3GrayTextStyle),
          ),
        ),
      );
    });
  }

  // ============ Helper Methods ============

  bool _handleScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollUpdateNotification) {
      mainController.is_show_home_appbar(
        scrollInfo.metrics.pixels <= scrollInfo.metrics.minScrollExtent,
      );
    }
    return false;
  }

  Future<void> _onRefresh() async {
    if (logic.page.value > 1) {
      logic.page.value = 1;
    } else {
      await logic.getProduct();
    }
  }

  Future<bool> _onWillPop() {
    if (_exit) {
      return Future.value(true);
    } else {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
      _exit = true;
      return Future.value(false);
    }
  }

  void _handleAddStoreTap() {
    if (isAuth()) {
      final user = mainController.authUser.value;
      final message =
          "ID:${user?.id} - اسم المتجر : ${user?.seller_name} - نوع الطلب إضافة متجر مميز";
      openUrl(
        url:
        "https://wa.me/${mainController.settings.value.social?.phone}?text=${Uri.encodeComponent(message)}",
      );
    } else {
      Get.toNamed(LOGIN_PAGE);
    }
  }

  Widget _buildSectionShimmer() {
    return Shimmer.fromColors(
      baseColor: GrayLightColor,
      highlightColor: GrayWhiteColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.001.sw),
        height: 0.096.sh,
        width: 0.185.sw,
        margin: EdgeInsets.symmetric(horizontal: 0.0059.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 0.150.sw,
              width: 0.150.sw,
              decoration: BoxDecoration(
                color: GrayLightColor,
                borderRadius: BorderRadius.circular(0.03.sw),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellerShimmer() {
    return Shimmer.fromColors(
      baseColor: GrayLightColor,
      highlightColor: GrayWhiteColor,
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
    );
  }
}

// ============ _ProductCard Widget ============

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool video;

  _ProductCard({required this.product, this.video = false});

  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5.sh,
      width: 0.65.sw,
      decoration: BoxDecoration(
        color: WhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: GrayLightColor,
          width: 1.0,
        ),
      ),
      child: RepaintBoundary(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductInfo(),
            const Spacer(),
            _buildProductFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    if (video && product.video != null && product.video!.length > 3) {
      return _buildVideoProductImage();
    } else {
      return _buildNormalProductImage();
    }
  }

  Widget _buildVideoProductImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            InkWell(
              onTap: () => Get.toNamed(PRODUCT_PAGE, arguments: product.id),
              child: Container(
                alignment: Alignment.center,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider("${product.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 0.18.sw,
                height: 0.18.sw,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    WhiteColor.withOpacity(0.7),
                    WhiteColor.withOpacity(0.4),
                    WhiteColor.withOpacity(0.4),
                    GrayLightColor.withOpacity(0.6),
                  ]),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(VIDEO_PLAYER_POST_PAGE,
                        arguments: "${product.video}");
                  },
                  icon: Icon(
                    FontAwesomeIcons.play,
                    size: 0.08.sw,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNormalProductImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: InkWell(
        onTap: () => Get.toNamed(PRODUCT_PAGE, arguments: product.id),
        child: Stack(
          children: [
            SizedBox(
              width: 0.7.sw,
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: "${product.image}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.visibility, color: Colors.white, size: 14),
                    SizedBox(width: 4.w),
                    Text(
                      "${product.views_count}".toFormatNumberK(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeAndLocation(),
          _buildProductName(),
          _buildProductExpert(),
          _buildSellerInfo(),
        ],
      ),
    );
  }

  Widget _buildTimeAndLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.clock, color: Colors.grey, size: 30.r),
              Text(" ${product.created_at}",
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.locationDot,
                  color: Colors.grey, size: 30.r),
              Text("${product.city?.name}",
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      "${product.name}",
      maxLines: 2,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildProductExpert() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "${product.expert}",
        maxLines: 1,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSellerInfo() {
    return InkWell(
      onTap: () {
        Get.offNamed(PRODUCTS_PAGE, parameters: {"id": "${product.user?.id}"});
      },
      child: Row(
        children: [
          if (product.user?.is_verified == true) SizedBox(width: 4.w),
          Flexible(
            child: AutoSizeText(
              "${product.user?.seller_name}",
              maxLines: 1,
              style: H4RedTextStyle.copyWith(overflow: TextOverflow.ellipsis),
            ),
          ),
          if (product.user?.is_verified == true)
            const Icon(Icons.verified, color: Colors.blue, size: 16),
        ],
      ),
    );
  }

  Widget _buildProductFooter() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAddToCartButton(),
          SizedBox(width: 2.w),
          _buildPriceInfo(),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      width: 0.1.sw,
      height: 0.1.sw,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: IconButton(
        onPressed: _handleAddToCart,
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }

  Widget _buildPriceInfo() {
    if (product.is_discount == true) {
      return Row(
        children: [
          _buildOriginalPrice(),
          SizedBox(width: 15.w),
          _buildDiscountPrice(),
        ],
      );
    } else {
      return _buildNormalPrice();
    }
  }

  Widget _buildOriginalPrice() {
    return Stack(
      children: [
        AutoSizeText("${product.price} \$", style: H4GrayOpacityTextStyle),
        Positioned(
          top: 0.02.sw,
          height: 0.005.sw,
          width: 0.11.sw,
          child: Transform.rotate(
            angle: -0.3,
            child: Container(height: 0.07.sw, color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscountPrice() {
    return AutoSizeText(
      "${product.discount} \$",
      softWrap: false,
      style: H2BlackTextStyle.copyWith(color: Colors.black),
    );
  }

  Widget _buildNormalPrice() {
    return AutoSizeText(
      "\$ ${product.price}",
      style: H3BlackTextStyle.copyWith(color: Colors.black),
    );
  }

  void _handleAddToCart() {
    if (mainController.authUser.value?.id != null) {
      mainController.addToCart(product: product);
      mainController.showToast(
          text: 'تمت إضافة المنتج إلى السلة', type: 'success');
    } else {
      mainController.showToast(text: 'الرجاء تسجيل الدخول', type: 'error');
    }
  }
}

// ============ _ViewMoreButton Widget ============

class _ViewMoreButton extends StatelessWidget {
  final String title;
  final Color color;
  final String image;
  final VoidCallback onTap;

  const _ViewMoreButton({
    required this.title,
    required this.color,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.001.sw),
        height: 0.096.sh,
        width: 0.185.sw,
        margin: EdgeInsets.symmetric(horizontal: 0.0059.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                    image: AssetImage(image),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Text(title,
                overflow: TextOverflow.ellipsis, style: H4BlackTextStyle),
          ],
        ),
      ),
    );
  }
}



class SellerCard extends StatelessWidget {
  SellerCard({super.key, required this.seller, required this.logic});

  final UserModel seller;
  final dynamic logic;
  final MainController mainController = Get.find<MainController>();
  final RxBool isFollowers = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        alignment: Alignment.center,
        width: 0.6.sw,
        child: AspectRatio(
          aspectRatio: 1,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: _navigateToStore,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: _buildCardDecoration(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.01.sh, horizontal: 0.01.sw),
                  child: Stack(
                    children: [
                      // المحتوى الرئيسي
                      _buildMainContent(),

                      // زر المتابعة
                      _buildFollowButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // دالة التنقل إلى المتجر
  void _navigateToStore() {
    Get.toNamed(
      PRODUCTS_PAGE,
      arguments: seller,
      parameters: {"id": "${seller.id}"},
    );
  }

  // دالة بناء التصميم للبطاقة
  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: GrayLightColor,
        width: 1.0,
      ),
    );
  }

  // دالة بناء المحتوى الرئيسي
  Widget _buildMainContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // صورة البائع
        _buildSellerImage(),

        // اسم البائع
        _buildSellerName(),

        // عنوان البائع
        _buildSellerAddress(),
      ],
    );
  }

  // دالة بناء صورة البائع
  Widget _buildSellerImage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.03.sh),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            PrimaryColor,
            PrimaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundImage: CachedNetworkImageProvider("${seller.image}"),
      ),
    );
  }

  // دالة بناء اسم البائع
  Widget _buildSellerName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: AutoSizeText(
            "${seller.seller_name ?? seller.name}",
            overflow: TextOverflow.ellipsis,
            style: H2BlackTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
        if (seller.is_verified == true)
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Icon(
              Icons.verified,
              color: Colors.blue,
              size: 16,
            ),
          ),
      ],
    );
  }

  // دالة بناء عنوان البائع
  Widget _buildSellerAddress() {
    return SizedBox(
      width: 1.sw,
      child: AutoSizeText(
        "${seller.address}",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
    );
  }

  // دالة بناء زر المتابعة
  Widget _buildFollowButton() {
    return Positioned(
      top: 0.01.sh,
      left: 0.01.sw,
      child: Obx(() {
        final isFollowing = _checkIfFollowing();

        return GestureDetector(
          onTap: () {
            if (!isFollowing && seller.id != null) {
              isFollowers.value = true;
              logic.follow(sellerId: seller.id!);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color:
              isFollowing || isFollowers.value ? PrimaryColor : Colors.grey,
            ),
            child: Center(
              child: Icon(
                FontAwesomeIcons.solidHeart,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        );
      }),
    );
  }

  // دالة التحقق من حالة المتابعة
  bool _checkIfFollowing() {
    final authUser = mainController.authUser.value;
    if (authUser == null) return false;

    return authUser.followers?.any((el) => el.seller?.id == seller.id) == true;
  }

  // دالة معالجة الضغط على زر المتابعة
  void _handleFollowTap(bool isCurrentlyFollowing) async {
    if (!isCurrentlyFollowing && seller.id != null) {
      isFollowers.value = true;
      await logic.follow(sellerId: seller.id!);
    }
  }
}
