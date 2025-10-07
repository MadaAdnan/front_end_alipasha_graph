import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'logic.dart';

class MyAdvicePage extends StatelessWidget {
  MyAdvicePage({Key? key}) : super(key: key);

  final MyAdviceLogic logic = Get.put(MyAdviceLogic());
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sw),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.2.sw,
                        height: 0.2.sw,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/png/crown.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // مسافة بسيطة بين الصورة والنص
                      Expanded(
                        // ✅ هذا هو المفتاح
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // لجعل النص يبدأ من اليمين
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'الإعلانات الممولة',
                              style: H2BlackTextStyle.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 0.005.sh),
                            Text(
                              'حقق وصول أكبر من خلال ترويج علامتك التجارية بشكل أكبر',
                              style: H2GrayOpacityTextStyle.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              // تأكد أن النص يُعرض كاملاً
                              softWrap: true, // ✅ يسمح بانكسار السطر
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        Get.offNamed(PROFILE_PAGE);
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('عودة للملف الشخصي'),
                        value: 1,
                      ),
                    ];
                  },
                ),
              ],
            ),
            Obx(() {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 0.04.sw),
                child: mainController.authUser.value!.plans!
                            .where((el) => el.duration != 'free')
                            .length ==
                        0
                    ? noPlan()
                    : planssubscribe(),
              );
            })
          ],
        ),
      ),
    );
  }

  noPlan() {
    return Container(
      margin: EdgeInsets.only(top: 0.1.sh),
      width: 1.sw,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.plus,
            color: Colors.grey,
            size: 120.r,
            weight: 0.5,
          ),
          SizedBox(
            height: 0.02.sh,
          ),
          Text(
            'لست مشترك بأي خطة مدفوعة \n إشترك بخطة إعلانات ممولة لفتح مميزات \n إضافية رائعة',
            style: H2GrayOpacityTextStyle.copyWith(fontWeight: FontWeight.w300),
            overflow: TextOverflow.visible,
            maxLines: 3,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 0.1.sh,
          ),
          Text(
            '1- إشحن حسابك إذا كنت لا تملك رصيد \n داخل المنصة عبر (شام كاش)',
            style: H2GrayOpacityTextStyle.copyWith(fontWeight: FontWeight.w300),
            overflow: TextOverflow.visible,
            maxLines: 3,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          MaterialButton(
            onPressed: () {
              Get.toNamed(PAYMENT_PAGE);
            },
            child: Text(
              'شحن الحساب',
              style: H4WhiteTextStyle,
            ),
            color: PrimaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20.r)),
          ),
          SizedBox(
            height: 0.1.sh,
          ),
          Text(
            '2- إختر الخطة المناسبة لك لبدأ أول إعلان \n ممول يزيد من تفاعل الجمهور معك',
            style: H2GrayOpacityTextStyle.copyWith(fontWeight: FontWeight.w300),
            overflow: TextOverflow.visible,
            maxLines: 3,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          MaterialButton(
            onPressed: () {
              Get.toNamed(PLAN_PAGE);
            },
            child: Text(
              'أسعار الخطط',
              style: H4WhiteTextStyle,
            ),
            color: PrimaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20.r)),
          )
        ],
      ),
    );
  }

  planssubscribe() {
    Logger().e("SP:${logic.myAdvices.length}");
    return Container(
      padding: EdgeInsets.only(top: 0.05.sh),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...mainController.authUser.value!.plans!
              .where((element) => element.duration != 'free')
              .map((plan) {
            return Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.001.sw, vertical: 0.01.sh),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.grey.withOpacity(0.1),
              ),
              margin: EdgeInsets.only(top: 0.01.sh),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.05.sw, vertical: 0.02.sh),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              "${plan.name}:",
                              minFontSize: 10,
                              maxLines: 1,
                              maxFontSize: 40,
                              style: H3BlackTextStyle.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxLines: 1,
                              maxFontSize: 40,
                              textAlign: TextAlign.center,
                              "منذ ${plan.pivot?.subscription_date}",
                              style: H3BlackTextStyle.copyWith(
                                  fontWeight: FontWeight.w100),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxLines: 1,
                              maxFontSize: 40,
                              textAlign: TextAlign.center,
                              "حتى ${plan.pivot?.expired_date}",
                              style: H3BlackTextStyle.copyWith(
                                  fontWeight: FontWeight.w100),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (plan.special_count != 0 && logic.myProducts.length == 0)
                      Container(
                          width: 1.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.05.sw, vertical: 0.02.sh),
                          child: InkWell(
                              onTap: () {
                                Get.offNamed(CREATE_ADVICE_PAGE);
                              },
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '+',
                                      style: TextStyle(
                                          fontSize: 200.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "انقر لإضافة إعلان",
                                      style: H3RegularDark.copyWith(
                                          fontWeight: FontWeight.w100),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ])))
                    else if ((plan.special_count != 0 &&
                            logic.myProducts.length > 0) ||
                        plan.ads_count != 0 && logic.myAdvices.length > 0)
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    logic.myProducts.length,
                                    (index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 0.35.sw,
                                              height: 0.25.sw,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${logic.myProducts[index].image}"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 0.01.sw),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AutoSizeText(
                                                    "${logic.myProducts[index].name}",
                                                    minFontSize: 10,
                                                    maxLines: 1,
                                                    maxFontSize: 40,
                                                    textAlign: TextAlign.center,
                                                    style: H3BlackTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons.eye,
                                                        size: 30.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 0.005.sw,
                                                      ),
                                                      Text(
                                                        "${logic.myProducts[index].views_count}",
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: H5BlackTextStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 0.12.sw,
                                              child: MaterialButton(
                                                onPressed: () {
                                                  print("HELLO");
                                                  Get.toNamed(Edit_PRODUCT_PAGE,
                                                      arguments: logic
                                                          .myProducts[index]
                                                          .id);
                                                },
                                                child: Icon(
                                                  FontAwesomeIcons.pen,
                                                  size: 40.sp,
                                                ),
                                                color: PrimaryColor,
                                                textColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                if (plan.special_count! > 0)
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "قمت بإضافة",
                                        style: H5RegularDark),
                                    TextSpan(
                                        text: "(${logic.myProducts.length})",
                                        style: H5RedTextStyle),
                                    TextSpan(
                                        text: "منتج مميز من ",
                                        style: H5RegularDark),
                                    TextSpan(
                                        text: "(${plan.special_count})",
                                        style: H5RedTextStyle),
                                  ])),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                ...List.generate(
                                    logic.myAdvices.length,
                                    (index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 0.35.sw,
                                              height: 0.25.sw,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${logic.myAdvices[index].image}"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 0.01.sw),
                                            SizedBox(
                                              width: 0.12.sw,
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Get.dialog(AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Text("حذف"),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            "هل انت متأكد من حذف هذا الاعلان ؟"),
                                                        SizedBox(
                                                          height: 0.02.sh,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            MaterialButton(
                                                                color:
                                                                    Colors.grey,
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: Text(
                                                                  "لا",
                                                                  style:
                                                                      H3RegularDark,
                                                                )),
                                                            MaterialButton(
                                                                color:
                                                                    PrimaryColor,
                                                                onPressed: () {
                                                                  logic.deletAdvice(
                                                                      adviceId: logic
                                                                          .myAdvices[
                                                                              index]
                                                                          .id!);
                                                                  Get.back();
                                                                },
                                                                child: Text(
                                                                  "نعم",
                                                                  style:
                                                                      H3WhiteTextStyle,
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                },
                                                child: Icon(
                                                  FontAwesomeIcons.trash,
                                                  size: 40.sp,
                                                ),
                                                color: PrimaryColor,
                                                textColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                if (plan.ads_count! > 0)
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "قمت بإضافة",
                                        style: H5RegularDark),
                                    TextSpan(
                                        text: "(${logic.myAdvices.length})",
                                        style: H5RedTextStyle),
                                    TextSpan(
                                        text: "إعلان من ",
                                        style: H5RegularDark),
                                    TextSpan(
                                        text: "(${plan.ads_count})",
                                        style: H5RedTextStyle),
                                  ])),
                                if (plan.ads_count! > 0 &&
                                    plan.ads_count! > logic.myAdvices.length)
                                  SizedBox(
                                    width: 1.sw,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "قم بإضافة إعلان",
                                          style: H4RegularDark.copyWith(
                                              height: 0.0001.sh),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print('ADVICS');
                                            Get.toNamed(CREATE_ADVICE_PAGE);
                                          },
                                          child: Text(
                                            "+",
                                            style: H1GrayTextStyle.copyWith(
                                                fontSize: 200.sp,
                                                height: 0.001.sh,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ]),
                        );
                      })
                    else if (plan.ads_count! > 0 && logic.myAdvices.length == 0)
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.05.sw, vertical: 0.02.sh),
                          child: InkWell(
                              onTap: () {
                                Get.offNamed(CREATE_ADVICE_PAGE);
                              },
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '+',
                                      style: TextStyle(
                                          fontSize: 200.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,height: 0.001.sh),
                                    ),
                                    SizedBox(height: 0.001.sh),
                                    Text(
                                      "انقر لإضافة إعلان",
                                      style: H3RegularDark.copyWith(
                                          fontWeight: FontWeight.w100,height: 0.001.sh),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ])))
                  ]),
            );
          })
        ],
      ),
    );
  }
}
