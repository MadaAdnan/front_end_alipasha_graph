import 'dart:math';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../exceptions/custom_exception.dart';
import '../../helpers/colors.dart';
import '../../helpers/queries.dart';
import 'logic.dart';
import "package:dio/dio.dart" as dio;

class FollowersPage extends StatelessWidget {
  FollowersPage({Key? key}) : super(key: key);

  final logic = Get.find<FollowersLogic>();
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
        child: Obx(() {
          if (logic.loading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Container(
                width: 1.sw,
                height: 0.06.sh,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: RedColor), color: RedColor),
                child: Text(
                  'متاجر أتابعها',
                  style: H3WhiteTextStyle,
                ),
              ),
              15.verticalSpace,
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw,
                  ),
                  children: [
                    if (logic.sellers.length > 0)
                      ...List.generate(
                          logic.sellers.length,
                          (index) =>
                              _buildSellerCard(seller: logic.sellers[index]))
                    else
                      Container(
                        width: 1.sw,
                        height: 0.06.sh,
                        alignment: Alignment.center,
                        decoration:
                            BoxDecoration(border: Border.all(color: RedColor)),
                        child: Text(
                          'لم تقم بمتابعة أي متجر',
                          style: H4RedTextStyle,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSellerCard({required UserModel seller}) {
    RxBool loading = RxBool(false);
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 0.01.sw, horizontal: 0.01.sw),
      margin: EdgeInsets.symmetric(vertical: 0.01.sw),
      decoration: BoxDecoration(
          border: Border.all(color: GrayLightColor),
          borderRadius: BorderRadius.circular(15.r),
          color: WhiteColor),
      child: Row(
        children: [
          Container(
            width: 0.2.sw,
            height: 0.2.sw,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${seller.logo}'),
                    fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.circular(15.r)),
          ),
          SizedBox(
            width: 0.73.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 0.45.sw,
                  height: 0.12.sw,
                  padding: EdgeInsets.symmetric(
                      vertical: 0.02.sw, horizontal: 0.02.sw),
                  alignment: Alignment.topRight,
                  child: Text(
                    "${seller.seller_name}",
                    style: H3BlackTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Obx(() {
                  if (loading.value) {
                    return Container(
                      width: 0.04.sw,
                      height: 0.04.sw,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () async {
                        loading.value = true;
                        try {
                          await unFollowers(seller.id!);
                        } catch (e) {}

                        loading.value = false;
                      },
                      child: Container(
                        width: 0.3.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: RedColor),
                          color: RedColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 0.015.sw, horizontal: 0.02.sw),

                        alignment: Alignment.center,
                        child: Text(
                          "إلغاء المتابعة",
                          style: H3WhiteTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> unFollowers(int sellerId) async {
    try {
      mainController.query.value = '''
      mutation FollowAccount {
    followAccount(id: "$sellerId") {
       $AUTH_FIELDS
    }
}
      ''';
      dio.Response? res = await mainController.fetchData();
      mainController.logger.e(res?.data);
      if (res?.data?['data']?['followAccount'] != null) {
        UserModel user =
            UserModel.fromJson(res?.data?['data']?['followAccount']);
        mainController.setUser(user: user, isWrite: true);
        int index = logic.sellers.indexWhere((el) => el.id == sellerId);
        if (index > -1) {
          logic.sellers.removeAt(index);
        }
      }
    } on CustomException catch (e) {
      mainController.logger.e(e);
    }
  }
}
