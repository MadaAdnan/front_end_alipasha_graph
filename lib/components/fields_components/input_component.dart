import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
    this.textStyle,
this.enabled,
    this.hint2,
    this.helperText

  });

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hint;
  final String? hint2;
  final String? helperText;
  final double width;
  final double? height;
  final bool isRequired;
  final bool? enabled;
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
  final Future<String>? Function()? suffixClick;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 0.08.sh,
      child: FormBuilderTextField(
        enabled: enabled ??true,
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
            onTap: suffixClick,
            child: Icon(suffixIcon, size: 0.05.sw),
          )
              : null,
          label:hint2==null? RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(children: [
              TextSpan(text: "${hint ?? ''}", style: H3GrayTextStyle.copyWith(overflow: TextOverflow.ellipsis)),
              if (isRequired) TextSpan(text: "*", style: H4RedTextStyle),
            ]),
          ):null,
          hintText: hint2,
          hintStyle: H2GrayOpacityTextStyle,
          helperText: helperText,
          helperStyle: H5RedTextStyle,
          errorStyle: H4RedTextStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius == null ? 15.r : radius!),
            borderSide: const BorderSide(
              color: GrayDarkColor,
            ),
          ),
          contentPadding: EdgeInsets.all(20.h),
          filled: true,
          fillColor: fill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius == null ? 15.r : radius!),
            borderSide: const BorderSide(
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
