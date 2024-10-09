import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/sections_components/section_home_card.dart';
import 'logic.dart';

class SectionsPage extends StatelessWidget {
  SectionsPage({Key? key}) : super(key: key);

  final logic = Get.find<SectionsLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 0.02.sh),
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.06.sh,
            color: RedColor,
            child: Text(
              'جميع التصنيفات',
              style: H2WhiteTextStyle,
            ),
          ),
          Obx(() {
            if (logic.loading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              width: 1.sw,
              height: 0.82.sh,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 0.002.sw,
                  spacing: 0.03.sw,
                  children: [
                    ...List.generate(
                      logic.categories.length,
                      (index) => InkWell(
                        onTap: () {
                          Get.toNamed(SECTION_PAGE,
                              arguments: logic.categories[index].id);
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.02.sh),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: 0.3.sw,
                                    height: 0.3.sw,
                                    decoration: BoxDecoration(
                                      color: logic.categories[index].color
                                          ?.toColor(),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                "${logic.categories[index].img}")),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 0.3.sw,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${logic.categories[index].name}",
                                      style: H3RegularDark,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              child: Badge(
                                backgroundColor: RedColor,
                                isLabelVisible: true,
                                label: Text(
                                    "${logic.categories[index].productsCount!}"
                                        .toFormatNumberK(),style: H5WhiteTextStyle,textDirection: TextDirection.ltr,),
                              ),

                              top: 9,
                              left: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  _buildSection() {}
}
