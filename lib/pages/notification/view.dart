import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/notification_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                border: Border(bottom: BorderSide(color: GrayDarkColor))
              ),
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
                      Text("الإشعارات",style: H3RedTextStyle,),
                      Text("${mainController.authUser.value?.seller_name ?? mainController.authUser.value?.name}",style: H4RegularDark,),

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
            if (logic.loading.value && logic.page.value == 1) {
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
                            onTap: (){
                              NotificationModel notify=logic.notifications[index];
                              if(notify.data?.url?.length !=0){
                                String url =notify.data!.url!;
                                var dataUrl=url.split('/').last.split('?');
                                if(dataUrl[0]=='comments'){
                                  String id="${dataUrl[1]??''}".split('=').last;
                                  Get.toNamed(PRODUCT_PAGE,parameters: {"id":"$id"});
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
                                '${logic.notifications[index].created_at}',style: H5RegularDark,),
                          ),
                        )),

                if (logic.loading.value && logic.page.value > 1)
                  Container(
                    alignment: Alignment.center,
                    child: ProgressLoading(
                      width: 0.06.sw,
                    ),
                  ),
              ],
            );
          }),
        ));
  }
}
