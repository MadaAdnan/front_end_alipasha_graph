import 'dart:ui';

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';

extension OrderEnum on String {
  getStatusOrder() {
    switch (this) {
      case 'pending':
        return "بإنتظار المراجعة";
      case 'complete':
        return "تم التسليم";
      case 'agree':
        return "تمت موافقة التاجر";
      case 'away':
        return "جاري الشحن";
      case 'canceled':
        return 'الطلب ملغي';
        default:
          return this;
    }
  }

  Color getStatusOrderColor() {
    switch (this) {
      case 'complete':
        return Colors.green;
      case 'agree':
        return OrangeColor;
      case 'away':
        return Colors.blueAccent;
      case 'canceled':
        return RedColor;
      default:
        return GrayLightColor;
    }
  }
}
