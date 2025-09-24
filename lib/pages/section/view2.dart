import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/filter_section.dart';
import 'package:ali_pasha_graph/components/product_components/ProductSectionComponent.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import '../../models/city_model.dart';
import 'logic.dart';

class SectionPage2 extends StatelessWidget {
  SectionPage2({Key? key}) : super(key: key);

  final logic = Get.find<SectionLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: CustomAppBarSection(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !mainController.loading.value &&
              logic.hasMorePage.value &&
              _scrollController.position.context.notificationContext ==
                  scrollInfo.context) {
            logic.nextPage();
          }

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
        child: Obx(() {
          if (logic.products.length > 0) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: GridView(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.53, // للتحكم في طول/عرض البطاقة
                ),
                children: [
                  ...logic.products.map((product) {
                    return _ProductCard(product: product);
                  }).toList(),
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  _buildSubSection({required CategoryModel category}) {
    return InkWell(
      onTap: () {
        logic.categoryId.value = category.id;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.01.sw),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 0.001.sh, horizontal: 0.05.sw),
        decoration: BoxDecoration(
            color: logic.categoryId.value == category.id
                ? PrimaryColor
                : GrayLightColor,
            borderRadius: BorderRadius.circular(15.r)),
        child: Text(
          "${category.name}",
          style: logic.categoryId.value != category.id
              ? H3BlackTextStyle
              : H3WhiteTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  _loadingbuildSubSection() {
    return InkWell(
      child: Container(
        width: 1.sw / 4.5,
        margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 0.001.sh, horizontal: 0.02.sw),
        decoration: BoxDecoration(
            color: GrayLightColor, borderRadius: BorderRadius.circular(15.r)),
        child: Text(
          "القسم",
          style: H3WhiteTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  _ProductCard({required ProductModel product}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: InkWell(
              onTap: () {
                Get.toNamed(PRODUCT_PAGE, arguments: product.id);
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: 1.sw,
                    height: 0.45.sw, // نفس العرض = الطول
                    child: Image.network(
                      "${product.image}",
                      fit: BoxFit.cover,
                    ),
                  ),
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
                          Icon(Icons.visibility, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "${product.views_count}".toFormatNumberK(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
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
              onTap: (){
                Get.offNamed(PRODUCTS_PAGE,parameters: {"id":"${product.user?.id}"});
              },
              child: Row(
                children: [
                  if (product.user?.is_verified == true)
                    Icon(Icons.verified, color: Colors.blue, size: 16),
                  if (product.user?.is_verified == true) SizedBox(width: 4),
                  AutoSizeText(
                    "${product.user?.seller_name}",
                    maxLines: 1,
                    style:H4RedTextStyle.copyWith(overflow: TextOverflow.ellipsis),
                  ),
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
                  width:0.1.sw,
                  height: 0.1.sw,
                  decoration: BoxDecoration(

                    color: Colors.red,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      mainController.addToCart(product: product);
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
                            style:H7GrayOpacityTextStyle,
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
                        style: H5BlackTextStyle.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                const SizedBox(width: 8),

                if (product.is_discount != true)
                  AutoSizeText(
                    "\$ ${product.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomAppBarSection extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final logic = Get.find<SectionLogic>();

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // AppBar الثاني - الأدوات
        Container(
          height: 60,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Obx(() {
                return ElevatedButton(
                  onPressed: () {
                    openFilterSheet(Get.context as BuildContext);
                    /* if (logic.orderBy.length == 2 &&
                        logic.orderBy[0] == 'created_at') {
                      logic.orderBy[1] =
                          logic.orderBy[1] == 'desc' ? 'asc' : 'desc';
                    }*/
                  },
                  child: logic.orderBy[1] == 'desc'
                      ? Icon(FontAwesomeIcons.arrowUpWideShort, size: 16)
                      : Icon(FontAwesomeIcons.arrowDownWideShort, size: 16),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(40, 40),
                  ),
                );
              }),

              SizedBox(width: 0.009.sw),
              // الأزرار
              SizedBox(
                width: 0.3.sw,
                child: Obx(() {
                  return PopupMenuButton<CityModel>(
                    onSelected: (CityModel city) {
                      logic.cityModel.value = city;
                    },
                    itemBuilder: (context) =>
                        logic.mainController.mainCities
                            .map((city) =>
                            PopupMenuItem<CityModel>(
                              value: city,
                              child: Text(city.name ?? 'Unknown City'),
                            ))
                            .toList(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.01.sw, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FontAwesomeIcons.locationDot,
                              color: Colors.white, size: 40.r),
                          Expanded(
                            child: Text(
                              logic.cityModel.value?.name ?? 'اختر المدينة',
                              style: TextStyle(
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down,
                              color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(width: 0.009.sw),
              // حقل البحث
              Expanded(
                child: Container(
                  height: 40,
                  child: TextField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    controller: logic.searchController,
                    onEditingComplete: () {
                      logic.search.value = logic.searchController.text;
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: 'البحث عن شيء محدد...',
                      hintTextDirection: TextDirection.rtl,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // AppBar الأول - التبويبات
        Container(
          height: 60,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // التبويب المحدد

              SizedBox(width: 0.01.sw),
              Obx(() {
                if (logic.category.value != null) {
                  return SizedBox(
                    width: 0.9.sw,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      children: [
                        ...List.generate(
                          logic.category.value!.children!.length,
                              (index) =>
                              _buildInactiveTab(
                                  category: logic.category.value!.children!
                                      .reversed
                                      .elementAt(index)),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              }),
              // التبويبات غير المحددة
            ],
          ),
        ),
      ],
    );
  }

  void openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          // مهم عشان نقدر نعمل setState داخل الـ BottomSheet
          builder: (context, setStateSheet) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("الفلترة",
                      style:H1BlackTextStyle),

                  SizedBox(height: 20),

                  // الاختيار بين الأحدث والأقدم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('حسب تاريخ النشر',style: H3RegularDark,),
                    ],
                  ),
                  Obx(() {
                    return Row(
                      children: [

                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("الأحدث"),
                            value: "desc",
                            groupValue: logic.sortOrder['created_at'],
                            onChanged: (val) {
                              setStateSheet(() {
                                logic.sortOrder['created_at'] = val!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("الأقدم"),
                            value: "asc",
                            groupValue: logic.sortOrder['created_at'],
                            onChanged: (val) {
                              setStateSheet(() {
                                logic.sortOrder['created_at'] = val!;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),

                  SizedBox(height: 20),
                  // الاختيار بين الأحدث والأقدم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('حسب السعر',style: H3RegularDark,),
                    ],
                  ),
                  Obx(() {
                    return Row(
                      children: [

                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("الأعلى"),
                            value: "desc",
                            groupValue: logic.sortOrder['price'],
                            onChanged: (val) {
                              logic.sortOrder['price'] = val!;
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("الأقل"),
                            value: "asc",
                            groupValue: logic.sortOrder['price'],
                            onChanged: (val) {
                              logic.sortOrder['price'] = val!;
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 20),

                  // اختيار المدى السعري
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "نطاق السعر: ${logic.priceRange.value.start
                                .round()} - ${logic
                                .priceRange.value.end.round()}",style: H3RegularDark,),
                      ],
                    );
                  }),
                  Obx(() {
                    return RangeSlider(
                      values: logic.priceRange.value,
                      min: 0,
                      max: 10000,
                      divisions: 40,
                      labels: RangeLabels(
                        logic.priceRange.value.start.round().toString(),
                        logic.priceRange.value.end.round().toString(),
                      ),
                      onChanged: (values) {
                        logic.priceRange.value = values;
                      },
                    );
                  }),

                  SizedBox(height: 20),

                  // زر التطبيق
                  ElevatedButton(
                    onPressed: () {
                      // اطبع القيم المختارة للتأكد
                      Logger().i(
                          "الترتيب حسب التاريخ: ${logic
                              .sortOrder['created_at']}");
                      Logger()
                          .i("الترتيب حسب السعر: ${logic.sortOrder['price']}");
                      Logger().i(
                          "نطاق السعر: ${logic.priceRange.value.start} - ${logic
                              .priceRange.value.end}");
                      logic.apllyFilters();
                      // اغلاق الـ BottomSheet
                      Get.back(); // أو Navigator.pop(context);
                    },
                    child: Text("تطبيق"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInactiveTab({required CategoryModel category}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.015.sw, vertical: 0.001.sh),
      child: InkWell(onTap: () {
        logic.categoryId.value = category.id;
      },
// ?
          child: Obx(() {
            return Stack(
              children: [
                Text(
                  "${category.name}",
                  style: logic.categoryId.value == category.id
                      ? H2BlackTextStyle
                      : H3GrayTextStyle,
                ),
                if (logic.categoryId.value == category.id)
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0.03.sh, // مقدار الإزاحة للأسفل
                    child: Container(
                      height: 0.003.sh,
                      color: Colors.black,
                    ),
                  ),
              ],
            );
          })),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}

// الاستخدام في Scaffold
