import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CartSellerPage extends StatelessWidget {
  CartSellerPage({Key? key}) : super(key: key);

  final logic = Get.find<CartSellerLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 0.07.sh,
            width: 1.sw,
            color: RedColor,
            alignment: Alignment.center,
            child: Text(
              'سلة المشتريات',
              style: H3WhiteTextStyle,
            ),
          ),
          Expanded(
            child: Container(
              child: Obx(
                () {
                  return ListView(
                    children: [
                      ...List.generate(
                        logic.uniqueCartsList.length,
                        (index) => Card(
                          child: ListTile(
                            onTap: () {
                              Get.toNamed(CART_ITEM,
                                  arguments: logic.uniqueCartsList[index]);
                            },
                            leading: Container(
                              width: 0.08.sw,
                              height: 0.08.sw,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "${logic.uniqueCartsList[index].product?.user?.image}"))),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               SizedBox(width: 0.6.sw,child:  Text(
                                 "${logic.uniqueCartsList[index].seller?.seller_name}",
                                 style: H3BlackTextStyle,
                               ),),
                                IconButton(
                                    onPressed: () async{
                                     await mainController.removeBySeller(sellerId: logic.uniqueCartsList[index].seller?.id);
                                      logic.getSellers();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.trash,
                                      color: RedColor,
                                      size: 0.04.sw,
                                    ))
                              ],
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "عدد المنتجات في السلة : ",
                                      style: H4BlackTextStyle),
                                  TextSpan(
                                      text:
                                          "${mainController.carts.where((el) => el.seller?.seller_name == logic.uniqueCartsList[index].seller?.seller_name).length}",
                                      style: H4BlackTextStyle),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(child: MaterialButton(onPressed: ()async{
           await mainController.emptyCart();
           logic.getSellers();
          },child: Text('إفراغ السلة',style: H3WhiteTextStyle,),color: RedColor,),width: 1.sw,)
        ],
      ),
    );
  }
}
