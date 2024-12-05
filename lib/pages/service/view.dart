import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component.dart';
import 'package:ali_pasha_graph/components/product_components/minimize_details_product_component_loading.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';

import 'logic.dart';

class ServicePage extends StatelessWidget {
  ServicePage({Key? key}) : super(key: key);

  final logic = Get.find<ServiceLogic>();
MainController mainController=Get.find<MainController>();
ScrollController _scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent * 0.80 &&
              !logic.loading.value &&
              logic.hasMorePage.value && scrollInfo.context ==_scrollController.position.context.notificationContext) {

            logic.nextPage();
          }

          return true;
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 1.sw,
              height: 0.05.sh,
              decoration: BoxDecoration(
                color: RedColor,
              ),
              child: Text(
                '${logic.categoryModel.name}',
                style: H4WhiteTextStyle,
              ),
            ),
            Container(
              width: 1.sw,
              height: 0.108.sh,
              child: Obx(() {
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 0.01.sh,horizontal: 0.02.sw),
                  scrollDirection: Axis.horizontal,
                  children: [
                    if(logic.loading.value && logic.page.value==1)
                      ...List.generate(5, (index) =>
                          Shimmer(gradient: LinearGradient(colors: [GrayLightColor,GrayWhiteColor,GrayLightColor,]), child:  Container(
                            margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            width: 0.15.sw,
                            height: 0.15.sw,
                            decoration: BoxDecoration(
                                border: Border.all(color: GrayLightColor,width: 2),
                                shape: BoxShape.circle,
                                color:GrayWhiteColor,

                            ),
                          )),
                      ),

                    if(logic.cities.length!=0 )
                      InkWell(
                        borderRadius: BorderRadius.circular(100.r),
                        onTap: (){
                          logic.selectedCity.value=null;
                        },
                        child:  Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
                              width: 0.15.sw,
                              height: 0.15.sw,
                              decoration: BoxDecoration(
                                  border: Border.all(color:logic.selectedCity.value==null ?RedColor: GrayLightColor,width: 2),
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                  image: DecorationImage(image: AssetImage("assets/images/png/_logo.png"))
                              ),
                            ),
                            Text('الكل',style: H4RegularDark,)
                          ],
                        ),
                      ),
                    if(logic.cities.length!=0 )

                    ...List.generate(logic.cities.length, (index) =>
                       InkWell(
                         borderRadius: BorderRadius.circular(100.r),
                         onTap: (){
                           logic.selectedCity.value=logic.cities[index];
                         },
                         child:  Column(
                           children: [
                             Container(
                               margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
                               width: 0.15.sw,
                               height: 0.15.sw,
                               decoration: BoxDecoration(
                                   border: Border.all(color:logic.selectedCity.value?.id==logic.cities[index].id?RedColor: GrayLightColor,width: 2),
                                   shape: BoxShape.circle,
                                   color: Colors.red,
                                   image: DecorationImage(image: CachedNetworkImageProvider("${logic.cities[index].image}"),fit: BoxFit.cover)
                               ),
                             ),
                             Text('${logic.cities[index].name}',style: H4RegularDark,)
                           ],
                         ),
                       ))
                  ],
                );
              }),
            ),
            Divider(),
            Expanded(
              child: Obx(
                    () {
                  return ListView(
                    key: Key('list1'),
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(
                        vertical: 0.005.sh, horizontal: 0.02.sw),
                    children: [
                      if (logic.loading.value && logic.page.value==1)
                      ...List.generate(4, (index)=>MinimizeDetailsProductComponentLoading()),


                      ...List.generate(logic.products.length, (index) {
                        return MinimizeDetailsServiceComponent(
                          post: logic.products[index],
                          TitleColor: DarkColor,
                          onClick: () {
                            if(logic.products[index].url!=null && logic.products[index].url!.startsWith('http') && !logic.products[index].url!.endsWith('pdf') ){
                              openUrl(url: "${logic.products[index].url}");

                            }else if(logic.products[index].url!=null && logic.products[index].url!.startsWith('http') && logic.products[index].url!.endsWith('pdf')){
                             // openUrl(url: "${logic.products[index].url}");
                              Get.toNamed(PDF_PAGE,
                                  arguments: logic.products[index].url);

                            }else{
                              Get.toNamed(SERVICE_DETAILS,
                                  arguments: logic.products[index].id,parameters: {"id":"${logic.products[index].id}"});
                            }

                          },
                        );
                      }),
                      if(logic.loading.value && logic.page.value>1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(child: Container(height: 0.06.sh,child: ProgressLoading())),
                            Flexible(child: Text('جاري جلب المزيد',style: H4GrayTextStyle,))
                          ],
                        ),
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
