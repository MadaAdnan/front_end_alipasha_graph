import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';

import 'logic.dart';

class AgreePrivacyPage extends StatelessWidget {
  final logic = Get.put(AgreePrivacyLogic());
  MainController mainController = Get.find<MainController>();
  RxBool selected = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        title: Text('سياسة الخصوصية وشروط الإستخدام', style: H3WhiteTextStyle,),
        backgroundColor: RedColor,),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        child: Obx(() {
          print('PRIVACY ${mainController.settings.value.privacy?.length}');
          if(mainController.loading.value
              && (mainController.settings.value.privacy==null || mainController.settings.value.privacy=='')){
            return Container(alignment: Alignment.center,width: 0.3.sw,child: ProgressLoading(width: 0.2.sw,),);
          }
          return Column(
            children: [
              Container(
                width: 1.sw,
                height: 0.75.sh,
                padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw, vertical: 0.01.sh),
                decoration: BoxDecoration(
                    color: GrayLightColor,
                    borderRadius: BorderRadius.circular(30.r)
                ),
                child: SingleChildScrollView(
                  child: Html(data: '${mainController.settings.value.privacy??''}',
                    style: {"*": Style.fromTextStyle(H3RegularDark.copyWith(
                        height: 0.003.sh))},),
                ),
              ),
              Obx(() {
                return CheckboxMenuButton(
                    value: selected.value, onChanged: (bool? value) {
                  selected.value = value ?? false;
                }, child: Text('أوافق على الشروط', style: H2RegularDark,));
              }),
              InkWell(
                onTap: () async {
                  if (selected.value) {
                    await mainController.storage.write('privacy', 'OK');
                    Get.offAllNamed(HOME_PAGE);
                  } else {
                    mainController.showToast(
                        text: 'يجب الموافقة على الشروط', type: 'error');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.2.sw, vertical: 0.015.sh),
                  decoration: BoxDecoration(
                      color: RedColor,
                      borderRadius: BorderRadius.circular(30.r)
                  ),
                  child: Text('موافق', style: H3WhiteTextStyle,),
                ),)
            ],
          );
        }),
      ),
    );
  }
}
