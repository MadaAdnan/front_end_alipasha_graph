import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProductComponent extends StatelessWidget {
   ProductComponent({super.key,required this.priceController,required this.discountController,required this.isAvailable});
final TextEditingController priceController;
final TextEditingController discountController;
final bool isAvailable;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
