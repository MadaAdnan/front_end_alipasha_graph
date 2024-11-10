import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class RestaurantPage extends StatelessWidget {
  final logic = Get.put(RestaurantLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        elevation: 2,
        centerTitle: true,
        title: Text('المتاجر',style: H2BlackTextStyle,),
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
          if (logic.loading.value) {
            return Container(
              alignment: Alignment.center,
              width: 1.sw,
              height: 1.sh,
              child: ProgressLoading(
                width: 0.25.sw,
              ),
            );
          }
          return ListView(
            padding:
                EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sw),
            children: [
              ...List.generate(
                  logic.users.length,
                  (index) => GestureDetector(
                    onTap: (){
                      Get.toNamed(PRODUCTS_PAGE,parameters: {"id":"${logic.users[index].id}"},);
                    },
                        child: Container(
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 0.5.r,
                                  spreadRadius: 0.5.r)
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 0.3.sw,
                                height: 0.3.sw,
                                decoration: BoxDecoration(
                                    color: GrayWhiteColor,
                                    borderRadius: BorderRadius.circular(30.r),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${logic.users[index].image}"),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.01.sh, horizontal: 0.01.sw),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 0.63.sw,
                                      child: SellerNameComponent(
                                        textStyle: H2BlackTextStyle,
                                        isVerified:
                                            logic.users[index].is_verified ==
                                                true,
                                        isRegular: false,
                                        seller: logic.users[index],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.004.sh,
                                    ),
                                    Container(
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "  ${logic.users[index].city?.name}",
                                            style: H4GrayTextStyle),
                                      ])),
                                    ),
                                    SizedBox(
                                      height: 0.01.sh,
                                    ),
                                    Container(
                                        width: 0.63.sw,
                                        child: Text(
                                          '${logic.users[index].address}',
                                          style: H3GrayTextStyle,
                                          maxLines: 3,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
            ],
          );
        }),
      ),
    );
  }
}
