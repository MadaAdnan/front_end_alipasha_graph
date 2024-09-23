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

class MinimizeDetailsProductComponentLoading extends StatelessWidget {
  MinimizeDetailsProductComponentLoading({
    super.key,

  });




  @override
  Widget build(BuildContext context) {
    return InkWell(

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
                    image: AssetImage("assets/images/png/user.png"),
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
                        TextSpan(text: 'seller ',style: H4RedTextStyle),
                        TextSpan(text: '(سرمدا )',style: H4GrayTextStyle),
                      ]),
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.6.sw,
                    child: Text(
                      'منتج',
                      style: H2BlackTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  10.verticalSpace,
                  Expanded(
                    child: Container(
                      width: 0.6.sw,
                      child: Text(
                        'وصف المنشور',
                        style: H4GrayTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  10.verticalSpace,

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
                                  text: "1", style: H4GrayTextStyle),
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
                                '10k',
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
