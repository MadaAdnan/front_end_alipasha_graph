import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../helpers/style.dart';

class SellerNameComponent extends StatelessWidget {
  SellerNameComponent({super.key,
    this.textStyle,
    required this.sellerName,
    required this.isVerified,
    this.white,
    this.color,this.alignment=MainAxisAlignment.start});

  MainController mainController = Get.find<MainController>();
  final TextStyle? textStyle;
  final String sellerName;
  final bool isVerified;
  final bool? white;
  final Color? color;
  final MainAxisAlignment alignment;



  @override
  Widget build(BuildContext context) {


      return  Row(
        mainAxisAlignment: alignment,
          children: [
            Flexible(child: Text(
              "${sellerName}",
              style: textStyle ??
                  H1RedTextStyle.copyWith(

                    color: color ??
                        "${mainController.authUser.value?.id_color}"
                            .toColor(),
                  ),
              overflow: TextOverflow.ellipsis,
            ),),
            if ((isVerified == true))
              Container(
                width: 0.04.sw,
                height: 0.04.sw,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Svg(
                          white != true
                              ? "assets/images/svg/verified.svg"
                              : "assets/images/svg/verified_white.svg",
                          size: Size(0.04.sw, 0.04.sw),
                        ))),
              ),
          ],
        );

  }
}
