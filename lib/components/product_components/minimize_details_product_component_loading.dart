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
import 'package:shimmer/shimmer.dart';

class MinimizeDetailsProductComponentLoading extends StatelessWidget {
  MinimizeDetailsProductComponentLoading({
    super.key,

  });




  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: GrayDarkColor,
                  width: 0.004.sh))),
      padding: EdgeInsets.symmetric(vertical: 0.002.sh),
      width: 1.sw,
      height: 0.2.sh,
      child: Row(
        children: [
          Shimmer.fromColors(child: Container(
            width: 0.4.sw,
            height: 0.2.sh,
            decoration: BoxDecoration(
              color: GrayLightColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
          ), baseColor: GrayLightColor, highlightColor: GrayWhiteColor),
          30.horizontalSpace,
         Container(child:  Column(
           children: [
             Shimmer.fromColors(child:  Container(
               decoration: BoxDecoration(
                 color: GrayLightColor,
                 borderRadius: BorderRadius.circular(30.r),
               ),
               width: 0.5.sw,
               height: 0.02.sh,
             ), baseColor: GrayLightColor, highlightColor: GrayWhiteColor),

             20.verticalSpace,
             Shimmer.fromColors(child:  Container(
               decoration: BoxDecoration(
                 color: GrayLightColor,
                 borderRadius: BorderRadius.circular(30.r),
               ),
               width: 0.5.sw,
               height: 0.02.sh,
             ), baseColor: GrayLightColor, highlightColor: GrayWhiteColor),

             20.verticalSpace,
             Shimmer.fromColors(child:   Container(
               decoration: BoxDecoration(
                 color: GrayLightColor,
                 borderRadius: BorderRadius.circular(30.r),
               ),
               width: 0.5.sw,
               height: 0.02.sh,
             ), baseColor: GrayLightColor, highlightColor: GrayWhiteColor),

             20.verticalSpace,
             Shimmer.fromColors(child:   Container(
               decoration: BoxDecoration(
                 color: GrayLightColor,
                 borderRadius: BorderRadius.circular(30.r),
               ),
               width: 0.5.sw,
               height: 0.02.sh,
             ), baseColor: GrayLightColor, highlightColor: GrayWhiteColor),

           ],
         ),padding: EdgeInsets.only(top:0.02.sh),)
        ],
      ),
    );
  }
}
