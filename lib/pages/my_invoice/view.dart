import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/order_enum.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/invoice_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MyInvoicePage extends StatelessWidget {
  final logic = Get.put(MyInvoiceLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        shadowColor: WhiteColor,
        surfaceTintColor: WhiteColor,
        title: Text(
          'مشترياتي',
          style: H2BlackTextStyle,
        ),
        centerTitle: true,
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
          if (logic.invoices.length == 0 && logic.loading.value) {
            return Container(
              width: 1.sw,
              height: 1.sh,
              alignment: Alignment.center,
              child: ProgressLoading(
                width: 0.3.sw,
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
            children: [
              ...List.generate(logic.invoices.length, (index) {
                InvoiceModel invoice = logic.invoices[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 0.009.sh),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.4)),
                    color: WhiteColor,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [BoxShadow(color: GrayLightColor,spreadRadius: 0.2.r,blurRadius: 0.7.r),BoxShadow(color: GrayLightColor,spreadRadius: 0.2.r,blurRadius: 0.7.r)]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //header
                     Container(
                       padding: EdgeInsets.symmetric(vertical: 0.007.sh,horizontal: 0.06.sw),
                       decoration: BoxDecoration(
                         border: Border(bottom: BorderSide(color: GrayWhiteColor))
                       ),
                       child:  Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                           Container(
                             width: 0.15.sw,
                             height: 0.15.sw,
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 image: DecorationImage(image: CachedNetworkImageProvider("${invoice.seller?.image}"),fit: BoxFit.cover)
                             ),
                           ),
                           SizedBox(width: 0.02.sw,),
                           Expanded(child: Container(
                             alignment: Alignment.centerRight,
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('${invoice.seller?.seller_name}',style: H2BlackTextStyle,overflow: TextOverflow.ellipsis,),
                                 SizedBox(height: 0.02.sw,),
                                 if(invoice.seller?.phone!='')
                                 InkWell(
                                   onTap: (){
                                     openUrl(url: 'https://wa.me/${invoice.seller?.phone}');
                                   },
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Icon(FontAwesomeIcons.whatsapp,color: Colors.green,size: 0.03.sw,),
                                       SizedBox(width: 0.02.sw,),
                                       Text('${invoice.seller?.phone}',style: H2RegularDark,)
                                     ],
                                   ) ,
                                 )
                               ],
                             ),
                           )),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                               RichText(
                                 text: TextSpan(
                                   children: [
                                     TextSpan(
                                         text: 'ID :', style: H4RegularDark),
                                     TextSpan(
                                         text: '${invoice.id}',
                                         style: H4RegularDark),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 0.02.sw,),
                               Text('${invoice.created_at}',style: H4RegularDark,)
                             ],
                           )
                         ],
                       ),
                     ),
                      //addres
                     Container(
                       padding: EdgeInsets.symmetric(vertical: 0.007.sh,horizontal: 0.06.sw),
                       decoration: BoxDecoration(
                           border: Border(bottom: BorderSide(color: GrayWhiteColor))
                       ),
                       child:  Row(
                       children: [
                         Expanded(child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Icon(FontAwesomeIcons.truckFast,size: 0.03.sw,color: RedColor,),
                                 SizedBox(width: 0.02.sw,),
                                 Text('عنوان الشحن :',style: H3GrayTextStyle,)
                               ],
                             ),
                             Text("${invoice.address}",style: H4RegularDark,overflow: TextOverflow.ellipsis,)
                           ],
                         )),
                         InkWell(
                           child: Container(
                             padding:EdgeInsets.symmetric(vertical: 0.02.sw,horizontal: 0.02.sw),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(150.r),
                               color:invoice.status?.getStatusOrderColor()
                             ),
                             child: Text("${invoice.status}".getStatusOrder(),style: H4WhiteTextStyle,),
                           ),
                         )
                       ],
                     ),),
                      // items
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 0.001.sh,horizontal: 0.06.sw),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: GrayWhiteColor))
                        ),

                        child: Column(
                          children: [
                          ...List.generate(invoice.items?.length??0, (i){
                            ItemInvoice item=invoice.items![i];
                                return  Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: GrayLightColor)),
                                  ),
                                  child:  Row(
                                    children: [
                                      //image
                                      Container(
                                        width: 0.2.sw,
                                        height: 0.2.sw,
                                        decoration: BoxDecoration(

                                            image: DecorationImage(image: CachedNetworkImageProvider("${item.product?.image}"),fit: BoxFit.cover)
                                        ),
                                      ),
                                      SizedBox(width: 0.02.sw,),
                                      //data
                                      Expanded(
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start
                                          ,
                                          children: [
                                            Text('${item.product?.name}',style: H2BlackTextStyle.copyWith(color: Colors.black),),
                                            Text('عدد : ${item.qty}',style: H4RegularDark,),
                                            Text('سعر الوحدة :${item.price} \$',style: H2BlackTextStyle.copyWith(color: Colors.black),),
                                          ],
                                        ) ,
                                      ),
                                    ],
                                  ),
                                );
                          })
                          ],
                        ),
                      ),
                          //footer
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 0.007.sh,horizontal: 0.06.sw),

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('الإجمالي : ',style: H2RegularDark,),
                                Text('${invoice.total} \$',style: H2BlackTextStyle.copyWith(color: Colors.black),)
                              ],
                            ),
                            SizedBox(height: 0.007.sh,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('شحن علي باشا : ',style: H2RegularDark,),
                                Text('${invoice.shipping} \$',style: H2BlackTextStyle.copyWith(color: Colors.black),)
                              ],
                            ),
                            SizedBox(height: 0.007.sh,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('المجموع العام : ',style: H2RegularDark,),
                                Text('${double.tryParse("${invoice.shipping! + invoice.total!}")!.toStringAsFixed(2)} \$',style: H2BlackTextStyle.copyWith(color: Colors.black),)
                              ],
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
