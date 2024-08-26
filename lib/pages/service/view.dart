import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ServicePage extends StatelessWidget {
  ServicePage({Key? key}) : super(key: key);

  final logic = Get.find<ServiceLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Container(
              width: 1.sw,
              height: 0.1.sh,
              decoration: BoxDecoration(
                color: RedColor,
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  if (logic.loading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.02.sh, horizontal: 0.02.sw),
                    children: [
                      ...List.generate(logic.products.length, (index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.002.sh, horizontal: 0.01.sw),
                          decoration: BoxDecoration(
                            border: Border.all(color: GrayDarkColor),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: InkWell(
                            child: Container(
                              width: 1.sw,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 0.25.sw,
                                    height: 0.25.sw,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            '${logic.products[index].image}',
                                          ),
                                          fit: BoxFit.fitHeight),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '${logic.products[index].name}',
                                            style: H2RegularDark,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${logic.products[index].city?.name}",
                                                style: H4GrayTextStyle),
                                            TextSpan(
                                                text:
                                                    " - ${logic.products[index].sub1?.name}",
                                                style: H4GrayTextStyle),
                                          ]),
                                        ),
                                        120.verticalSpace,
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.eye,
                                                    size: 0.04.sw,
                                                  ),
                                                  15.horizontalSpace,
                                                  Text(
                                                    '${logic.products[index].views_count}',
                                                    style: H3GrayTextStyle,
                                                  )
                                                ],
                                              ),
                                              Container(
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                    text: 'تاريخ النشر : ',
                                                    style: H4BlackTextStyle,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        '${logic.products[index].created_at}',
                                                    style: H4GrayTextStyle,
                                                  )
                                                ])),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
