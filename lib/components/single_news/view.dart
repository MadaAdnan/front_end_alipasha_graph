import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import '../../models/product_model.dart';
import '../../routes/routes_url.dart';

class SingleNewsComponent extends StatelessWidget {
  SingleNewsComponent({Key? key, required this.post}) : super(key: key);

  final ProductModel post;

  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(vertical: 0.002.sh, horizontal: 0.002.sw),
      width: double.infinity,
      height: 1.sw + 0.177.sh,
      color: GrayLightColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 0.018.sw, vertical: 0.008.sh),
            width: double.infinity,
            color: WhiteColor,
            height: 0.12.sh,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(PRODUCTS_PAGE, arguments: post.user);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: GrayLightColor,
                            backgroundImage:
                                CachedNetworkImageProvider("${post.image}"),
                            minRadius: 0.018.sh,
                            maxRadius: 0.023.sh,
                          ),
                          10.horizontalSpace,
                          Container(
                            width: 0.6.sw,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${post.category?.name}",
                                    style: H3GrayTextStyle,
                                  ),
                                  TextSpan(
                                      text: " - ${post.sub1?.name}",
                                      style: H3GrayTextStyle),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                15.verticalSpace,
                Container(
                  width: 1.sw,
                  height: 0.044.sh,
                  child: Text(
                    "${post.expert}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: H3GrayTextStyle,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(PRODUCT_PAGE, arguments: post.id);
            },
            child: Container(
              width: 1.sw,
              height: 1.sw,
              decoration: BoxDecoration(
                color: GrayDarkColor,
                image: DecorationImage(
                    image: NetworkImage(
                      "${post.image}",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            height: 0.05.sh,
            alignment: Alignment.center,
            color: WhiteColor,
            padding:
                EdgeInsets.symmetric(horizontal: 0.001.sw, vertical: 0.005.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.calendar,
                        size: 0.05.sw,
                      ),
                      10.horizontalSpace,
                      Text(
                        '${post.created_at}',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.comment,
                        size: 0.05.sw,
                      ),
                      10.horizontalSpace,
                      Text(
                        'تعليق',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.share,
                        size: 0.05.sw,
                      ),
                      10.horizontalSpace,
                      Text(
                        'مشاركة',
                        style: H4BlackTextStyle,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
