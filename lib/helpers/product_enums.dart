import 'dart:ui';

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/material.dart';

extension ProductEnums on String {
  getStatusProduct() {
    switch (this) {
      case 'pending':
        return "بإنتظار المراجعة";
      case 'active':
        return "مفعل";
      case 'block':
        return "محظور";

      case 'hidden':
        return 'مخفي';
      default:
        return this;
    }
  }
  Color getStatusProductColor() {
    switch (this) {
      case 'pending':
        return Colors.green;
      case 'active':
        return OrangeColor;
      case 'block':
        return RedColor;
      case 'hidden':
        return Colors.blueAccent;
      default:
        return GrayLightColor;
    }
  }
}