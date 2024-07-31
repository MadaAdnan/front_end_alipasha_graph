import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/pages/profile/tabs/tab_chart.dart';
import 'package:ali_pasha_graph/pages/profile/tabs/tab_product.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  MainController mainController = Get.find<MainController>();
  final ProfileLogic logic = Get.find<ProfileLogic>();
  List<Widget> pages = [
    TabProduct(),
    TabChart(),
    TabChart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrayLightColor,
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 0.35.sh),
        child: Container(
          color: WhiteColor,
          child: Column(
            children: [
              Container(
                width: 1.sw,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.all(0.005.sw),
                      decoration: BoxDecoration(
                        color: GrayDarkColor,
                        shape: BoxShape.circle,
                      ),
                      margin: EdgeInsets.only(top: 0.05.sh),
                      child: CircleAvatar(
                        backgroundColor: WhiteColor,
                        minRadius: 0.1.sw,
                        maxRadius: 0.12.sw,
                        child: Container(
                          padding: EdgeInsets.all(0.008.sw),
                          child: Image(
                            image: AssetImage('assets/images/png/user.png'),
                          ),
                          decoration: BoxDecoration(
                              color: GrayDarkColor, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.004.sh,
                        left: 0.01.sw,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: 0.35.sw,
                            height: 0.05.sh,
                            decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Text(
                              'تعديل الحساب',
                              style: H3WhiteTextStyle,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Text(
                'مجموعة شيبان التجارية',
                style: H1BlackTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildWidget(
                      title: 'أتابعه',
                      count:
                          mainController.authUser.value?.followers?.length ?? 0,
                      onTap: () {
                        Get.toNamed(FOLLOWERS_PAGE);
                      }),
                  _buildWidget(title: 'يتابعني', count:  mainController.authUser.value?.followingCount ?? 0),
                //  _buildWidget(title: 'تسجيلات الإعجاب', count: 1000),
                ],
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _pageButton(
                      title: 'منشوراتي',
                      icon: FontAwesomeIcons.newspaper,
                      index: 0),
                  _pageButton(
                      title: 'إعلانات ممولة',
                      icon: FontAwesomeIcons.rectangleAd,
                      index: 1),
                  _pageButton(
                      title: 'الإحصائيات',
                      index: 2,
                      icon: FontAwesomeIcons.chartBar),
                ],
              )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: logic.pageController,
        onPageChanged: (index) {
          logic.pageSelected.value = index;
          logic.pageController.animateToPage(index,
              duration: Duration(microseconds: 400), curve: Curves.bounceInOut);
        },
        children: pages,
      ),
    );
  }

  Widget _pageButton({String? title, IconData? icon, int? index}) {
    return InkWell(
      onTap: () {
        logic.pageSelected.value = index!;
        logic.pageController.animateToPage(index,
            duration: Duration(microseconds: 400), curve: Curves.bounceInOut);
      },
      child: Obx(() {
        return Container(
          alignment: Alignment.center,
          width: 0.31.sw,
          height: 0.045.sh,
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
          decoration: BoxDecoration(
              color: logic.pageSelected == index ? RedColor : GrayLightColor,
              borderRadius: BorderRadius.circular(0.02.sw)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$title',
                style: logic.pageSelected == index
                    ? H4WhiteTextStyle
                    : H4BlackTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              20.horizontalSpace,
              SizedBox(
                  width: 0.05.sw,
                  child: Icon(
                    icon,
                    color: logic.pageSelected == index ? WhiteColor : IconColor,
                  ))
            ],
          ),
        );
      }),
    );
  }

  Widget _buildWidget({String? title, int? count, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 0.3.sw,
        height: 0.08.sh,
        decoration: BoxDecoration(
          border: Border.all(color: GrayDarkColor),
          borderRadius: BorderRadius.circular(15.r),
          color: WhiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$count",
              style: H3BlackTextStyle,
            ),
            15.verticalSpace,
            Text(
              "$title",
              style: H4BlackTextStyle.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
