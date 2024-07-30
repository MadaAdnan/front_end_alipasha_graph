import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

// 2226 heght all screen
class HomeAppBarComponent extends StatelessWidget
    implements PreferredSizeWidget {


  HomeAppBarComponent({Key? key})
      : super(key: key);
  double max_height = 0.115.sh;
  MainController mainController = Get.find<MainController>();


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: WhiteColor,
        padding: EdgeInsets.symmetric(horizontal: 0.003.sw, vertical: 2),
        width: double.infinity,
        height: mainController.is_show_home_appbar.value ? 0.2.sh : 0.184.sh,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: WhiteColor,
              height: 0.044.sh,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 0.35.sw,
                    child: const Image(
                      image: Svg(
                          'assets/images/svg/ali-pasha-horizantal-logo.svg',
                          color: RedColor, source: SvgSource.asset),
                      color: RedColor,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FontAwesomeIcons.search,
                          size: 70.w,
                          color: RedColor,
                        ),
                        20.horizontalSpace,
                        SizedBox(
                          width: 0.21.sw,
                          child: MaterialButton(
                            color: RedColor,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  FontAwesomeIcons.towerCell,
                                  color: WhiteColor,
                                  size: 50.w,
                                ),
                                15.horizontalSpace,
                                Text(
                                  'Live',
                                  style: H4WhiteTextStyle,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            10.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 0.071.sh,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.home,
                        size: 65.w,
                      )),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: RedColor,
                                  style: BorderStyle.solid,
                                  width: 0.002.sh))),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.bookOpen,
                            size: 65.w,
                            color: RedColor,
                          ))),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.headset,
                        size: 65.w,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.arrowTrendDown,
                        size: 65.w,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.comments,
                        size: 65.w,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.bars,
                        size: 75.w,
                      )),
                ],
              ),
            ),
            Divider(
              color: GrayDarkColor,
              height: 0.0017.sh,
            ),
            if (mainController.is_show_home_appbar.value)
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 0.013.sh),
                  width: double.infinity,
                  height: 0.071.sh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: const AssetImage('assets/images/png/user.png'),
                        height: 100.h,
                      ),
                      10.horizontalSpace,
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: Alignment.centerRight,
                            height: 0.055.sh,
                            decoration: BoxDecoration(
                              color: WhiteColor,
                              boxShadow: [
                                const BoxShadow(color: GrayDarkColor, blurRadius: 3),
                                BoxShadow(color: GrayDarkColor.withOpacity(0.4),
                                    blurRadius: 3)
                              ],
                              borderRadius: BorderRadius.circular(50.w),
                            ),
                            child: Text(
                              'ماذا تفكر أن تنشر ...', style: H3GrayTextStyle,),
                          ))
                    ],
                  ),
                ),
              ),
            if (mainController.is_show_home_appbar.value)
              Divider(
                color: GrayDarkColor,
                height: 0.0017.sh,
              ),
          ],
        ),
      );
    });

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    if (mainController.is_show_home_appbar.value) {
      max_height = 0.19.sh;
    }
    return Size(double.infinity, Get.height * max_height);
  }
}
