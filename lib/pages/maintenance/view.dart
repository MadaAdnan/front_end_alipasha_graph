import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'logic.dart';

class MaintenancePage extends StatelessWidget {
  MaintenancePage({Key? key}) : super(key: key);

  final logic = Get.find<MaintenanceLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Lottie.asset(
                'assets/json/maintenance.json',
                //controller: _controller,
                width: 1.sw,
                height: 0.7.sh, fit: BoxFit.fill,

                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  /*_controller
                  ..duration = composition.duration
                  ..forward();*/
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.02.sh,horizontal: 0.03.sw),
            decoration: BoxDecoration(
              color: RedColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text('التطبيق في وضع الصيانة يرجى محاولة الدخول بعد قليل',style: H2RegularDark.copyWith(color: WhiteColor),),
          ),
        ],
      ),
    );
  }
}
