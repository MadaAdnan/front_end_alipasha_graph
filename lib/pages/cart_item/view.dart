import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/cart_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.05.sh,
            decoration: BoxDecoration(
              color: RedColor,
            ),
            child: Obx(() {
              return Text(
                "${logic.cart.value?.seller?.seller_name}",
                style: H3WhiteTextStyle,
              );
            }),
          ),
          Expanded(child: Obx(() {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 0.005.sh),
              children: [
                ...List.generate(
                  logic.carts.length,
                  (index) => Card(
                    child: ListTile(
                      title: Container(
                        child: Text(
                          "${logic.carts[index].productName}",
                          style: H4GrayTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${logic.carts[index].price} \$",
                            style: H5RedTextStyle,
                          ),
                          15.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await mainController.increaseQty(
                                          productId:
                                              logic.carts[index].productId!);
                                      logic.getCart();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(0.006.sw),
                                      decoration: BoxDecoration(
                                          color: RedColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        color: WhiteColor,
                                        size: 0.04.sw,
                                      ),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Container(
                                    child: Text("${logic.carts[index].qty}",style: H3BlackTextStyle,),
                                  ),
                                  20.horizontalSpace,
                                  InkWell(
                                    onTap: () async {
                                      await mainController.decreaseQty(
                                          productId:
                                              logic.carts[index].productId!);
                                      logic.getCart();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(0.006.sw),
                                      decoration: BoxDecoration(
                                          color: RedColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
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
                                  "${logic.carts[index].price! * logic.carts[index].qty!} \$",style: H3BlackTextStyle,)
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
                                    "${logic.carts[index].productImage}"))),
                      ),
                    ),
                  ),
                )
              ],
            );
          },),),
          Obx(() {
            return Visibility(
              visible: logic.carts.length > 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0.01.sh,horizontal: 0.02.sw),
                height: 0.08.sh,
                width: 1.sw,
                alignment: Alignment.center,
                color: GrayLightColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Expanded(child:  Container(
padding: EdgeInsets.symmetric(horizontal: 0.02.sw ,vertical: 0.02.sh),
                         alignment: Alignment.centerRight,
                         child: RichText(
                             text: TextSpan(children: [
                               TextSpan(text: "المجموع : ", style: H3BlackTextStyle),
                               TextSpan(
                                   text:
                                   "${logic.carts.length > 0 ? logic.carts.fold(0.0, (previousValue, element) {
                                     double elementPrice = element.price ?? 0.0;
                                     int elementQty = element.qty ?? 0;
                                     return previousValue +
                                         (elementPrice * elementQty);
                                   }) : 0} \$",
                                   style: H3RedTextStyle),
                             ])),
                       )),
                        if(isAuth())
                        MaterialButton(
                          color: RedColor,
                          onPressed: () async {
                            if (logic.cart.value?.seller?.id != null) {
                              String message = "";
                              for (var item in logic.carts) {
                                message += '''معرف المنتج : ${item.productId} '''
                                    ''' 
        المنتج : ${item.productName} '''
                                    ''' 
        العدد : ${item.qty} '''
                                    '''
        سعر الوحدة : ${item.price} '''
                                    ''' 
        -------------------------
        ''';
                              }
                              message += '''
  ==========================''';
                              message += '''
  المجموع : ${logic.carts.length > 0 ? logic.carts.fold(0.0, (previousValue, element) {
                                double elementPrice = element.price ?? 0.0;
                                int elementQty = element.qty ?? 0;
                                return previousValue +
                                    (elementPrice * elementQty);
                              }) : 0} \$''';
                              message += '''
   ==========================''';
                              await mainController.createCommunity(
                                  sellerId: int.parse(
                                      "${logic.cart.value?.seller?.id}"),
                                  message: message.replaceAll(RegExp(r"['\']"), ''));
                            }
                          },
                          child: Text(
                            'إطلب من خلال الدردشة',
                            style: H4WhiteTextStyle,
                          ),
                        ),
                      if(!isAuth())
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
          },),
        ],
      ),
    );
  }
}
