import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InputComponent extends StatelessWidget {
  InputComponent({
    this.name='input',
    super.key,
    required this.width,
    this.controller,
    this.textInputType,
    this.hint,
    this.isRequired = false,
    this.validation,
    this.onEditingComplete,
    this.height,
    this.fill,
    this.onChanged,
    this.suffixIcon,
    this.prefix,
    this.suffixClick,
    this.isSecure=false,
    this.radius,
    this.maxLine,
    this.minLine,
    this.textStyle


  });

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hint;
  final double width;
  final double? height;
  final bool isRequired;
  final bool isSecure;
  final Color? fill;
  final double? radius;
  final int? maxLine;
  final int? minLine;
final TextStyle? textStyle;
  final String? Function(String?)? validation;
  final String? Function()? onEditingComplete;
  final String? Function(String?)? onChanged;
  IconData? suffixIcon;
  final Widget? prefix;
  final String? Function()? suffixClick;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 0.08.sh,
      child: FormBuilderTextField(
        minLines: minLine,
        obscureText: isSecure,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        controller: controller,
        validator: validation,
        style: textStyle??H3BlackTextStyle,
        keyboardType: textInputType == TextInputType.multiline && isSecure ? TextInputType.text : textInputType,
        maxLines: isSecure ? 1 : maxLine, // Ensure maxLines is 1 when isSecure is true
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffixIcon != null
              ? InkWell(
            child: Icon(suffixIcon, size: 0.05.sw),
            onTap: suffixClick,
          )
              : null,
          label: Container(

            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(children: [
                TextSpan(text: "${hint ?? ''}", style: H3GrayTextStyle.copyWith(overflow: TextOverflow.ellipsis)),
                if (isRequired) TextSpan(text: "*", style: H4RedTextStyle),
              ]),
            ),
          ),
          errorStyle: H4RedTextStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius == null ? 15.r : radius!),
            borderSide: BorderSide(
              color: GrayDarkColor,
            ),
          ),
          contentPadding: EdgeInsets.all(20.h),
          filled: true,
          fillColor: fill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius == null ? 15.r : radius!),
            borderSide: BorderSide(
              color: GrayDarkColor,
            ),
          ),
        ), name: '',
      ),
    );
  }







/*
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 0.08.sh,
      child: TextFormField(
        obscureText: isSecure,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        controller: controller,
        validator: validation,
        style: H3BlackTextStyle,
        keyboardType: textInputType==TextInputType.multiline && isSecure ? TextInputType.text : textInputType,
        maxLines: maxLine!=null  && isSecure ?1 : maxLine,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? InkWell(
                  child: Icon(suffixIcon,size: 0.05.sw,),
                  onTap: suffixClick,
                )
              : null,
          label: RichText(
            text: TextSpan(children: [
              TextSpan(text: "${hint ?? ''}", style: H3GrayTextStyle),
              if (isRequired) TextSpan(text: "*", style: H4RedTextStyle),
            ]),
          ),
          errorStyle: H4RedTextStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius==null ? 15.r : radius!),
            borderSide: BorderSide(
              color: GrayDarkColor,
            ),
          ),
          contentPadding: EdgeInsets.all(20.h),
          filled: true,
          fillColor: fill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius==null ? 15.r : radius!),
            borderSide: BorderSide(
              color: GrayDarkColor,
            ),
          ),
        ),
      ),
    );
  }*/
}
