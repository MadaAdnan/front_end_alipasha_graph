import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MinimizeDetailsProductComponent extends StatelessWidget {
  MinimizeDetailsProductComponent({
    super.key,
    required this.post,
    this.onClick,
  });

  final ProductModel post;
  final Function()? onClick;
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: GrayDarkColor, width: 0.004.sh))),
        padding: EdgeInsets.symmetric(vertical: 0.002.sh),
        width: 1.sw,
        child: Row(
          children: [
            // image
            Container(
              width: 0.35.sw,
              height: 0.35.sw,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider("${post.image}"),
                    fit: BoxFit.cover),
              ),
            ),
            10.horizontalSpace,
            Container(
              height: 0.35.sw,
              width: 0.6.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0.002.sh),
                    width: 0.6.sw,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: '${post.user?.seller_name} ',style: H4RedTextStyle),
                        TextSpan(text: '(${post.city?.name} )',style: H4GrayTextStyle),
                      ]),
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.6.sw,
                    child: Text(
                      '${post.name}',
                      style: H2BlackTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  10.verticalSpace,
                  Expanded(
                    child: Container(
                      width: 0.6.sw,
                      child: Text(
                        '${post.expert}',
                        style: H4GrayTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  if (post.type == 'product')
                    Container(
                      width: 0.6.sw,
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "${post.price} \$",
                              style: H3OrangeTextStyle,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                mainController.addToCart(product: post);
                              },
                              icon: Icon(
                                FontAwesomeIcons.cartPlus,
                                color: RedColor,
                                size: 0.06.sw,
                              ))
                        ],
                      ),
                    ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: 0.6.sw,
                    padding: EdgeInsets.symmetric(vertical: 0.002.sh),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(color: GrayDarkColor),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: " معرف المنشور: ",
                                  style: H4GrayTextStyle),
                              TextSpan(
                                  text: "${post.id}", style: H4GrayTextStyle),
                            ]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0.02.sw),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.eye,
                                size: 0.04.sw,
                                color: GrayDarkColor,
                              ),
                              5.horizontalSpace,
                              Text(
                                '${post.views_count}',
                                style: H4GrayTextStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
