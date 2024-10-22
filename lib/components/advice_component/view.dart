import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/advice_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../helpers/queries.dart';
import '../../models/user_model.dart';

class AdviceComponent extends StatelessWidget {
  AdviceComponent({Key? key, required this.advice}) : super(key: key);

  final AdviceModel advice;
  RxBool loading = RxBool(false);
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    int index = -1;
    if (mainController.authUser.value != null) {
      // Check Is Follower
      if (mainController.authUser.value != null &&
          mainController.authUser.value!.followers != null &&
          advice.user != null &&
          advice!.user!.id != null) {
        index = mainController.authUser.value!.followers!.indexWhere(
          (el) => el.seller?.id == advice?.user?.id,
        );
      }
    }
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          width: 1.sw,
          height: 0.5.sw,
          decoration: BoxDecoration(
              color: WhiteColor,
              borderRadius: BorderRadius.circular(15.r),
              shape: BoxShape.rectangle),
          child: CachedNetworkImage(
            imageUrl: "${advice.image}",
            fit: BoxFit.fitHeight,
          ),
        ),
        if(advice.user!=null)
        Positioned(
          top: 0.008.sh,
          left: 0.02.sw,
          child: InkWell(
            onTap: () {
              if (index == -1) {
                follow();
              }
            },
            child: Container(
              alignment: Alignment.topLeft,
              child: Obx(() {
                if (loading.value) {
                  return CircularProgressIndicator(
                    color: RedColor,
                  );
                }
                return InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.015.sw, vertical: 0.005.sh),
                    width: 0.13.sw,
                    decoration: BoxDecoration(
                      color: index == -1 ? WhiteColor : RedColor,
                      border: Border.all(color: RedColor),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                         index==-1? FontAwesomeIcons.bell:FontAwesomeIcons.solidBell,
                          color: index == -1 ? RedColor : WhiteColor,
                          size: 0.02.sh,
                        ),
                        Text(
                          '${index == -1 ? 'متابعة' : 'أتابعه'}',
                          style:index == -1 ?H6RedTextStyle:H6WhiteTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        )
      ],
    );
  }

  follow() async {
    if (advice.user?.id != null) {
      loading.value = true;
      try {
        mainController.query.value = '''
      mutation FollowAccount {
    followAccount(id: "${advice.user?.id}") {
       $AUTH_FIELDS
    }
}
      ''';
        dio.Response? res = await mainController.fetchData();
       // mainController.logger.e(res?.data);
        if (res?.data?['data']?['followAccount'] != null) {
         /* UserModel user =
              UserModel.fromJson(res?.data?['data']?['followAccount']);*/
          mainController.setUserJson(json: res?.data?['data']?['followAccount']);
        }
        if(res?.data?['errors']?[0]?['message']!=null){
          mainController.showToast(text:'${res?.data['errors'][0]['message']}',type: 'error' );
        }
      } catch (e) {
        mainController.logger.e(e);
      }
      loading.value = false;
    }
  }
}
