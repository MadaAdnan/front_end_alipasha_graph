import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();

    // بداية المسار
    path_0.moveTo(0, size.height * 0.8);

    // رسم منحنى دائري متناظر من الجانبين
    path_0.quadraticBezierTo(
      size.width * 0.5, // النقطة الوسطى على المحور الأفقي
      size.height , // النقطة السفلى للمنحنى في المنتصف
      size.width, // نهاية المنحنى على الحافة الأخرى
      size.height * 0.8, // نهاية المنحنى على المحور الرأسي
    );

    // إكمال المسار
    path_0.lineTo(size.width, size.height); // الانتقال إلى الزاوية اليمنى السفلية
    path_0.lineTo(size.width, 0);           // الانتقال إلى الزاوية اليمنى العليا
    path_0.lineTo(0, 0);                    // الانتقال إلى الزاوية اليسرى العليا
    path_0.lineTo(0, size.height);          // العودة إلى النقطة الأصلية
    path_0.close();                         // إغلاق المسار

    return path_0;
  }



  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
