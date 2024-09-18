import 'dart:math';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/mini_post_card.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/pages/product/logic.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../components/product_components/minimize_details_product_component.dart';

class ProductDetailes extends StatelessWidget {
  ProductDetailes({super.key, this.product, required this.products});

  final ProductModel? product;
  final List<ProductModel> products;
  MainController mainController = Get.find<MainController>();
  ProductLogic logic = Get.find<ProductLogic>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.003.sh),
            alignment: Alignment.centerRight,
            child: Text(
              "الوصف:",
              style: H3RedTextStyle,
            ),
          ),
          10.verticalSpace,
          Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(vertical: 0.003.sh),
            padding:
                EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
            decoration: BoxDecoration(
              color: GrayWhiteColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Text(
              "${product?.info}",
              style: H2BlackTextStyle,
              overflow: TextOverflow.visible,
            ),
          ),
          if (product?.type == 'product')
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.003.sh),
              padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'السعر بالدولار:',
                    style: H3RedTextStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        '${product?.is_discount == true ? product?.discount : product?.price}',
                        style: H3BlackTextStyle,
                      ),
                      10.horizontalSpace,
                      Icon(FontAwesomeIcons.dollarSign, size: 0.03.sw)
                    ],
                  ),
                ],
              ),
            ),
          if (product?.type == 'product')
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.003.sh),
              padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'السعر بالليرة:',
                    style: H3RedTextStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        '${product?.is_discount == true ? product?.turkey_price?.discount : product?.turkey_price?.price}',
                        style: H3BlackTextStyle,
                      ),
                      10.horizontalSpace,
                      Icon(
                        FontAwesomeIcons.liraSign,
                        size: 0.03.sw,
                      )
                    ],
                  ),
                ],
              ),
            ),
          if (product?.type == 'tender' ||
              product?.type == 'job' ||
              product?.type == 'search_job')
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.003.sh),
              padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تاريخ بداية التقديم:',
                    style: H3RedTextStyle,
                  ),
                  Text(
                    '${product?.start_date}',
                    style: H3BlackTextStyle,
                  ),
                ],
              ),
            ),
          if (product?.type == 'tender' ||
              product?.type == 'job' ||
              product?.type == 'search_job')
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.003.sh),
              padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تاريخ نهاية التقديم:',
                    style: H3RedTextStyle,
                  ),
                  Text(
                    '${product?.end_date}',
                    style: H3BlackTextStyle,
                  ),
                ],
              ),
            ),
          if ((product?.type == 'tender' ||
                  product?.type == 'job' ||
                  product?.type == 'search_job') &&
              product?.code?.length != 0)
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.003.sh),
              padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'كود الوظيفة:',
                    style: H3RedTextStyle,
                  ),
                  Text(
                    '${product?.code}',
                    style: H3BlackTextStyle,
                  ),
                ],
              ),
            ),
          if ((product?.type == 'tender' ||
                  product?.type == 'job' ||
                  product?.type == 'search_job') &&
              product?.phone?.length != 0)
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.003.sh),
              padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'رقم الهاتف:',
                    style: H3RedTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      openUrl(url: "https://wa.me/${product?.phone}");
                    },
                    child: Text(
                      '${product?.phone}',
                      style: H3BlackTextStyle.copyWith(
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          if ((product?.type == 'tender' ||
                  product?.type == 'job' ||
                  product?.type == 'search_job') &&
              product?.email?.length != 0)
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.003.sh),
              padding:
                  EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: GrayWhiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'البريد الإلكتروني:',
                    style: H3RedTextStyle,
                  ),
                  InkWell(
                    onTap: () {
                      openUrl(url: "mailto:${product?.email}");
                    },
                    child: Text(
                      '${product?.email}',
                      style: H3BlackTextStyle.copyWith(
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 0.4.sw,
                    margin: EdgeInsets.symmetric(vertical: 0.003.sh),
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.03.sw, vertical: 0.01.sh),
                    decoration: BoxDecoration(
                      color: GrayWhiteColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المدينة :',
                          style: H3RedTextStyle,
                        ),
                        Text(
                          '${product?.city?.name}',
                          style: H3BlackTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.4.sw,
                    margin: EdgeInsets.symmetric(vertical: 0.003.sh),
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.03.sw, vertical: 0.01.sh),
                    decoration: BoxDecoration(
                      color: GrayWhiteColor,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الحالة:',
                          style: H3RedTextStyle,
                        ),
                        Text(
                          '${product?.level}'.toLevelProduct(),
                          style: H3BlackTextStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: 0.5.sw,
                margin: EdgeInsets.symmetric(vertical: 0.003.sh),
                padding: EdgeInsets.symmetric(
                    horizontal: 0.03.sw, vertical: 0.025.sh),
                decoration: BoxDecoration(
                  color: GrayWhiteColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تاريخ الإضافة',
                      style: H3RedTextStyle,
                    ),
                    Text(
                      '${product?.created_at}',
                      style: H3BlackTextStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
          if (product?.colors != null && product!.colors!.length > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
              width: 1.sw,
              child: Text(
                'الألوان:',
                style: H3RedTextStyle,
              ),
            ),
          if (product?.colors != null && product!.colors!.length > 0)
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(vertical: 0.02.sh),
              width: 1.sw,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: [
                  ...List.generate(product!.colors!.length, (i) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 0.01.sw, horizontal: 0.01.sw),
                      width: 0.05.sw,
                      height: 0.05.sw,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: "${product?.colors?[i].code}".toColor(),
                          boxShadow: [
                            BoxShadow(color: DarkColor, blurRadius: 0.005.sw)
                          ]),
                    );
                  })
                ],
              ),
            ),
          if (product?.docs.length != 0)
            Wrap(
              spacing: 6,
              children: [
                ...List.generate(
                    product!.docs.length,
                    (i) => InkWell(
                          onTap: () {
                            openUrl(url: "${product!.docs[i]}");
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 0.003.sh),
                            alignment: Alignment.center,
                            width: 0.3.sw,
                            decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(15.r)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.03.sw, vertical: 0.01.sh),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'مرفق (${i + 1})',
                                  style: H4WhiteTextStyle,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidFile,
                                  size: 0.04.sw,
                                  color: WhiteColor,
                                )
                              ],
                            ),
                          ),
                        ))
              ],
            ),
          Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: OrangeColor))),
            child: Text(
              'منشورات ذات صلة',
              style: H4BlackTextStyle,
            ),
          ),
          ...List.generate(
              products.length, (i) => MinimizeDetailsProductComponent(post: products[i])),
         150.verticalSpace,
        ],
      ),
    );
  }

  _buildCard({required ProductModel post}) {
    return InkWell(
      onTap: () {
        logic.productId.value = post.id;
        // Get.back();
        // Get.toNamed(PRODUCT_PAGE, arguments: post.id);
      },
      child: Container(
        margin: EdgeInsets.only(top: 0.01.sh),
        width: 1.sw,
        decoration: BoxDecoration(
            color: WhiteColor,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: GrayDarkColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              padding:
                  EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.004.sh),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: GrayDarkColor,
                ),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "معرف المنتج : ", style: H4BlackTextStyle),
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
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.003.sh, horizontal: 0.01.sw),
                  width: 0.4.sw,
                  height: 0.15.sh,
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

                            decoration: BoxDecoration(
                                color: DarkColor.withOpacity(0.6)),
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
                  width: 0.55.sw,
                  child: Column(

                    children: [
                      Container(
                        child: Text(
                          "${post.user?.seller_name}",
                          style: H3OrangeTextStyle,
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      30.verticalSpace,
                     Container(
                       child:  Text(
                         "${post.expert}",
                         style: H3BlackTextStyle,
                         overflow: TextOverflow.ellipsis,
                         maxLines: 3,
                       ),
                       alignment: Alignment.centerRight,
                     ),
                      50.verticalSpace,
                      Container(
                        child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.cartShopping,size: 0.04.sw,)),
                        alignment: Alignment.bottomLeft,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (post.active != '')
                            Container(
                              width: 0.2.sw,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: post.active!.active2Color(),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
            ),

          ],
        ),
      ),
    );
  }
}
