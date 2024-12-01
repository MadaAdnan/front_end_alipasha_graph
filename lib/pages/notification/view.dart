import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/notification_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../Global/main_controller.dart';
import 'logic.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);

  final logic = Get.find<NotificationLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WhiteColor,
        appBar: PreferredSize(
            preferredSize: Size(0.1.sw, 0.07.sh),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.01.sh),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: GrayDarkColor))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                    width: 0.2.sw,
                    decoration: BoxDecoration(
                        border: Border.all(color: GrayLightColor),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "${mainController.authUser?.value?.image}"),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "الإشعارات",
                        style: H3RedTextStyle,
                      ),
                      Text(
                        "${mainController.authUser.value?.seller_name ?? mainController.authUser.value?.name}",
                        style: H4RegularDark,
                      ),
                    ],
                  )
                ],
              ),
            )),
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
            if (logic.loading.value && logic.notifications.length == 0) {
              return Container(
                alignment: Alignment.center,
                child: ProgressLoading(
                  width: 0.3.sw,
                ),
              );
            }
            return ListView(
              children: [
                ...List.generate(
                    logic.notifications.length,
                    (index) => Card(
                          color: WhiteColor,
                          child: ListTile(
                            onTap: () {
                              NotificationModel notify =
                                  logic.notifications[index];
                              if (notify.data?.url?.length != 0) {
                                String url = notify.data!.url!;
                                var dataUrl =
                                    url.replaceFirst('//', '').split('/');

//handelComment
                                if (dataUrl.last.split('?')[0] == 'comments') {
                                  String id =
                                      "${dataUrl.last.split('?')[1] ?? ''}"
                                          .split('=')
                                          .last;
                                  Get.toNamed(PRODUCT_PAGE,
                                      parameters: {"id": "$id"});
                                }

                                if (dataUrl.last.split('?')[0] == 'product') {
                                  Get.offNamed(PROFILE_PAGE);
                                }
                                // handelCommunity
                                if (dataUrl[1] == 'communities' &&
                                    dataUrl.length > 3) {
                                  String id = "${dataUrl[2]}";
                                  String type = dataUrl[3];
                                  if (type == 'chat') {
                                    Get.toNamed(CHAT_PAGE,
                                        parameters: {"id": "$id"});
                                  } else if (type == 'group') {
                                    Get.toNamed(GROUP_PAGE,
                                        parameters: {"id": "$id"});
                                  } else if (type == 'channel') {
                                    Get.toNamed(CHANNEL_PAGE,
                                        parameters: {"id": "$id"});
                                  }
                                }

                                if (dataUrl[1] == 'export') {
                                  Get.offNamed(INVOICE_PAGE);
                                }
                                if (dataUrl[1] == 'import') {
                                  Get.offNamed(MY_INVOICE_PAGE);
                                }

                                if (dataUrl[1] == 'orders') {
                                  Get.offNamed(MY_ORDER_SHIPPING_PAGE);
                                }
                                if (dataUrl[1] == 'balances') {
                                  Get.offNamed(BALANCES_PAGE);
                                }

                                print(dataUrl);
                              }
                            },
                            title: Text(
                              '${logic.notifications[index].data?.title}',
                              style: H2RegularDark,
                            ),
                            subtitle: Text(
                              '${logic.notifications[index].data?.body}',
                              style: H4GrayTextStyle,
                            ),
                            trailing: Text(
                              '${logic.notifications[index].created_at}',
                              style: H5RegularDark,
                            ),
                          ),
                        )),
                if (logic.loading.value && logic.notifications.length > 0)
                  Container(
                    alignment: Alignment.center,
                    child: ProgressLoading(
                      width: 0.1.sw,
                    ),
                  ),
              ],
            );
          }),
        ));
  }
}
