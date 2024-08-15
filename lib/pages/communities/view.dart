import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CommunitiesPage extends StatelessWidget {
  CommunitiesPage({Key? key}) : super(key: key);

  final logic = Get.find<CommunitiesLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !mainController.loading.value &&
              logic.hasMorePage.value) {
            logic.nextPage();
          }
          return true;
        },
        child: Column(
          children: [
            Container(
              height: 0.13.sh,
              padding: EdgeInsets.only(top: 0.01.sh),
              alignment: Alignment.center,
              color: RedColor,
              child: Column(
                children: [
                  Text(
                    'محادثاتي',
                    style: H3WhiteTextStyle,
                  ),
                  10.verticalSpace,
                  InputComponent(
                    width: 0.8.sw,
                    hint: "ابحث",
                    onEditingComplete: () {
                      logic.search.value = logic.searchController.text;

                      FocusScope.of(context).unfocus();
                      return '';
                    },
                    controller: logic.searchController,
                  )
                ],
              ),
            ),
            Expanded(child: Obx(() {
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 0.01.sh,horizontal: 0.02.sw),
                children: [
                  ...List.generate(logic.communities.length, (index) {
                    UserModel? frind = mainController.authUser.value?.id ==
                            logic.communities[index].user?.id
                        ? logic.communities[index].seller
                        : logic.communities[index].user;
                    return InkWell(
                      onTap: (){
                        logic.communities[index].receiveMessagesCount(0);
                        Get.toNamed(CHAT_PAGE,arguments: logic.communities[index]);
                      },
                      child: Card(
                        color: WhiteColor,
                        child:  Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.01.sh, horizontal: 0.01.sw),
                          margin: EdgeInsets.symmetric(vertical: 0.01.sh),
                          width: 0.9.sh,

                          child: Column(
                            children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       width: 0.1.sw,
                                       height: 0.1.sw,
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           image: DecorationImage(
                                               image: NetworkImage(
                                                   '${frind?.image}'))),
                                     ),
                                     10.horizontalSpace,
                                     Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text('${frind?.name}',style: H3BlackTextStyle,),
                                         Text('${frind?.seller_name}',style: H5GrayTextStyle,),
                                       ],
                                     )
                                   ],
                                 ),
                                if(logic.communities[index].receiveMessagesCount>0)
                                Container(
                                  padding: EdgeInsets.all(4),
                                  alignment: Alignment.center,
                                  child:  Text('${logic.communities[index].receiveMessagesCount??0}',style: H3WhiteTextStyle,),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: RedColor
                                  ),
                                )
                               ],
                             ),
                              Container(

                                alignment: Alignment.bottomLeft,
                                child: Text('${logic.communities[index].lastChange}',style: H5GrayTextStyle,),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  if (logic.loading.value)
                    Container(

                      alignment: Alignment.center,
                      width: 1.sw,
                      height: 0.05.sh,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('جاري جلب البيانات',style: H4GrayTextStyle,),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
