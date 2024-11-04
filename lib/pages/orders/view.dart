
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../routes/routes_url.dart';
import 'logic.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({Key? key}) : super(key: key);

  final logic = Get.find<OrdersLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: RedColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        onPressed: () {
          Get.offAndToNamed(SHIPPING_PAGE);
        },
        label: Text(
          'طلب جديد',
          style: H3WhiteTextStyle,
        ),
        icon: Icon(
          FontAwesomeIcons.plus,
          color: WhiteColor,
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !logic.loading.value &&
              logic.hasMorePage.value) {
            logic.nextPage();
          }
          return true;
        },
        child: Obx(() {
          if(logic.loading.value && logic.page.value==1){
            return Container(
              alignment: Alignment.center,
              child: Container(alignment: Alignment.center,width: 0.3.sw,child: ProgressLoading(),),
            );
          }
          return ListView(
            padding:
                EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.01.sh),
            children: [
              ...List.generate(logic.orders.length, (index) {
                return Container(
                  padding: EdgeInsets.only(top: 0.02.sh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: GrayWhiteColor,
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.02.sw, vertical: 0.015.sh),
                              decoration: BoxDecoration(
                                  color: WhiteColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.r),
                                      topRight: Radius.circular(30.r)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 1.r,
                                        blurStyle: BlurStyle.inner,
                                        blurRadius: 10.r)
                                  ],
                                  border: Border(
                                    bottom: BorderSide(color: DarkColor),
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Text(
                                              ' ${logic.orders[index].price}',
                                              style: H2RegularDark,
                                            )),
                                        WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Icon(
                                              FontAwesomeIcons.dollarSign,
                                              size: 0.04.sw,
                                            )),
                                      ])),
                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Text(
                                              ' ${logic.orders[index].created_at}',
                                              style: H2RegularDark,
                                            )),
                                        WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Icon(
                                              FontAwesomeIcons.calendar,
                                              size: 0.04.sw,
                                            )),
                                      ])),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.02.sw, vertical: 0.01.sh),
                              width: 0.8.sw,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Text(
                                                  ' ${logic.orders[index].receive_name}',
                                                  style: H2RegularDark,
                                                )),
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Icon(
                                                  FontAwesomeIcons.user,
                                                  size: 0.04.sw,
                                                )),
                                          ])),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              ' ${logic.orders[index].receive_phone} ',
                                          style: H2RegularDark,
                                        ),
                                        WidgetSpan(
                                            child: Icon(
                                          FontAwesomeIcons.phone,
                                          size: 0.04.sw,
                                        )),
                                      ])),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.01.sh,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        WidgetSpan(
                                            child: Icon(
                                          FontAwesomeIcons.clockRotateLeft,
                                          size: 0.04.sw,
                                          color: logic.orders[index].status ==
                                                  'pending'
                                              ? Colors.blue
                                              : logic.orders[index].status ==
                                                      'success'
                                                  ? Colors.green
                                                  : RedColor,
                                        )),
                                        TextSpan(
                                          text:
                                              ' ${logic.orders[index].status?.OrderStatus()}',
                                          style: H2RegularDark.copyWith(
                                            color: logic.orders[index].status ==
                                                    'pending'
                                                ? Colors.blue
                                                : logic.orders[index].status ==
                                                        'success'
                                                    ? Colors.green
                                                    : RedColor,
                                          ),
                                        ),
                                      ])),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                              FontAwesomeIcons.truckFast,
                                              size: 0.04.sw,
                                            )),
                                            TextSpan(
                                              text:
                                                  ' ${logic.orders[index].from?.name}',
                                              style: H2RegularDark,
                                            ),
                                          ])),
                                          SizedBox(
                                            width: 0.02.sw,
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                              FontAwesomeIcons.dolly,
                                              size: 0.04.sw,
                                            )),
                                            TextSpan(
                                              text:
                                                  ' ${logic.orders[index].to?.name}',
                                              style: H2RegularDark,
                                            ),
                                          ])),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 1.sw,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.02.sw, vertical: 0.005.sh),
                              decoration: BoxDecoration(
                                  color: WhiteColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30.r),
                                      bottomRight: Radius.circular(30.r)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 1.r,
                                        blurStyle: BlurStyle.inner,
                                        blurRadius: 10.r)
                                  ],
                                  border: Border(
                                    bottom: BorderSide(color: DarkColor),
                                  )),
                              child: RichText(
                                  text: TextSpan(children: [
                                WidgetSpan(
                                    child: AutoSizeText(
                                  maxFontSize: 35.sp,
                                  minFontSize: 20.sp,
                                  stepGranularity: 5.sp,
                                  '${logic.orders[index].receive_address}',
                                  style: H4RegularDark,
                                )),
                                WidgetSpan(
                                    child: Icon(
                                  FontAwesomeIcons.locationDot,
                                  size: 0.04.sw,
                                )),
                              ])),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          );
        }),
      ),
    );
  }
}
