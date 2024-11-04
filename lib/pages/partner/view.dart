

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PartnerPage extends StatelessWidget {
  PartnerPage({Key? key}) : super(key: key);

  final logic = Get.find<PartnerLogic>();

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
              height: 0.07.sh,
              color: RedColor,
              alignment: Alignment.center,
              child: Text(
                'المراكز المعتمدة ',
                style: H3WhiteTextStyle,
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.02.sh, horizontal: 0.02.sw),
                  children: [
                    ...List.generate(logic.partners.length, (index) {
                      return Container(
                        margin: EdgeInsets.only(top: 0.01.sh),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: GrayDarkColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 0.25.sw,
                              height: 0.25.sw,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    logic.partners[index].image!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  width: 0.65.sw,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${logic.partners[index].name}',
                                        style: H3BlackTextStyle,
                                      ),
                                      Text(
                                        '${logic.partners[index].city?.name}',
                                        style: H4GrayTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 0.65.sw,
                                  height: 0.0537.sh,
                                  child: Text(
                                    '${logic.partners[index].address}',
                                    style: H3GrayTextStyle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (logic.partners[index].phone != null)
                                  InkWell(
                                    onTap: () {
                                      openUrl(
                                          url:
                                              "https://wa.me/${logic.partners[index].phone}");
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      width: 0.65.sw,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'تواصل مع الوكيل',
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
                    if (logic.loading.value)
                      Center(
                        child: CircularProgressIndicator(),
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
