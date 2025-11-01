import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../routes/routes_url.dart';

class SliderProduct extends StatelessWidget {
  SliderProduct({super.key, this.title, this.products});

  final String? title;
  final List<ProductModel?>? products;
  MainController mainController = Get.find<MainController>();
  ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    Logger().w('LENGTH PRO');
    Logger().w(products!.length);
    return Container(
      height: 0.5.sh,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title",
            style: H2RegularDark,
          ),

            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
            child: Row(
              children: [
               ... products!.map((el) => _ProductCard(product: el!))
              ],
            ),
            )
        ],
      ),
    );
  }

  _ProductCard({required ProductModel product}) {
    return Container(
      height: 1.sh,
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
                            style: H7GrayOpacityTextStyle,
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
