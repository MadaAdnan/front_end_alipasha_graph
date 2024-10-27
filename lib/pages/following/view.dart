import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/style.dart';
import '../../models/user_model.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class FollowingPage extends StatelessWidget {
  FollowingPage({Key? key}) : super(key: key);

  final logic = Get.find<FollowingLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
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
          if (logic.loading.value) {
            return Center(
              child: Container(
                width: 0.3.sw,
                child: ProgressLoading(),
              ),
            );
          }
          return Column(
            children: [
              Container(
                width: 1.sw,
                height: 0.06.sh,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: RedColor), color: RedColor),
                child: Text(
                  'يتابعني',
                  style: H3WhiteTextStyle,
                ),
              ),
              15.verticalSpace,
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw,
                  ),
                  children: [
                    if (logic.users.length > 0 && logic.loading.value==false)
                      ...List.generate(
                          logic.users.length,
                              (index) =>
                              _buildSellerCard2(seller: logic.users[index]))
                    else
                      Container(
                        width: 1.sw,
                        height: 0.06.sh,
                        alignment: Alignment.center,
                        decoration:
                        BoxDecoration(border: Border.all(color: RedColor)),
                        child: Text(
                          'لا يوجد لديك متابعين',
                          style: H4RedTextStyle,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
_buildSellerCard2({required UserModel seller}){
  return Container(
    width: 1.sw,
    padding: EdgeInsets.symmetric(vertical: 0.01.sw, horizontal: 0.01.sw),
    margin: EdgeInsets.symmetric(vertical: 0.01.sw),
    decoration: BoxDecoration(
        border: Border.all(color: GrayLightColor),
        borderRadius: BorderRadius.circular(15.r),
        color: WhiteColor),
    child: Row(
      children: [
        Container(
          width: 0.2.sw,
          height: 0.2.sw,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('${seller.image}'),
                  fit: BoxFit.fitHeight),
              borderRadius: BorderRadius.circular(15.r)),
        ),
        Expanded(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child:  Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw),
                alignment: Alignment.topRight,
                child:Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      /* onTap: (){
                        Get.toNamed(PRODUCTS_PAGE,arguments: seller);
                      },*/
                      child: Text(
                        "${seller.seller_name?.length != 0 ? seller.seller_name : seller.name}",
                        style: H3BlackTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${seller.address}",
                      style: H5RegularDark,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ) ,
              ), ),

              Transform.translate(offset: Offset(0, -0.02.sh),child:  Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.001.sw),
                alignment: Alignment.topRight,
                child: PopupMenuButton<String>(
                  color: WhiteColor,
                  onSelected: (value){
                    if(value=='1'){
                      logic.unFollowing(seller.id!);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: '1',
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.heartCrack,
                            color: RedColor,
                            size: 0.05.sw,
                          ),
                          SizedBox(
                            width: 0.03.sw,
                          ),
                          Text(
                            "حذف من قائمة المتابعين",
                            style: H3RegularDark,
                          ),
                          SizedBox(
                            width: 0.005.sw,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),),

            ],
          ),
        )
      ],
    ),
  );
}
  Widget _buildSellerCard({required UserModel seller}) {
    RxBool loading = RxBool(false);
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 0.01.sw, horizontal: 0.01.sw),
      margin: EdgeInsets.symmetric(vertical: 0.01.sw),
      decoration: BoxDecoration(
          border: Border.all(color: GrayLightColor),
          borderRadius: BorderRadius.circular(15.r),
          color: WhiteColor),
      child: Row(
        children: [
          Container(
            width: 0.2.sw,
            height: 0.2.sw,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${seller.image}'),
                    fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.circular(15.r)),
          ),
          SizedBox(
            width: 0.73.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 0.45.sw,
                  height: 0.12.sw,
                  padding: EdgeInsets.symmetric(
                      vertical: 0.02.sw, horizontal: 0.02.sw),
                  alignment: Alignment.topRight,
                  child: Text(
                    "${seller.name}",
                    style: H3BlackTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Obx(() {
                  if (loading.value) {
                    return Container(
                      width: 0.04.sw,
                      height: 0.04.sw,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () async {
                       Get.defaultDialog(
                         backgroundColor: WhiteColor,
                         title: 'هل أنت متأكد من عملية الحذف',
                         titleStyle: H3RegularDark,
                         textConfirm: 'متابعة',
                         textCancel: 'إلغاء',
                         content: Container(
                           child: Obx(() {
                             if(loading.value)
                               return ProgressLoading();
                             return Text( 'أنت على وشك حذف المستخدم من قائمة المتابعين',style: H4RedTextStyle,);
                           }),
                         ),

                         onCancel: (){

                         },
                         onConfirm: ()async{
                           loading.value=true;
                           try {
                             await logic.unFollowing(seller.id!);
                           } catch (e) {}
                           loading.value=false;
                           Get.back();
                         }
                       );
                      },
                      child: Container(
                        width: 0.3.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: RedColor),
                          color: RedColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 0.015.sw, horizontal: 0.02.sw),

                        alignment: Alignment.center,
                        child: Text(
                          "حذف من قائمة المتابعين",
                          style: H5WhiteTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }


}
