import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);

  final logic = Get.find<FilterLogic>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0.03.sh,horizontal: 0.02.sw),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 0.03.sh),
              width: 1.sw,
              decoration: BoxDecoration(
                border:Border(bottom: BorderSide(color: DarkColor))
              ),
              child: Text('فلتر للبحث',style: H2BlackTextStyle,),
            ),
            Container(
              //color: RedColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              child: InputComponent(fill: WhiteColor,width: 1.sw,height: 0.05.sh,hint: 'بحث',controller: logic.searchController,),
            ),


          ],
        ),
      ),
    );
  }
}
