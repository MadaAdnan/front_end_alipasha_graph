import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Productsectioncomponent extends StatelessWidget {
  final ProductModel  product;
  const Productsectioncomponent({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          Container(
            height: 0.45.sw,
            width: 0.45.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              image: DecorationImage(
                image: NetworkImage("${product.image}"),
                fit: BoxFit.cover
              )
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
Text("${product.created_at}"),
Text("${product.city?.name}"),
            ],
          )
        ],
      ),
    );
  }
}
