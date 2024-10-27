import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/product_components/minimize_details_product_component_loading.dart';
import '../../components/progress_loading.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/style.dart';
import 'logic.dart';

class SellersPage extends StatelessWidget {
  SellersPage({Key? key}) : super(key: key);

  final logic = Get.find<SellersLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
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
              height: 0.05.sh,
              color: RedColor,
              alignment: Alignment.center,
              child: Text(
                'تجار الجملة ',
                style: H3WhiteTextStyle,
              ),
            ),
            Container(
              width: 1.sw,
              height: 0.108.sh,
              child: Obx(() {
                return ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.01.sh, horizontal: 0.02.sw),
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (logic.loading.value)
                      ...List.generate(
                        5,
                        (index) => Shimmer(
                            gradient: const LinearGradient(colors: [
                              GrayLightColor,
                              GrayWhiteColor,
                              GrayLightColor,
                            ]),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
                              width: 0.15.sw,
                              height: 0.15.sw,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: GrayLightColor, width: 2),
                                shape: BoxShape.circle,
                                color: GrayWhiteColor,
                              ),
                            )),
                      ),
                    if (logic.loading.value == false)
                      InkWell(
                        borderRadius: BorderRadius.circular(100.r),
                        onTap: () {
                          logic.selectedCity.value = null;
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
                              width: 0.15.sw,
                              height: 0.15.sw,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: logic.selectedCity.value?.id == null
                                        ? RedColor
                                        : GrayLightColor,
                                    width: 2),
                                shape: BoxShape.circle,
                                color: Colors.red,
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/png/_logo.png",
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'الكل',
                              style: H4RegularDark,
                            )
                          ],
                        ),
                      ),
                    if (logic.loading.value == false)
                      ...List.generate(
                          logic.categories.length,
                          (index) => InkWell(
                                borderRadius: BorderRadius.circular(100.r),
                                onTap: () {
                                  logic.selectedCity.value =
                                      logic.categories[index];
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0.02.sw),
                                      width: 0.15.sw,
                                      height: 0.15.sw,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: logic.selectedCity.value
                                                          ?.id ==
                                                      logic.categories[index].id
                                                  ? RedColor
                                                  : GrayLightColor,
                                              width: 2),
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  "${logic.categories[index].img}"))),
                                    ),
                                    Text(
                                      '${logic.categories[index].name}',
                                      style: H4RegularDark,
                                    )
                                  ],
                                ),
                              ))
                  ],
                );
              }),
            ),
            Divider(),
            Expanded(
              child: Obx(() {
                return ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.005.sh, horizontal: 0.023.sw),
                  children: [
                    if (!logic.loading.value)
                      ...List.generate(logic.sellers.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(top: 0.01.sh),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2.r,
                                  spreadRadius: 7.r,
                                  blurStyle: BlurStyle.outer,
                                )
                              ]
                              // border: Border.all(color: GrayDarkColor),
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 0.3.sw,
                                height: 0.3.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.r),
                                      bottomRight: Radius.circular(30.r)),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      logic.sellers[index].image!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: 0.65.sw,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${logic.sellers[index].name}',
                                          style: H3BlackTextStyle,
                                        ),
                                        Text(
                                          '${logic.sellers[index].city?.name}',
                                          style: H4GrayTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 0.65.sw,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${logic.sellers[index].info}',
                                          style: H3GrayTextStyle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${logic.sellers[index].address}',
                                          style: H3GrayTextStyle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                  if (logic.sellers[index].phone != null)
                                    InkWell(
                                      onTap: () {
                                        openUrl(
                                            url:
                                                "https://wa.me/${logic.sellers[index].phone}");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(

                                        ),
                                        alignment: Alignment.bottomLeft,
                                        width: 0.65.sw,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'تواصل مع التاجر',
                                              style: H4GrayTextStyle,
                                            ),
                                            10.horizontalSpace,
                                            Icon(
                                              FontAwesomeIcons.whatsapp,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    if (logic.loading.value && logic.page.value == 1)
                      ...List.generate(4,
                          (index) => MinimizeDetailsProductComponentLoading()),
                    if (logic.loading.value && logic.page.value > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Container(
                                  height: 0.06.sh, child: ProgressLoading())),
                          Flexible(
                              child: Text(
                            'جاري جلب المزيد',
                            style: H4GrayTextStyle,
                          ))
                        ],
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
