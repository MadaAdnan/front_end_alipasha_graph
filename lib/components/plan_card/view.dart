import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/models/plan_model.dart';
import 'package:ali_pasha_graph/pages/plan/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';

class PlanCardComponent extends StatelessWidget {
  PlanCardComponent({super.key, required this.plan});

  final PlanModel plan;

  MainController mainController = Get.find<MainController>();
  PlanLogic logic = Get.find<PlanLogic>();

  @override
  Widget build(BuildContext context) {
    PlanModel? currentPlan = null;

    int index = mainController.authUser.value!.plans!
        .indexWhere((el) => el.id == plan.id);
    if (index > -1) {
      currentPlan = mainController.authUser.value!.plans![index];
      mainController.logger.e("TEST TEST1 ${currentPlan.toJson()}");
    }

    return Column(
      key: key,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 0.01.sh,
          color: Colors.transparent,
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0.75.sh,
                  child: Container(
                    constraints: BoxConstraints.expand(height: 0.7.sh),
                    child: Card(
                      elevation: 0,
                      color: index > -1 ? Colors.green.withOpacity(0.6) : Colors.deepPurple.withOpacity(0.8),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.01.sh, horizontal: 0.02.sw),
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(text:  "${plan.name}",style: H1OrangeTextStyle),
                                TextSpan(text: " ( ${plan.duration!.planDuration()} ) ",style: H4WhiteTextStyle),
                              ])),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.01.sh, horizontal: 0.02.sw),
                              child: Text(
                                "${plan.info}",
                                style: H3WhiteTextStyle
                                   ,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if(  plan.duration!='free')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${plan.price} \$",
                                    style: plan.is_discount == false
                                        ? H1OrangeTextStyle
                                        : H1GrayTextStyle.copyWith(
                                        decoration:
                                        TextDecoration.lineThrough),
                                  ),
                                ),
                                if (plan.is_discount == true)
                                  Container(
                                    margin: EdgeInsets.only(right: 0.04.sw),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${plan.discount} \$",
                                      style: H1RedTextStyle,
                                    ),
                                  ),
                              ],
                            ) ,






                            ...List.generate(plan.items!.length, (i) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.01.sh, horizontal: 0.001.sw),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                        plan.items![i].active == true
                                            ? FontAwesomeIcons.solidCircleCheck
                                            : FontAwesomeIcons.ban,
                                        color: plan.items![i].active == true
                                            ? Colors.green
                                            : RedColor,
                                        size: 0.07.sw),
                                    10.horizontalSpace,
                                    SizedBox(
                                      width: 0.655.sw,
                                      child: Text(
                                        "${plan.items![i].item}",
                                        style: H2WhiteTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        softWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    try{
                      logic.subscribePlan(planId: plan.id!);
                    }on CustomException catch(e){
                      Toast.show("${e.message}",gravity: Toast.center,duration: Toast.lengthLong);
                    }

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 0.788.sw,
                    height: 0.1.sw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: index == -1 ? Colors.green : GrayLightColor,
                    ),
                    child: Text(
                      index == -1
                          ? 'إشتراك'
                          : plan.duration=='free'?'تم الإشتراك':'تم الإشتراك حتى (${currentPlan?.pivot?.expired_date})',
                      style: index == -1 ? H3WhiteTextStyle : H3BlackTextStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.02.sh,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
