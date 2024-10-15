import 'dart:ui';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';
import 'package:ali_pasha_graph/components/slider_component/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/slider_model.dart';
import 'package:ali_pasha_graph/pages/product/tabs/comment_page.dart';
import 'package:ali_pasha_graph/pages/product/tabs/product_detailes.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ProductPage extends StatelessWidget {
  ProductPage({Key? key}) : super(key: key);

  final logic = Get.find<ProductLogic>();
  MainController mainController = Get.find<MainController>();
  ScrollController controller = ScrollController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: WhiteColor,
      body: Obx(
            () {
          if (logic.loading.value) {
            return Container(

              child: Center(
                child: ProgressLoading(width: 0.3.sw,height: 0.3.sw,),
              ),
            );
          }
          List<String>? images =
          logic.product.value?.images.map((el) => "$el").toList();
          if (images?.length == 0 && logic.product.value?.user?.logo != null) {
            images?.add("${logic.product.value?.user?.logo}");
          }

          
          return ListView(
            children: [
             Container(
               padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
               width: 1.sw,
               height: 0.06.sh,
               color:WhiteColor,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       Container(width: 0.05.sh,height: 0.05.sh,decoration: BoxDecoration(
                         shape: BoxShape.circle,

                         image: DecorationImage(image: CachedNetworkImageProvider("${logic.product.value?.user?.image}"),fit: BoxFit.cover)
                       ),),
                      SizedBox(width: 0.02.sw,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Row(
                           children: [
                             Text('منشور بواسطة :',style: H4RegularDark,),
                             Icon(FontAwesomeIcons.locationDot,size: 0.02.sh,color: GrayLightColor,),
                             Text("${logic.product.value?.city}",style: H4RegularDark,),
                           ],
                         ),
                          SizedBox(height: 0.02.sw,),
                          Row(
                            children: [
                              Text("${logic.product.value?.user?.seller_name}",style: H4BlackTextStyle.copyWith(fontWeight: FontWeight.w900,color: Colors.black),),
                              if ((logic.product.value?.user?.is_verified == true))
                                Container(
                                  width: 0.04.sw,
                                  height: 0.04.sw,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: Svg("assets/images/svg/verified.svg"
                                                ,
                                            size: Size(0.01.sw, 0.01.sw),
                                          ))),
                                ),
                            ],
                          )
                          //Text('${logic.product.value?.user?.seller_name}')

                        ],
                      )
                     ],
                   ),
                   Container()
                 ],
               ),
             ),
             if(logic.product.value?.images.length!=0)
               Container(
                 width: 0.41.sw,
                 child: SliderComponent(items:logic.product.value!.images.map((el)=>SliderModel(image: el)).toList(),width: 0.41.sh,height: 0.41.sh,),
               ),

              if(logic.product.value?.images.length==0)
                SizedBox(
                  width: 0.41.sw,
                  child: Container(
                    child: SliderComponent(items:[SliderModel(image: "${logic.product.value!.image}")],width: 0.41.sh,height: 0.41.sh,),
                  ),
                )
                ,
              if(logic.product.value?.type=='product')
              Obx(() {
                return Container(
                  height: 0.08.sh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          logic.pageController.animateToPage(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 0.3.sw,
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                              color:logic.pageIndex.value==0? RedColor:GrayLightColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            'التفاصيل',
                            style:logic.pageIndex.value==0? H3WhiteTextStyle:H3BlackTextStyle,
                          ),
                        ),
                      ),
                      if(logic.product.value?.type=='product')
                      InkWell(
                        onTap: () {
                          logic.pageController.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 0.3.sw,
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                              color:logic.pageIndex.value==1? RedColor:GrayLightColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            'التعليقات',
                            style:logic.pageIndex.value==1? H3WhiteTextStyle:H3BlackTextStyle,
                          ),
                        ),
                      ),
                     /* if(logic.product.value?.type=='product')
                      InkWell(
                        onTap: () {
                          logic.pageController.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInCirc);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 0.3.sw,
                          height: 0.05.sh,
                          decoration: BoxDecoration(
                              color:logic.pageIndex.value==2? RedColor:GrayLightColor,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            'الموقع',
                            style:logic.pageIndex.value==2? H3WhiteTextStyle:H3BlackTextStyle,
                          ),
                        ),
                      )*/
                    ],
                  ),
                );
              }),
              Container(
                width: 1.sw,
                height:logic.product.value?.type=='product'? 0.52.sh:0.62.sh,
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: PageView(
                  onPageChanged: (index) {
                    logic.pageIndex.value = index;
                  },
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  controller: logic.pageController,
                  children: [
                    if(logic.product.value!=null)
                    ProductDetailes(
                      product: logic.product.value,
                      products: logic.products,
                    ),
                    if(logic.product.value?.type=='product')
                    Container(
                      child: CommentPage(),
                    ),

                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
