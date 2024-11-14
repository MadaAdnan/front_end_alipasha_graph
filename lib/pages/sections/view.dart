import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/home_app_bar/view.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
          HomeAppBarComponent(),
          Obx(() {
            if (logic.loading.value && logic.categories.length==0) {
              return Expanded(child: Container(
                width: 0.5.sw,
                height: 0.5.sw,
                child: Center(
                  child: ProgressLoading(),
                ),
              ),);
            }
            return Container(
              width: 1.sw,
              height: 0.79.sh,
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
                        onTap: () async{
                         await logic.visit(logic.categories[index].id!,logic.categories[index].productsCount!);
                         if(logic.categories[index].type =='restaurant'){
                           Get.toNamed(RESTAURANT_PAGE,
                               arguments: logic.categories[index].id);
                         }else{
                           Get.toNamed(SECTION_PAGE,
                               arguments: logic.categories[index].id);
                         }

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
                              top: 9,
                              left: 0,
                              child: Badge(
                                backgroundColor:!logic.isVisit(logic.categories[index].id!,logic.categories[index].productsCount!)? RedColor:GrayDarkColor,
                                isLabelVisible: true,
                                label: Text(
                                    "${logic.categories[index].productsCount!}"
                                        .toFormatNumberK(),style: H4WhiteTextStyle,textDirection: TextDirection.ltr,),
                              ),
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
