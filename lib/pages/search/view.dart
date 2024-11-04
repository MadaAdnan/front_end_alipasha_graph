import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import '../../models/product_model.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final logic = Get.find<SearchLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !mainController.loading.value &&
              logic.hasMorePage.value) {
            logic.nextPage();
          }

          if (scrollInfo is ScrollUpdateNotification) {
            if (scrollInfo.metrics.pixels >
                scrollInfo.metrics.minScrollExtent) {
              mainController.is_show_home_appbar(false);
            } else {
              mainController.is_show_home_appbar(true);
            }
          }
          return true;
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 1.sw,
              height: 0.06.sh,
              decoration: BoxDecoration(
                border:Border(bottom: BorderSide(color: DarkColor))
              ),
              child: Text(
                'نتائج البحث',
                style: H2RedTextStyle,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 0.01.sw,vertical: 0.02.sh),
                child: Obx(() {
                  return Column(
                    children: [

                      ...List.generate(logic.products.length, (index) {
                        switch(logic.products[index].type) {
                          case "product":
                            return MinimizeDetailsProductComponent(
                              TitleColor: DarkColor,
                                onClick: (){
                                Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                                },
                                post: logic.products[index]);
                          case 'job':
                          case 'search_job':
                          case 'tender':
                            return MinimizeDetailsJobComponent(
                                TitleColor: DarkColor,
                                onClick: (){
                                  Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                                },
                                post: logic.products[index]);
                          case 'service':
                           return MinimizeDetailsServiceComponent( TitleColor: DarkColor,
                                onClick: (){
                                  Get.toNamed(PRODUCT_PAGE,arguments:logic.products[index].id );
                                },
                                post: logic.products[index]);
                          default:
                          return  _buildCard(post: logic.products[index]);
                        }
                      }),
                      if (logic.loading.value&& logic.page.value==1)
                        Container( width: 0.33.sw,child: ProgressLoading()),
                      if(logic.loading.value && logic.page.value>1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(child: Container(height: 0.06.sh,child: ProgressLoading())),
                            Flexible(child: Text('جاري جلب المزيد',style: H4GrayTextStyle,))
                          ],
                        ),
                      if (!logic.hasMorePage.value&& !logic.loading.value)
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'لا يوجد مزيد من النتائج',
                            style: H3GrayTextStyle,
                          ),
                        )),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCard({required ProductModel post}) {
    return InkWell(
      onTap: () {
        Get.toNamed(PRODUCT_PAGE, arguments: post.id);
      },
      child: Container(
        margin: EdgeInsets.only(top: 0.01.sh),
        width: 1.sw,
        height: 0.19.sh,
        decoration: BoxDecoration(
            color: WhiteColor,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: GrayDarkColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.004.sh),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: GrayDarkColor,
                ),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "معرف المنتج : ", style: H4BlackTextStyle),
                        TextSpan(text: "${post.id}", style: H4RedTextStyle),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.eye,
                        size: 0.04.sw,
                      ),
                      10.horizontalSpace,
                      Text(
                        "${post.views_count}",
                        style: H4RedTextStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.003.sh, horizontal: 0.01.sw),
                  width: 0.4.sw,
                  height: 0.15.sh,
                  child: Stack(
                    children: [
                      Container(
                        width: 0.8.sw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            image: DecorationImage(
                                image: NetworkImage('${post.image}'),
                                fit: BoxFit.fitWidth)),
                      ),
                      if (post.level == 'special')
                        Positioned(
                          top: 10,
                          child: Container(
                            alignment: Alignment.center,
                            //padding: EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.003.sh),
                            width: 0.4.sw,
                            height: 0.02.sh,

                            decoration: BoxDecoration(
                                color: DarkColor.withOpacity(0.6)),
                            child: Text(
                              'مميز',
                              style: H4OrangeTextStyle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.003.sw, vertical: 0.006.sh),
                  width: 0.55.sw,
                  height: 0.15.sh,
                  child: Column(
                    children: [
                      Container(
                        height:0.02.sh,
                        child: Text(
                          "${post.user?.seller_name}",
                          style: H3OrangeTextStyle,
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      30.verticalSpace,
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${post.expert}",
                            style: H4BlackTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ),
                      50.verticalSpace,
                      Container(
                        height:0.02.sh,
                        alignment: Alignment.centerRight,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "${post.city?.name}",
                              style: H4GrayTextStyle),
                          TextSpan(
                              text: " - ${post.category?.name}",
                              style: H4GrayTextStyle),
                          TextSpan(
                              text: " - ${post.sub1?.name}",
                              style: H4GrayTextStyle),
                        ])),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
