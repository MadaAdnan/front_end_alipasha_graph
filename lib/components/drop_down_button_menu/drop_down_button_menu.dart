import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/colors.dart';
import '../../helpers/style.dart';

class DropDownButtonMenu<T> extends StatelessWidget {
  DropDownButtonMenu({
    super.key,
    this.title,
    this.image,
    this.onChanged,
    this.width,
    this.items,
  });

  final double? width;
  final ImageProvider? image;
  final String? title;
  final List<DropdownMenuItem<T>>? items;
  final Function(T? value)? onChanged;
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.002.sh),
      width: width ?? 1.sw,
      child: DropdownButtonHideUnderline(
        key: key,
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Row(
                  children: [
                    if (image != null)
                      SizedBox(
                        width: 0.06.sw,
                        child: Image(
                          image: image!,
                        ),
                      ),
                    20.horizontalSpace,
                    Text(
                      "$title",
                      style: H3GrayTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          items: items,
          value: selectedValue,
          onChanged:onChanged,
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: WhiteColor,
            ),
            elevation: 2,
          ),
          iconStyleData: IconStyleData(
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 0.07.sw,
            iconEnabledColor: DarkColor,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: WhiteColor,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
