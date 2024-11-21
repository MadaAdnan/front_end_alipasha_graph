import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/plan_card/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../helpers/components.dart';
import '../../helpers/style.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class PlanPage extends StatelessWidget {
  PlanPage({Key? key}) : super(key: key);

  final logic = Get.find<PlanLogic>();
  MainController mainController = Get.find<MainController>();
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 0.4.sh),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.02.sw),
          decoration: BoxDecoration(color: WhiteColor, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 16.r,
                blurRadius: 10.r,
                blurStyle: BlurStyle.outer)
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return InkWell(
                  onTap: () {
                    if (isAuth()) {
                      Get.offAndToNamed(PROFILE_PAGE);
                    } else {
                      Get.offAndToNamed(LOGIN_PAGE);
                    }
                  },
                  child: Container(
                    width: 0.6.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0.005.sw),
                          decoration: const BoxDecoration(
                              color: GrayDarkColor, shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: WhiteColor,
                            minRadius: 0.05.sw,
                            maxRadius: 0.07.sw,
                            child: Container(
                              width: 0.15.sw,
                              height: 0.13.sw,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GrayDarkColor,
                                  image: DecorationImage(
                                    image: mainController.authUser.value?.image != null
                                        ? NetworkImage(
                                            '${mainController.authUser.value?.image}',
                                          )
                                        : getUserImage(),
                                  )),
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Text(
                          '${getName()}',
                          style: H3GrayTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                );
              }),
              Obx(() => logic.balance.value != null
                  ? Container(
                padding: EdgeInsets.only(left: 0.01.sw),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'الرصيد الحالي : ', style: H4GrayTextStyle),
                        TextSpan(
                            text: '${logic.balance.value}',
                            style: H3OrangeTextStyle),
                      ])),
                    )
                  : Text(''))
            ],
          ),
        ),
      ),
      backgroundColor: WhiteColor,
      body: Obx(() {
        if (logic.loading.value) {
          return Container(
            width: 1.sw,
            height: 0.1.sh,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (logic.plans.length > 0 && !logic.loading.value) {
          return PageView(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            children: [
              ...List.generate(
                logic.plans.length,
                (index) => PlanCardComponent(plan: logic.plans[index]),
              )
            ],
          );
        } else {
          return Center(
            child: Text(
              'لا يوجد بيانات',
              style: H4GrayTextStyle,
            ),
          );
        }
      }),
    );
  }
}
