import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextAreaComponent extends StatelessWidget {

  TextAreaComponent(
      {super.key,
        required this.width,
        this.controller,
        this.hint,
        this.isRequired = false,
        this.validation});

  final TextEditingController? controller;

  final String? hint;
  final double width;
  final bool isRequired;

  final String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child:TextFormField(
        minLines: 7,
          maxLines: 8,
        controller: controller,
        validator: validation,
        style: H3BlackTextStyle,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(children: [
              TextSpan(text: "${hint ?? ''}", style: H3GrayTextStyle),
              if (isRequired) TextSpan(text: "*", style: H3RedTextStyle),
            ]),
          ),
          errorStyle: H3RedTextStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.03.sw),
            borderSide: const BorderSide(
              color: GrayDarkColor,
            ),
          ),
          contentPadding: EdgeInsets.all(20.h),
          filled: true,
          fillColor: GrayLightColor,
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.03.sw),
            borderSide: const BorderSide(
              color: GrayDarkColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.03.sw),
            borderSide: const BorderSide(
              color: GrayDarkColor,
            ),
          ),
        ),
      ),
    );
  }

}
