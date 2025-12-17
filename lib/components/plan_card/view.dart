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
                    child: Container(
margin: EdgeInsets.symmetric(horizontal: 0.008.sw,vertical: 0.005.sh),
                     decoration: BoxDecoration(
                       color: index > -1
                           ? GoldColor
                           : Colors.white,
                       borderRadius: BorderRadius.circular(20.r),
                       border: Border.all(
                              color:ScafoldColor
                       )
                     ),
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
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "${plan.name}",
                                    style: H1OrangeTextStyle),
                                TextSpan(
                                    text:
                                        " ( ${plan.duration!.planDuration()} ) ",
                                    style: index > -1 ? H4WhiteTextStyle:H4RegularDark),
                              ])),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.01.sh, horizontal: 0.02.sw),
                              child: Text(
                                "${plan.info}",
                                style: index > -1 ? H3WhiteTextStyle:H3RegularDark,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (plan.duration != 'free')
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
                              ),
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
                                            : FontAwesomeIcons.close,
                                        color: plan.items![i].active == true
                                            ? Colors.green
                                            : PrimaryColor,
                                        size: 60.r),
                                    10.horizontalSpace,
                                    SizedBox(
                                      width: 0.655.sw,
                                      child: Text(
                                        "${plan.items![i].item}",
                                        style: index > -1 ? H2WhiteTextStyle:H2RegularDark,
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
                    if(index==-1){
                      double? price=plan.price;
                      if(plan.is_discount==true){
                        price=plan.discount;
                      }
                      Get.dialog(AlertDialog(
                        content: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: Text(
                                  "إشتراك بالخطة  (${plan.name}) ",
                                  style: H1BlackTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "سيتم خصم مبلغ  ${price} \$ من رصيدك ",
                                  style: H2OrangeTextStyle,
                                ),
                              )
                            ],
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                color: PrimaryColor,
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('إلغاء',style: H4WhiteTextStyle,),
                              ),
                              MaterialButton(
                                color: SecondaryColor,
                                onPressed: () {
                                  logic.subscribePlan(planId: plan.id!);
                                  Get.back();
                                },
                                child: Text('متابعة',style: H4WhiteTextStyle,),
                              ),
                            ],
                          )
                        ],
                      ));
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
                          : plan.duration == 'free'
                              ? 'تم الإشتراك'
                              : 'تم الإشتراك حتى (${currentPlan?.pivot?.expired_date})',
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
