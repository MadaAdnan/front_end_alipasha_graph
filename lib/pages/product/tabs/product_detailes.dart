
import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/pages/product/logic.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/product_components/minimize_details_product_component.dart';

class ProductDetailes extends StatelessWidget {
  ProductDetailes({super.key, this.product, required this.products});

  final ProductModel? product;
  final List<ProductModel> products;
  MainController mainController = Get.find<MainController>();
  ProductLogic logic = Get.find<ProductLogic>();

  @override
  Widget build(BuildContext context) {

    return  ListView(
      children: [

        Container(
          constraints: BoxConstraints(minHeight: 0.2.sh,),
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.01.sh),
          decoration: BoxDecoration(
            color: GrayWhiteColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: RichText(
            softWrap: true,
            text: TextSpan(children: [
              ..."${product?.info}".split(' ').map((el) {
                print(el);
                if (mainController.isURL("$el")) {

                  return TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async => await openUrl(url: '$el'),
                    text: ' $el ',
                    style:  H3RedTextStyle.copyWith(height: 1.5),
                  );
                } else {
                  return TextSpan(
                      text: ' $el ',
                      style:  H3RegularDark.copyWith(height: 1.5));
                }
              })
            ]),
          ),
        ),
        SizedBox(height: 0.01.sh,),
        if(product?.type=='job' || product?.type=='search_job' || product?.type=='tender' || product?.type=='service')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(product?.docs.length??0, (index)=>InkWell(
                onTap: (){
                  openUrl(url: "${product?.docs[index]}");
                },
                child: Text("مرفق ${index+1}",style: H3RedTextStyle.copyWith(decoration: TextDecoration.underline,decorationColor: RedColor),),
              ))
            ],
          ),
        SizedBox(height: 0.01.sh,),
        Text('منتجات ذات صلة',style: H3RedTextStyle.copyWith(decoration: TextDecoration.underline,decorationColor: RedColor),),
        SizedBox(height: 0.01.sh,),
        ...List.generate(products.length, (index){
          switch(products[index].type){
            case 'product':
              return MinimizeDetailsProductComponent(post: products[index],TitleColor: DarkColor,onClick: (){
                logic.productId.value= products[index].id;
              },);

            case 'service':
              return MinimizeDetailsServiceComponent(post: products[index],TitleColor: DarkColor,onClick: (){
                logic.productId.value= products[index].id;
              },);

            case 'job':
            case 'search_job':
              return MinimizeDetailsJobComponent(post: products[index],TitleColor: DarkColor,onClick: (){
                logic.productId.value= products[index].id;
              },);

            default:
              return MinimizeDetailsTenderComponent(post: products[index],TitleColor: DarkColor,onClick: (){
                logic.productId.value= products[index].id;
              },);
          }
        })
      ],

    );
  }
}
