import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeSliverAppBarComponent extends StatelessWidget {
  HomeSliverAppBarComponent({Key? key}) : super(key: key);
MainController mainController =Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0.197.sh,
      expandedHeight: 0.22.sh,
      collapsedHeight: 0.197.sh,
      floating: true,
      pinned: false,
      centerTitle: true,
      primary: true,
      foregroundColor: WhiteColor,
      backgroundColor: WhiteColor,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.fadeTitle],
        collapseMode: CollapseMode.parallax,
        expandedTitleScale: 1,
        titlePadding: EdgeInsets.only(bottom: 55),
        title: Container(
          color: WhiteColor,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 1.sw,
                color: WhiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 0.4.sw,
                      child: Image(
                        image: Svg(
                            'assets/images/svg/ali-pasha-horizantal-logo.svg',
                            color: RedColor,
                            source: SvgSource.asset),
                        color: RedColor,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.008.sw),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            FontAwesomeIcons.search,
                            size: 55.w,
                            color: RedColor,
                          ),
                          20.horizontalSpace,
                          MaterialButton(
                            color: RedColor,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  FontAwesomeIcons.towerCell,
                                  color: WhiteColor,
                                  size: 45.w,
                                ),
                                10.horizontalSpace,
                                Text(
                                  'Live',
                                  style: H4WhiteTextStyle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              10.verticalSpace,
              Container(
                width: 0.4.sw,
                height: 0.052.sh,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.home,
                        size: 55.w,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: RedColor,
                            style: BorderStyle.solid,
                            width: 0.002.sh,
                          ),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.bookOpen,
                          size: 55.w,
                          color: RedColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.headset,
                        size: 55.w,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.arrowTrendDown,
                        size: 55.w,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.comments,
                        size: 55.w,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(MENU_PAGE);
                      },
                      icon: Icon(
                        FontAwesomeIcons.bars,
                        size: 75.w,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: GrayDarkColor,
                height: 0.0017.sh,
              ),
            ],
          ),
        ),
        centerTitle: true,
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(PROFILE_PAGE);
              },
              child: Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.013.sh),
                margin: EdgeInsets.only(top: 108),
                width: double.infinity,
                height: 0.071.sh,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                     padding: EdgeInsets.all(0.002.sw),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: GrayDarkColor,
                      ),

                      child: Container(
                        padding: EdgeInsets.all(0.002.sw),
                        decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          color: WhiteColor,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(0.002.sw),
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Obx(() {
                            return Container(
                              width: 0.1.sw,
                              height: 0.1.sw,
                              decoration: BoxDecoration(shape: BoxShape.circle,image:DecorationImage(image: getLogo()!=null?NetworkImage('${getLogo()}'): getUserImage())),

                            );
                          }),
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(CREATE_PRODUCT_PAGE);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          alignment: Alignment.centerRight,
                          height: 0.055.sh,
                          decoration: BoxDecoration(
                            color: WhiteColor,
                            boxShadow: [
                              BoxShadow(color: GrayDarkColor, blurRadius: 3),
                              BoxShadow(
                                  color: GrayDarkColor.withOpacity(0.4),
                                  blurRadius: 3),
                            ],
                            borderRadius: BorderRadius.circular(50.w),
                          ),
                          child: Text(
                            'ماذا تفكر أن تنشر ...',
                            style: H3GrayTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: GrayDarkColor,
              height: 0.0017.sh,
            ),
          ],
        ),
      ),
    );
  }
}
