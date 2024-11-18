import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CartItemPage extends StatelessWidget {
  CartItemPage({Key? key}) : super(key: key);

  final logic = Get.find<CartItemLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        title: Text(
          'سلة المشتريات',
          style: H2BlackTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.05.sh,
            decoration: BoxDecoration(
              color: GrayLightColor,
            ),
            child: Obx(() {
              return Text(
                "${logic.carts.length} عنصر",
                style: H3GrayTextStyle,
              );
            }),
          ),
          Expanded(
            child: Obx(
              () {
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 0.005.sh),
                  children: [
                    ...List.generate(
                      logic.carts.length,
                      (index) {
                        mainController.logger.f(logic.carts[index].toJson());
                        return Container(
                          height: 0.3.sw,
                          width: 0.7.sw,
                          child: Row(
                            children: [
                              Container(
                                width: 0.3.sw,
                                height: 0.3.sw,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "${logic.carts[index].product?.image}"))),
                              ),
                             Padding(padding: EdgeInsets.symmetric(horizontal: 0.002.sw,vertical: 0.001.sh),child:  Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox( width: 0.5.sw,child: AutoSizeText(
                                   "${logic.carts[index].product?.name}",
                                   style: H3BlackTextStyle,
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 1,
                                 ),),

                                Expanded(child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 0.45.sw,child:  AutoSizeText(
                                      "${logic.carts[index].product?.expert?.trim()}",
                                      style: H4RegularDark,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      wrapWords: true,
                                    ),),
                                    SizedBox(width: 0.037.sw,),
                                    Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(child: InkWell(
                                          onTap:()async{
                                            await mainController.increaseQty(
                                                productId: logic
                                                    .carts[index].product!.id!);
                                            logic.getCart();
                                          },
                                          child: Icon(FontAwesomeIcons.circlePlus),),),
                                        SizedBox(width: 0.01.sw,),
                                        SizedBox(height: 0.02.sh,child: Text('${logic.carts[index].qty}',style: H3BlackTextStyle,)),
                                        SizedBox(width: 0.01.sw,),
                                        SizedBox(child:  InkWell(  onTap:()async{
                                          print("ID:${logic
                                              .carts[index].product!.id!}");
                                          await mainController.decreaseQty(
                                              productId: logic
                                                  .carts[index].product!.id!);
                                          logic.getCart();
                                        },child: Icon(FontAwesomeIcons.circleMinus),),)
                                      ],
                                    )
                                  ],
                                )),

                                SizedBox(width: 0.67.sw,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      "${logic.carts[index].product?.is_discount == true ? logic.carts[index].product?.discount : logic.carts[index].product?.price} \$",
                                      style: H3BlackTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if(logic
                                        .carts[index].product?.is_delivery==true)
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(FontAwesomeIcons.truckFast,color: Colors.green,size: 0.04.sw,),
                                          Text('الشحن متاح',style: H4RegularDark.copyWith(color: Colors.green),)
                                        ],
                                      ),)
                                    else Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(FontAwesomeIcons.truckFast,color: Colors.red,size: 0.04.sw,),
                                          Text('الشحن غير متاح',style: H4RegularDark.copyWith(color: Colors.red),)
                                        ],
                                      ),),
                                  ],
                                ),)
                               ],
                             ),)
                            ],
                          ),
                        );
                        return Card(
                          child: ListTile(
                            title: Container(
                              child: Text(
                                "${logic.carts[index].product?.name}",
                                style: H4GrayTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${logic.carts[index].product!.price} \$",
                                  style: H5RedTextStyle,
                                ),
                                15.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await mainController.increaseQty(
                                                productId: logic
                                                    .carts[index].product!.id!);
                                            logic.getCart();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(0.006.sw),
                                            decoration: BoxDecoration(
                                                color: RedColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.r)),
                                            child: Icon(
                                              FontAwesomeIcons.plus,
                                              color: WhiteColor,
                                              size: 0.04.sw,
                                            ),
                                          ),
                                        ),
                                        20.horizontalSpace,
                                        Container(
                                          child: Text(
                                            "${logic.carts[index].qty}",
                                            style: H3BlackTextStyle,
                                          ),
                                        ),
                                        20.horizontalSpace,
                                        InkWell(
                                          onTap: () async {
                                            await mainController.decreaseQty(
                                                productId: logic
                                                    .carts[index].product!.id!);
                                            logic.getCart();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(0.006.sw),
                                            decoration: BoxDecoration(
                                                color: RedColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.r)),
                                            child: Icon(
                                              FontAwesomeIcons.minus,
                                              color: WhiteColor,
                                              size: 0.04.sw,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${5 * logic.carts[index].qty!} \$",
                                      style: H3BlackTextStyle,
                                    ),
                                    if (logic.carts[index] == true)
                                      Icon(FontAwesomeIcons.truckFast)
                                    else
                                      Container(),
                                  ],
                                ),
                              ],
                            ),
                            leading: Container(
                              width: 0.08.sw,
                              height: 0.08.sh,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${logic.carts[index].product?.image}"))),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
          Obx(
            () {
              return Visibility(
                visible: logic.carts.length > 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.01.sh, horizontal: 0.02.sw),
                  height: 0.2.sh,
                  width: 1.sw,
                  alignment: Alignment.center,
                  color: GrayLightColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text( "${logic.carts.length > 0 ? logic.carts.where((el)=>el.product?.is_delivery==true).fold(0.0, (previousValue, element) {
                                double elementPrice =
                                element.product?.is_discount==true?element.product?.discount ?? 0.0 : element.product?.price ??0;
                                int elementQty = element.qty ?? 0;
                                return previousValue +
                                    (elementPrice * elementQty);
                              }) : 0} \$",
                                  style: H2BlackTextStyle),
                              Text('الإجمالي',style: H3GrayOpacityTextStyle,),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text( "${logic.carts.length > 0 ? logic.carts.where((el)=>el.product?.is_delivery!=true).fold(0.0, (previousValue, element) {
                                double elementPrice =1;
                                print("WWWWE");

                                print(element.product?.weight);
                                num weight=element.product?.weight ??0 * element.qty!;

                                return previousValue +
                                    (elementPrice * weight);
                              }) : 0} \$",
                                  style: H2BlackTextStyle),
                              Text('اجور الشحن',style: H3GrayOpacityTextStyle,),

                            ],
                          ),
                         /* Expanded(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.02.sw, vertical: 0.02.sh),
                            alignment: Alignment.centerRight,
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "المجموع : ", style: H3BlackTextStyle),
                              TextSpan(
                                  text:
                                      "${logic.carts.length > 0 ? logic.carts.where((el)=>el.product?.is_delivery==true).fold(0.0, (previousValue, element) {
                                          double elementPrice =
                                              element.product?.is_discount==true?element.product?.discount ?? 0.0 : element.product?.price ??0;
                                          int elementQty = element.qty ?? 0;
                                          return previousValue +
                                              (elementPrice * elementQty);
                                        }) : 0} \$",
                                  style: H3RedTextStyle),
                            ])),
                          )),*/
                          if (isAuth())
                            MaterialButton(
                              color: RedColor,
                              onPressed: () async {
                                StringBuffer message = StringBuffer();
                                String msg = "";
                                if (logic.carts != null &&
                                    logic.carts.isNotEmpty) {
                                  for (var item in logic.carts) {
                                    message.write(
                                        "معرف المنتج : ${item.product?.id}");
                                    message.write("\n");
                                    message
                                        .write("المنتج : ${item.product?.name}");
                                    message.write("\n");
                                    message.write("العدد : ${item.qty}");
                                    message.write("\n");
                                    message.write("سعر الوحدة : ${item.product?.is_discount==true?item.product?.discount:item.product?.price}");
                                    message.write("\n");
                                    message.write("-------------------------");
                                    message.write("\n");
                                    msg += " ${item.product?.name} " +
                                        "العدد : ${item.qty} ,";
                                  }

                                  // حساب المجموع باستخدام fold
                                  double total = logic.carts.fold(0.0,
                                      (previousValue, element) {
                                    double elementPrice =
                                        element.product?.is_discount == true
                                            ? element.product?.discount ?? 0
                                            : element.product?.price ?? 0;
                                    int elementQty = element.qty ?? 0;
                                    return previousValue +
                                        (elementPrice * elementQty);
                                  });

                                  // إضافة المجموع
                                  message.write("المجموع : $total");
                                } else {
                                  // إذا كانت السلة فارغة
                                  message.write("المجموع : 0");
                                }

                                message.writeln("\n==========================");
                                logic.createOrder();
                                // logic.calcWithAi(msg);
                                /*  await mainController.createCommunity(
                                sellerId: int.parse(
                                    "${logic.cart.value?.seller?.id}"),
                                message: message.toString());*/
                              },
                              child: Text(
                                'إطلب من خلال الدردشة',
                                style: H4WhiteTextStyle,
                              ),
                            ),
                          if (!isAuth())
                            MaterialButton(
                              color: RedColor,
                              onPressed: () async {
                                Get.toNamed(LOGIN_PAGE);
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style: H4WhiteTextStyle,
                              ),
                            ),
                          /*  MaterialButton(
                          color: OrangeColor,
                          onPressed: () {},
                          child: Text(
                            'إطلب عن طريق WhatsApp',
                            style: H4WhiteTextStyle,
                          ),
                        )*/
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
