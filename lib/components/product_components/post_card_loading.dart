
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:shimmer/shimmer.dart';

import '../../helpers/colors.dart';


class PostCardLoading extends StatelessWidget {
  PostCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 0.002.sw),
      width: double.infinity,
      height: 1.sw + 0.187.sh,
      decoration: BoxDecoration(
          color: WhiteColor,
          border: Border(
              bottom: BorderSide(color: GrayLightColor, width: 0.01.sh))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child:  Container(
           padding:
           EdgeInsets.symmetric(horizontal: 0.018.sw, vertical: 0.008.sh),
           width: double.infinity,
           decoration: BoxDecoration(color: WhiteColor),
           height: 0.12.sh,
           child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   InkWell(
                     child: Row(
                       children: [
                         Container(
                           width: 0.07.sw,
                           height: 0.07.sw,
                           decoration: BoxDecoration(
                               shape: BoxShape.circle, color: GrayLightColor),
                         ),
                         10.horizontalSpace,
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                                 width: 0.6.sw,
                                 height: 0.006.sh,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10.r),
                                     color: GrayLightColor)),

                             Container(
                               width: 0.6.sw,
                               child: Container(
                                   width: 0.6.sw,
                                   height: 0.006.sh,
                                   decoration: BoxDecoration(
                                       borderRadius:
                                       BorderRadius.circular(10.r),
                                       color: GrayLightColor)),
                             )
                           ],
                         )
                       ],
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.symmetric(
                         horizontal: 0.03.sw, vertical:0.03.sw),
                     decoration: BoxDecoration(
                         color: GrayLightColor,
                         borderRadius: BorderRadius.circular(15.r),
                         border: Border.all(color: GrayLightColor)),

                   )

                 ],
               ),
               15.verticalSpace,
               Container(
                 width: 1.sw,
                 height: 0.044.sh,
                 child: Container(

                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: GrayLightColor)
                 ),
               )
             ],
           ),
         )),
          Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child:   Container(
            width: 1.sw,
            height: 1.sw,
            decoration: BoxDecoration(
              color: GrayWhiteColor,
            ),
            child: Stack(
              children: [



                Positioned(
                  bottom: 20.h,
                  right: 10.w,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: GrayLightColor,
                            borderRadius: BorderRadius.circular(15.r)),
                        height: 90.h,
                        width: 280.w,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                            width: 0.6.sw,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: GrayLightColor)
                        ),
                      ),
                      40.horizontalSpace,
                      Container(
                          width: 0.1.sw,
                          height: 0.09.sw,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: GrayLightColor)
                      ),
                    ],
                  ),
                ),

              ],
            ),
          )),
          Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child:      Container(
            height: 0.05.sh,
            alignment: Alignment.center,
            color: WhiteColor,
            padding:
            EdgeInsets.symmetric(horizontal: 0.001.sw, vertical: 0.005.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 0.09.sw,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: GrayLightColor)
                ),
                Container(
                    width: 0.09.sw,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: GrayLightColor)
                ),
                Container(
                    width: 0.09.sw,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: GrayLightColor)
                ),
                Container(
                    width: 0.09.sw,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: GrayLightColor)
                ),
              ],
            ),
          )),


        ],
      ),
    );
  }


}
