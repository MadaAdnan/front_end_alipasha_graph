import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/home_app_bar/custom_sliver_app_bar.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class JobsPage extends StatelessWidget {
  JobsPage({Key? key}) : super(key: key);

  final logic = Get.find<JobsLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GrayLightColor,
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
          child: CustomScrollView(
            slivers: [
              HomeSliverAppBarComponent(child: InkWell(
                onTap: () {
                  Get.toNamed(PROFILE_PAGE);
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.013.sh),
                  margin: EdgeInsets.only(top: 0.14.sh),
                  width: double.infinity,
                  height: 0.071.sh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(0.002.sw),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GrayDarkColor,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(0.002.sw),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: WhiteColor,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(0.002.sw),
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Obx(() {
                              return Container(
                                width: 0.1.sw,
                                height: 0.1.sw,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: getLogo() != null
                                            ? NetworkImage('${getLogo()}')
                                            : getUserImage())),
                              );
                            }),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(CREATE_PRODUCT_PAGE);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: Alignment.centerRight,
                            height: 0.055.sh,
                            decoration: BoxDecoration(
                              color: WhiteColor,
                              boxShadow: [
                                BoxShadow(color: GrayDarkColor, blurRadius: 3),
                                BoxShadow(
                                    color: GrayDarkColor.withOpacity(0.4),
                                    blurRadius: 3),
                              ],
                              borderRadius: BorderRadius.circular(50.w),
                            ),
                            child: Text(
                              'ماذا تفكر أن تنشر ...',
                              style: H3GrayTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),),
              Obx(() {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if (index < logic.jobs.length) {
                        return JobCard(post: logic.jobs[index]);
                      }
                      if (logic.mainController.loading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return null;
                    },
                    childCount: logic.jobs.length +
                        (logic.mainController.loading.value ? 1 : 0),
                  ),
                );
              }),
              if (!logic.hasMorePage.value)
                SliverToBoxAdapter(
                  child: Center(
                      child: Padding(

                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'لا يوجد مزيد من النتائج',
                          style: H3GrayTextStyle,
                        ),
                      )),
                ),

            ],
          ),
        ));
  }
}
