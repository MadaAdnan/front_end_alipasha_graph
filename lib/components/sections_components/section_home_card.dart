import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/style.dart';

class SectionHomeCard extends StatelessWidget {
  const SectionHomeCard({super.key, this.section});

  final CategoryModel? section;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(SECTION_PAGE, arguments: section?.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.001.sw),
        height: 0.096.sh,
        width: 0.185.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 0.0059.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(0.02.sw),
              height: 0.150.sw,
              width: 0.150.sw,
              decoration: BoxDecoration(
                color:"${section?.color}".toColor(),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                        image: NetworkImage("${section?.img}"))),
              ),
            ),
            Text(
              "${section?.name}",
              overflow: TextOverflow.ellipsis,
              style: H4BlackTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
