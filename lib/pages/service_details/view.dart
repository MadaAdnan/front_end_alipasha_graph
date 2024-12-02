import 'package:ali_pasha_graph/components/advice_component/view.dart';
import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';

import 'logic.dart';

class ServiceDetailsPage extends StatelessWidget {
  ServiceDetailsPage({Key? key}) : super(key: key);

  final logic = Get.find<ServiceDetailsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        backgroundColor: WhiteColor,
        elevation: 6,
        title: Obx(() {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'الخدمات - ${logic.serviceModel.value?.name ?? ''} ',
              style: H4BlackTextStyle,
            ),
          );
        }),
      ),
      body: Obx(() {
        if(logic.loading.value){
          return Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 1.sh,
            child: ProgressLoading(width: 0.2.sw,),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "${logic.serviceModel.value?.name}",
                  style: H1BlackTextStyle,
                ),
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${logic.serviceModel.value?.city?.name}",
                          style: H4GrayTextStyle),
                      TextSpan(
                          text: " - ${logic.serviceModel.value?.category
                              ?.name}",
                          style: H4GrayTextStyle),
                      TextSpan(
                          text: " - ${logic.serviceModel.value?.sub1?.name}",
                          style: H4GrayTextStyle),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0.05.sh,),
              Container(
                padding: EdgeInsets.all(0.02.sw),
                decoration: BoxDecoration(
                  color: GrayWhiteColor,
                  borderRadius: BorderRadius.circular(30.r),
                  
                ),
                alignment: Alignment.center,
                child: Html(
                  data: "${logic.serviceModel.value?.info} ${logic
                      .serviceModel.value?.url!=''?"${logic
                      .serviceModel.value?.url}":""}"
                      " ${logic
                      .serviceModel.value?.email!='' ? "<br/><br/> <a href='${logic
                      .serviceModel.value?.email}'>البريد الإلكتروني</a>":''}"
                      "${ logic
                      .serviceModel.value?.phone!=''?"<br/><br/> <a href='https://wa.me/${logic
                      .serviceModel.value?.phone}'>الهاتف</a>":''}",
                  style: {
                    "*": Style.fromTextStyle(H3BlackTextStyle),
                    "a": Style.fromTextStyle(H4RedTextStyle)
                  },
                  onAnchorTap: (url, context, attributes, element) =>
                      openUrl(url: "$url"),
                ),
              ),

            ],
          ),
        );
      }),
    );
  }
}
