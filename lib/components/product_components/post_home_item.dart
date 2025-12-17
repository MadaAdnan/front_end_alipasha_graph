import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:expanded_text_custom/expanded_text_custom.dart';
import 'package:share_plus/share_plus.dart';
import '../../Global/main_controller.dart';
import '../../helpers/components.dart';
import '../../models/product_model.dart';
import '../../pages/home/logic.dart';
import 'package:dio/dio.dart' as dio;

import '../../routes/routes_url.dart';

class PostHomeItem extends StatelessWidget {
  PostHomeItem({super.key, required this.post});

  final ProductModel post;
  RxBool is_like = RxBool(false);
  RxBool is_whatsapp = RxBool(false);
  RxBool plusOneLike = RxBool(false);
  RxBool allowLike = RxBool(true);

  RxBool loading = RxBool(false);
  RxBool loadingCommunity = RxBool(false);
  MainController mainController = Get.find<MainController>();

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(PRODUCT_PAGE, arguments: post.id,preventDuplicates: false);
        },
        child: Container(
          width: 0.92.sw,
          margin: EdgeInsets.symmetric(vertical: 0.01.sh),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ScafoldColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: CachedNetworkImageProvider(
                        '${post.user?.image}',
                      ),
                    ),
                    SizedBox(width: 12),
                    // Name and Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${post.user?.seller_name ?? post.user?.name}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              if (post.user?.is_verified == true)
                                Icon(
                                  Icons.verified,
                                  color: Color(0xFF1DA1F2),
                                  size: 18,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Follow Button
                    Obx(() {
                      if (mainController.authUser.value?.id != null &&
                          post.user?.id != null &&
                          mainController.authUser.value!.id != post.user!.id) {
                        // Check Is Follower
                        if (mainController.authUser.value!.followers != null) {
                          int index = mainController.authUser.value!.followers!
                              .indexWhere(
                            (el) => el.seller?.id == post.user?.id,
                          );

                          if (index > -1) {
                            return Container(
                              height: 36,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFF3B30),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'اتابعه',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.bell,
                                    color: Colors.white,
                                    size: 30.r,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return InkWell(
                                onTap: () async {
                                  if (loading.value == false) {
                                    loading.value = true;
                                    await mainController.follow(
                                        sellerId: post.user!.id!);
                                    loading.value = false;
                                  }
                                },
                                child: Container(
                                  height: 36,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: loading.value
                                        ? Color(0xFFFF3B30)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: Color(0xFFFF3B30),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'متابعة',
                                        style: TextStyle(
                                          color: loading.value
                                              ? Colors.white
                                              : Color(0xFFFF3B30),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.bell,
                                        color: loading.value
                                            ? Colors.white
                                            : Color(0xFFFF3B30),
                                        size: 30.r,
                                      )
                                    ],
                                  ),
                                ));
                          }
                        }
                      }
                      return Container();
                    }),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Row(
                  children: [
                    Flexible(
                        child: _buildBadge('${post.user?.city?.name}',
                            Icons.location_on_outlined, () {

                      HomeLogic logic = Get.find<HomeLogic>();
                      logic.cityHome.value = post.user?.city?.id;
                    })),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Flexible(
                        child: _buildBadge('${post.category?.name}',
                            FontAwesomeIcons.layerGroup, () {

                      HomeLogic logic = Get.find<HomeLogic>();
                      logic.categoryHome.value = post.category?.id;
                    })),
                  ],
                ),
              ),
              // Time and Views
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${post.created_at}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${post.views_count}'.toFormatNumberK(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.visibility_outlined,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              // Food Image
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 300 / 325,
                        child: Image.network(
                          '${post.image}',
                          width: double.infinity,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (post.level == 'special')
                        Positioned(
                            top: 0.007.sh,
                            left: 0.02.sw,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFCC00),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'ممول',
                                    style: H5WhiteTextStyle,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.star,
                                    color: Colors.white,
                                    size: 30.r,
                                  ),
                                ],
                              ),
                            ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Price and Order Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${post.name}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Price
                    Row(
                      children: [
                        Text(
                          '\$ ${post.is_discount == true ? post.discount : post.price}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 8),
                        if (post.is_discount == true)
                          Text(
                            '\$${post.price}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),

                    // Title

                    SizedBox(width: 8),
                    // Cart Button
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF3B30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              // Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ExpandableTextCustom(
                    maxLines: 1,
                    content: '${post.expert}',
                    showMore: true,
                    textExpandStyle: H4OrangeTextStyle,
                    textMore: "عرض المزيد",
                    textLess: "عرض أقل"),
              ),
              SizedBox(height: 16),
              // Action Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Like Button
                    Obx(() => GestureDetector(
                          onTap: () async {
                            is_like.value = !is_like.value;
                            await like();
                          },
                          child: Row(
                            children: [
                              Icon(
                                is_like.value || post.is_like == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: post.is_like == true
                                    ? Color(0xFFFF3B30)
                                    : Colors.grey[600],
                                size: 20,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '${plusOneLike.value == true ? post.likes_count! + 1 : post.likes_count}'
                                    .toFormatNumberK(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(width: 24),
                    // Comment Button
                    InkWell(
                        onTap: () {
                          if (isAuth()) {
                            Get.toNamed(COMMENTS_PAGE,
                                parameters: {"id": "${post.id}"});
                          } else {
                            Get.toNamed(LOGIN_PAGE);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'تعليق',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        )),
                    SizedBox(width: 24),
                    // Share Button
                    InkWell(
                        onTap: () {
                          Share.share(
                              "https://web.ali-pasha.com/posts/${post.id}");
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'مشاركة',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        )),
                    Spacer(),
                    // Message Button
                    InkWell(
                        onTap: () {
                          Get.dialog(AlertDialog(
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'مراسلة التاجر',
                                  style: H4RegularDark,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 40.r,
                                    ))
                              ],
                            ),
                            backgroundColor: WhiteColor,
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MaterialButton(
                                  onPressed: () async{
                                    if(is_whatsapp.value){
                                      return;
                                    }
                                    is_whatsapp.value=true;
                                    StringBuffer message = StringBuffer();
                                    message.writeln(
                                        "${mainController.settings.value
                                            .footerOrder}");
                                    message.write("\n");
                                    message.write(
                                        "السلام عليكم ورحمة الله وبركاته ");
                                    message.write("\n");
                                    message.write("اريد الإستفسار عن بضاعة");
                                    message.write("\n");
                                    message.write(
                                        "معرف المنتج : ${post.id}");
                                    message.write("\n");
                                    message.write(
                                        "المنتج :${post.name} ");
                                    message.write("\n");
                                    message.write(
                                        "سعر الوحدة : ${post.is_discount == true ? post.discount :post.price}");
                                    message.write("\n");

                                    await mainController.clickWhatsApp(
                                        productId: post.id!);


                                    Get.back();
                                    is_whatsapp.value=false;
                                    openUrl(
                                        url:
                                        "https://wa.me/${post.user?.full_phone}?text=${Uri
                                            .encodeComponent(
                                            '${message!.toString()}')}");
                                  },
                                  child: Text(
                                    'مراسلة واتسآب',
                                    style: H4WhiteTextStyle,
                                  ),
                                  color: Colors.green,
                                ),
                                Spacer(),
                                MaterialButton(
                                  onPressed: () {
                                    if (isAuth()) {
                                      mainController.createCommunity(
                                          sellerId: post.user!.id!);
                                    } else {
                                      Get.offAllNamed(LOGIN_PAGE);
                                    }
                                  },
                                  child: Text(
                                    'مراسلة شات',
                                    style: H4WhiteTextStyle,
                                  ),
                                  color: PrimaryColor,
                                ),
                              ],
                            ),
                          ));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.green[600],
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'مراسلة',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ));
  }

  Widget _buildBadge(String text, IconData icon, [Callback? click]) {
    return InkWell(
        onTap: click,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: AutoSizeText(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 0.007.sw,
              ),
              Icon(
                icon,
                size: 12,
                color: Colors.grey[600],
              ),
            ],
          ),
        ));
  }

  Future<void> like() async {
    if (allowLike.value) {
      if (!is_like.value) {
        plusOneLike.value = true;
      }
      allowLike.value = false;
      mainController.query.value = '''
    mutation AddLike{
addLike(product_id:"${post.id}"){
    id
            name
            weight
            expert
            type
            is_discount
            is_delivery
            is_available
            price
            views_count
            comments_count
            discount
            end_date
            type
            is_like
            likes_count
            level
            image
            video
            created_at
            user {
              id
              name
              id_color
              phone
              full_phone
              seller_name
              image
              logo
              is_verified
              city{
                id
                  name
                is_delivery
                code_city
                level  
              }
              area{
               id
               name
                is_delivery
                code_city
                level
               
              }
            }
          
            city {
            id
            name
               
            }
            start_date
              sub1 {
                name
            }
            category {
                name
            }
            colors {
                code
                name
            }
}
}
    
    ''';
      try {
        dio.Response? res = await mainController.fetchData();

        if (res?.data?['data']?['addLike'] != null) {
          ProductModel product =
              ProductModel.fromJson(res?.data?['data']?['addLike']);
          int index = Get.find<HomeLogic>()
              .products
              .indexWhere((el) => el.id == product.id);
          is_like.value = product.is_like!;
          if (index > -1) {
            Get.find<HomeLogic>().products[index] = product;
          }
        }
      } catch (e) {}
      plusOneLike.value = false;
      Future.delayed(
        Duration(seconds: 10),
        () {
          allowLike.value = true;
        },
      );
    }
  }
}
