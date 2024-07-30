
import 'dart:ui';

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
extension CategoryTypeEnum on String{
  String toCategoryTypeLabel() {
    switch (this) {
      case "product":
        return "منتج";
        break;
      case "job":
        return "شاغر وظيفي";
        break;
      case "search_job":
        return "باحث عن عمل";
        break;
      case "news":
        return "خبر";
        break;
      case "tender":
        return "مناقصة";
        break;
      case "service":
        return "خدمة";
        break;
      default:
        return this;
    }
  }

  String toCategoryTypeColor() {
    switch (this) {
      case "product":
        return "منتج";
        break;
      case "job":
        return "شاغر وظيفي";
        break;
      case "search_job":
        return "باحث عن عمل";
        break;
      case "news":
        return "خبر";
        break;
      case "tender":
        return "مناقصة";
        break;
      case "service":
        return "خدمة";
        break;
      default:
        return this;
    }
  }

  String toCategoryTypeIcon() {
    switch (this) {
      case "product":
        return "منتج";
        break;
      case "job":
        return "شاغر وظيفي";
        break;
      case "search_job":
        return "باحث عن عمل";
        break;
      case "news":
        return "خبر";
        break;
      case "tender":
        return "مناقصة";
        break;
      case "service":
        return "خدمة";
        break;
      default:
        return this;
    }
  }
}

extension FormatNumber on String{
  String toFormatNumber() {
    double number = double.tryParse(this) ?? 0;
    if (number >= 1000000) {
      return (number / 1000000).toStringAsFixed(2) + ' مليون';
    } else if (number >= 1000) {
      return (number / 1000).toStringAsFixed(2) + ' ألف';
    } else {
      return this.toString();
    }
  }
}
extension ProductActiveEnum on String {
 String active2Arabic() {
    switch (this) {
      case "active":
        return "مفعل";
        break;

      case "pending":
        return "بالإنتظار";
        break;
      case "block":
        return "محظور";
        break;
      default:
        return this;
    }
  }

  IconData? active2Icon() {
    switch (this) {
      case "active":
        return FontAwesomeIcons.check;
        break;

      case "pending":
        return FontAwesomeIcons.clock;
        break;
      case "block":
        return FontAwesomeIcons.ban;
        break;
      default:
        return null;
    }
  }

  Color active2Color() {
    switch (this) {
      case "active":
        return Colors.green;
        break;

      case "pending":
        return OrangeColor;
        break;
      case "block":
        return RedColor;
        break;
      default:
        return DarkColor;
    }
  }
}

extension IsActiveEnum on bool {
  String booleanToArabic() {
    if (this) {
      return "مفعل";
    }
    return "غير مفعل";
  }

  IconData booleanToIcon() {
    if (this) {
      return FontAwesomeIcons.circleCheck;
    }
    return FontAwesomeIcons.lock;
  }


  Color booleanToColor() {
    if (this) {
      return Colors.green;
    }
    return RedColor;
  }
}
