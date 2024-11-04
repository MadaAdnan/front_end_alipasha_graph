import 'dart:ui';

import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension CategoryTypeEnum on String {
  String toCategoryTypeLabel() {
    switch (this) {
      case "product":
        return "منتج";

      case "job":
        return "شاغر وظيفي";

      case "search_job":
        return "باحث عن عمل";

      case "news":
        return "خبر";

      case "tender":
        return "مناقصة";

      case "service":
        return "خدمة";

      default:
        return this;
    }
  }

  String toCategoryTypeColor() {
    switch (this) {
      case "product":
        return "منتج";

      case "job":
        return "شاغر وظيفي";

      case "search_job":
        return "باحث عن عمل";

      case "news":
        return "خبر";

      case "tender":
        return "مناقصة";

      case "service":
        return "خدمة";

      default:
        return this;
    }
  }

  String toCategoryTypeIcon() {
    switch (this) {
      case "product":
        return "منتج";

      case "job":
        return "شاغر وظيفي";

      case "search_job":
        return "باحث عن عمل";

      case "news":
        return "خبر";

      case "tender":
        return "مناقصة";

      case "service":
        return "خدمة";

      default:
        return this;
    }
  }

  String toLevelProduct() {
    switch (this) {
      case "news":
        return "جديد";
      case "special":
        return "مميز";
      case "normal":
        return "عادي";
      default:
        return this;
    }
  }

  String weatherType() {
    switch (this) {
      case "Sunny":
      case "Clear":
        return "مشمس";
      case "Partly Cloudy":
        return "غائم جزئيا";
      case "":
        return "صحو";
      case "Cloudy":
      case "Overcast":
      case "Light drizzl":
        return "غائم";
      case "Patchy rain nearby":
      case "Patchy rain possible":
      case "Light rain":
      case "Light rain shower":
        return "أمطار متفرقة";
      case "Moderate rain":
      case "Light freezing rain":
        return "ممطر";

      case "Light snow showers":
      case "Light snow":
        return "ثلوج خفيفة";
      case "Heavy snow":
      case "Moderate snow":
      case "Moderate or heavy snow showers":
        return "مثلج";
      case "Light sleet":
        return "صقيع";
      default:
        print(this);
        return this;
    }
  }

  String OrderStatus() {
    switch (this) {
      case 'pending':
        return "بالإنتظار";

      case 'success':
        return "منتهي";
      case 'canceled':
        return "ملغي";
        default:
          return this;
    }
  }
}

extension FormatNumber on String {
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

  String toFormatNumberK() {
    int number = int.tryParse(this) ?? 0;
    if (number >= 1000000) {
      return (number / 1000000).toStringAsFixed(1) + ' M';
    } else if (number >= 1000) {
      return (number / 1000).toStringAsFixed(1) + ' K';
    } else {
      return this.toString();
    }
  }

  String planDuration() {
    switch (this) {
      case 'free':
        return "مجاني";

      case 'month':
        return "شهرياً";

      case 'year':
        return "سنويا";

      default:
        return this;
    }
  }
}

extension ProductActiveEnum on String {
  String active2Arabic() {
    switch (this) {
      case "active":
        return "مفعل";


      case "pending":
        return "بالإنتظار";

      case "block":
        return "محظور";

      default:
        return this;
    }
  }

  IconData? active2Icon() {
    switch (this) {
      case "active":
        return FontAwesomeIcons.check;


      case "pending":
        return FontAwesomeIcons.clock;

      case "block":
        return FontAwesomeIcons.ban;

      default:
        return null;
    }
  }

  Color active2Color() {
    switch (this) {
      case "active":
        return Colors.green;


      case "pending":
        return OrangeColor;

      case "block":
        return RedColor;

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
