import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpandSearch extends StatelessWidget {
  ExpandSearch({super.key, this.onChange, this.controller,this.onEditDone});

  RxDouble width = RxDouble(0.08.sw);
  RxBool isExpanded = RxBool(false);
  final TextEditingController? controller;
  final String Function(String? value)? onChange;
  final String? Function()? onEditDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Obx(() {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            alignment: Alignment.centerLeft,
            width: width.value,
            height: 0.06.sh,
            child: isExpanded.value
                ? InputComponent(
              prefix: GestureDetector(
                child: Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 0.01.sw, horizontal: 0.01.sw),
                  child: Icon(
                    Icons.search,
                    color: WhiteColor,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: DarkColor.withOpacity(0.7)),
                ),

                onTap: () {
                  isExpanded.value = !isExpanded.value;
                  width.value = isExpanded.value == true ? 0.7.sw : 0.08.sw;
                },
              ),
                    controller: controller,
                    onChanged: onChange,
                    fill: DarkColor.withOpacity(0.7),
                    radius: 100.r,
                    hint: 'بحث ...',
                    minLine: 1,
                    textInputType: TextInputType.text,
                    textStyle: H3WhiteTextStyle,
                    onEditingComplete: onEditDone,
                    width: 0.7.sw,
                  )
                : Container(child:  GestureDetector(
              child: Container(
                padding:
                EdgeInsets.symmetric(vertical: 0.01.sw, horizontal: 0.01.sw),
                child: Icon(
                  Icons.search,
                  color: WhiteColor,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: DarkColor.withOpacity(0.7)),
              ),
              onTap: () {
                isExpanded.value = !isExpanded.value;
                width.value = isExpanded.value == true ? 0.7.sw : 0.08.sw;
              },
            ),),
          );
        }),
        Spacer(),
      ],
    );
  }
}
