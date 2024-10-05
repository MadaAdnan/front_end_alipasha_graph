import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customTextStyle(
    {double? size,
      FontWeight? weight,
      Color? color,
      TextDecoration? textDecoration}) {
  return GoogleFonts.alexandria(
    color: color ?? GrayLightColor,
    fontSize: size ?? 35.sp,
    fontWeight: weight ?? FontWeight.w400,
    decoration: textDecoration ?? TextDecoration.none,);
}