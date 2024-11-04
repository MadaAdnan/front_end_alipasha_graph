import 'package:flutter/material.dart';

class ProductComponent extends StatelessWidget {
   const ProductComponent({super.key,required this.priceController,required this.discountController,required this.isAvailable});
final TextEditingController priceController;
final TextEditingController discountController;
final bool isAvailable;
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [

      ],
    );
  }
}
