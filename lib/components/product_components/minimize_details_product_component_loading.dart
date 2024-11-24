
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shimmer/shimmer.dart';

class MinimizeDetailsProductComponentLoading extends StatelessWidget {
  MinimizeDetailsProductComponentLoading({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(

          child: Shimmer(gradient: LinearGradient(colors: [GrayWhiteColor,GrayLightColor,GrayWhiteColor]), child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              color: GrayLightColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Shimmer(gradient: LinearGradient(colors: [GrayDarkColor,GrayWhiteColor]),enabled: true,loop: 5,child:  Container(
                  width: 0.3.sw,
                  height: 0.3.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r)),
                  ),
                ),),
                Expanded(
                    child: Container(
                      height: 0.3.sw,
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.01.sw, vertical: 0.002.sh),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(baseColor:GrayDarkColor , highlightColor:GrayWhiteColor,child: Text(' '), ),
                          Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child:RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ' ',
                                    style: H5GrayTextStyle),
                              ]))),

                          Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child:  Text(
                            " ",
                            style: H4RegularDark,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),

                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Expanded(
                            child: Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child:RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ' ',
                                    style: H4RedTextStyle,
                                  ),

                                ],
                              ),
                            )),

                          ),
                          Container(
                            height: 0.06.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icon Eye
                                Row(
                                  children: [


                                    SizedBox(
                                      width: 0.007.sw,
                                    ),
                                    Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child: Text(
                                      "test ",
                                      style: H5BlackTextStyle,
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child: Icon(
                                      FontAwesomeIcons.calendar,
                                      color: DarkColor,
                                      size: 0.04.sw,
                                    )),

                                    SizedBox(
                                      width: 0.007.sw,
                                    ),
                                    Shimmer.fromColors(baseColor: GrayLightColor, highlightColor: GrayWhiteColor, child: Text(
                                      " ",
                                      style: H5BlackTextStyle,
                                    )),

                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )),
        ),
        SizedBox(height: 0.01.sh),
      ],
    );
  }
}
