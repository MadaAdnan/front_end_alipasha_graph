import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';

class SellerHomePageCard extends StatelessWidget {
  const SellerHomePageCard({super.key, this.seller});

  final UserModel? seller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Get.toNamed(PRODUCTS_PAGE, arguments: seller);
      },
      child: Container(
        width: 0.27.sw,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: GrayLightColor,
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
                image: NetworkImage('${seller?.customImg}'),
                fit: BoxFit.fill,
                opacity: 0.7)),
        child: Container(
          padding: EdgeInsets.only(top: 20.h, right: 20.w),
          alignment: Alignment.topRight,
          child: CircleAvatar(
            backgroundColor: WhiteColor,
            radius: 40.r,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: DarkColor,
                        blurRadius: 10.r,
                        blurStyle: BlurStyle.outer),
                    BoxShadow(color: GrayDarkColor, blurRadius: 5.r),
                  ],
                  color: GrayLightColor,
                  borderRadius: BorderRadius.circular(150.r),
                  image:
                      DecorationImage(image: NetworkImage('${seller?.logo}'))),
            ),
          ),
        ),
      ),
    );
  }
}
