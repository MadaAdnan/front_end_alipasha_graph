import 'dart:ui';

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// horizontal Padding
final shp = 0.01.sw;
final mhp = 0.02.sw;
final lhp = 0.04.sw;

// vertical Padding
final slp = 0.01.sh;
final mlp = 0.02.sh;
final llp = 0.04.sh;

/// space Horizontal
final smallHSpace = SizedBox(
  width: shp,
);
final midHSpace = SizedBox(
  width: mhp,
);
final largeHSpace = SizedBox(
  width: lhp,
);

/// space Vertical
final smallVSpace = SizedBox(
  height: slp,
);
final midVSpace = SizedBox(
  height: mlp,
);
final largeVSpace = SizedBox(
  height: llp,
);

double H0SIZE = 60.sp;
final H0GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H0SIZE);
final H0GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H0SIZE);
final H0RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H0SIZE);
final H0OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H0SIZE);
final H0BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H0SIZE);
final H0WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H0SIZE);
final H0RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H0SIZE);

/// Nwe Styles H1
double H1SIZE = 50.sp;
final H1GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H1SIZE);
final H1GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H1SIZE);
final H1RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H1SIZE);
final H1OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H1SIZE);
final H1BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H1SIZE);
final H1WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H1SIZE);
final H1RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H1SIZE);

/// H2 Style
double H2SIZE = 45.sp;
final H2GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H2SIZE);
final H2GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H2SIZE);
final H2RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H2SIZE);
final H2RedTextBoldStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.w900,
    fontSize: H2SIZE);
final H2OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H2SIZE);
final H2BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H2SIZE);
final H2WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H2SIZE);
final H2RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H2SIZE);

/// H3 Style
double H3SIZE = 40.sp;
final H3GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H3SIZE);
final H3GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H3SIZE);
final H3RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H3SIZE);
final H3OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H3SIZE);
final H3BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H3SIZE);
final H3WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H3SIZE);
final H3RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H3SIZE);

/// H4 Style
double H4SIZE = 35.sp;
final H4GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H4SIZE);
final H4GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H4SIZE);
final H4RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H4SIZE);
final H4OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H4SIZE);
final H4BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H4SIZE);
final H4WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H4SIZE);
final H4RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H4SIZE);

/// H5 Style
double H5SIZE = 30.sp;
final H5GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H5SIZE);
final H5GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H5SIZE);
final H5RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H5SIZE);
final H5OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H5SIZE);
final H5BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H5SIZE);
final H5WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H5SIZE);
final H5RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H5SIZE);

/// H6 Style
double H6SIZE = 25.sp;
final H6GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H6SIZE);
final H6GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H6SIZE);
final H6RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H6SIZE);
final H6OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H6SIZE);
final H6BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H6SIZE);
final H6WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H6SIZE);
final H6RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H6SIZE);

/// H7 Style
double H7SIZE = 20.sp;
final H7GrayOpacityTextStyle = TextStyle(
    
    color: SubTitleColor,
    fontWeight: FontWeight.bold,
    fontSize: H7SIZE);
final H7GrayTextStyle = TextStyle(
    
    color: GrayDarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H7SIZE);
final H7RedTextStyle = TextStyle(
    
    color: PrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H7SIZE);
final H7OrangeTextStyle = TextStyle(
    
    color: SecondaryColor,
    fontWeight: FontWeight.bold,
    fontSize: H7SIZE);
final H7BlackTextStyle = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.bold,
    fontSize: H7SIZE);
final H7WhiteTextStyle = TextStyle(
    
    color: WhiteColor,
    fontWeight: FontWeight.bold,
    fontSize: H7SIZE);
final H7RegularDark = TextStyle(
    
    color: DarkColor,
    fontWeight: FontWeight.w400,
    fontSize: H7SIZE);
