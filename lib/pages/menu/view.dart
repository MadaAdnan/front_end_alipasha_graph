import 'dart:io';
import 'dart:math';

import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/cart_helper.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

import '../../Global/main_controller.dart';
import '../../components/drop_down_button_menu/drop_down_button_menu.dart';
import 'logic.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  final logic = Get.find<MenuLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: WhiteColor,
        appBar: PreferredSize(
          preferredSize: Size(1.sw, 0.4.sh),
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.02.sw),
            color: WhiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return InkWell(
                    onTap: () {
                      if (isAuth()) {
                        Get.offAndToNamed(PROFILE_PAGE);
                      } else {
                        Get.offAndToNamed(LOGIN_PAGE);
                      }
                    },
                    child: Container(
                      width: 0.6.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(0.005.sw),
                            decoration: const BoxDecoration(
                                color: GrayDarkColor, shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundColor: WhiteColor,
                              minRadius: 0.05.sw,
                              maxRadius: 0.07.sw,
                              child: Container(
                                width: 0.15.sw,
                                height: 0.13.sw,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GrayDarkColor,
                                  image: DecorationImage(
                                      image: getLogo() != null
                                          ? CachedNetworkImageProvider(
                                              '${getLogo()}',
                                            )
                                          : getUserImage(),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Text(
                            '${getName()}',
                            style: H3GrayTextStyle,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  );
                }),
                badges.Badge(
                  child: Icon(
                    FontAwesomeIcons.bell,
                    size: 0.08.sw,
                  ),
                  onTap: () {},
                  badgeContent: Text(
                    '10',
                    style: H4WhiteTextStyle,
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                color: GrayDarkColor,
                height: 0.0001.sw,
              ),
              if (isAuth())
                Container(
                  width: 1.sw,
                  height: 0.3.sw,
                  color: RedColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'رصيدك الحالي : ',
                              style: H3WhiteTextStyle,
                            ),
                            TextSpan(
                              text:
                                  '${logic.mainController.authUser.value?.totalBalance ?? 0} \$',
                              style: H3WhiteTextStyle,
                            ),
                          ]),
                        );
                      }),
                      30.verticalSpace,
                      InkWell(
                        onTap: () {
                          /*  Get.defaultDialog(
                              titlePadding: EdgeInsets.symmetric(
                                  horizontal: 0.03.sw, vertical: 0.03.sh),
                              title: "شحن رصيد الإعلانات",
                              titleStyle: H3OrangeTextStyle,
                              backgroundColor: WhiteColor,
                              content: Container(
                                child: Column(
                                  children: [
                                    InputComponent(
                                      controller: logic.codeController,
                                      hint: 'الكود',
                                      width: 0.7.sw,
                                      fill: WhiteColor,
                                    ),
                                    10.verticalSpace,
                                    InputComponent(
                                      hint: 'كلمة المرور',
                                      controller: logic.passController,
                                      width: 0.7.sw,
                                      fill: WhiteColor,
                                    ),
                                    10.verticalSpace,
                                    Obx(() {
                                      if(logic.loadingBay.value){
                                        return Center(child: CircularProgressIndicator(),);
                                      }
                                      return InkWell(
                                        onTap: () async {

                                          bool res = await logic.charge();
                                          Get.back();
                                          if (res) {

                                           logic.codeController.clear();
                                           logic.passController.clear();
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 0.7.sw,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 0.01.sh,
                                            horizontal: 0.02.sw,
                                          ),
                                          decoration: BoxDecoration(
                                            color: RedColor,
                                            borderRadius:
                                            BorderRadius.circular(15.r),
                                          ),
                                          child: Text(
                                            'أرسل للشحن',
                                            style: H3WhiteTextStyle,
                                          ),
                                        ),
                                      );
                                    }),
                                    30.verticalSpace,
                                    InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 0.7.sw,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 0.01.sh,
                                          horizontal: 0.02.sw,
                                        ),
                                        decoration: BoxDecoration(
                                          color: GrayDarkColor,
                                          borderRadius:
                                          BorderRadius.circular(15.r),
                                        ),
                                        child: Text(
                                          'لا املك كوبون',
                                          style: H3WhiteTextStyle,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));*/
                          Get.dialog(
                            AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("شحن رصيد الإعلانات",
                                      style: H3OrangeTextStyle),
                                  IconButton(
                                      onPressed: () {
                                        logic.message.value = null;
                                        logic.passController.clear();
                                        logic.codeController.clear();
                                        Get.back();
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                              backgroundColor: WhiteColor,
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InputComponent(
                                      controller: logic.codeController,
                                      hint: 'الكود',
                                      width: 0.7.sw,
                                      fill: WhiteColor,
                                    ),
                                    10.verticalSpace,
                                    InputComponent(
                                      hint: 'كلمة المرور',
                                      controller: logic.passController,
                                      width: 0.7.sw,
                                      fill: WhiteColor,
                                    ),
                                    10.verticalSpace,
                                    Obx(() => Visibility(
                                          child: Text(
                                            '${logic.message.value}',
                                            style: H4RedTextStyle,
                                          ),
                                          visible: logic.message.value != null,
                                        )),
                                    20.verticalSpace,
                                    Obx(() {
                                      print(logic.message.value);
                                      if (logic.loadingBay.value) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return InkWell(
                                        onTap: () async {
                                          String? res = await logic.charge();
                                          if (res != null) {
                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              messageBox(
                                                  title: 'فشلت العملية',
                                                  message: '$res');
                                            });
                                          } else {
                                            logic.codeController.clear();
                                            logic.passController.clear();
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 0.7.sw,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 0.01.sh,
                                            horizontal: 0.02.sw,
                                          ),
                                          decoration: BoxDecoration(
                                            color: RedColor,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Text(
                                            'أرسل للشحن',
                                            style: H3WhiteTextStyle,
                                          ),
                                        ),
                                      );
                                    }),
                                    30.verticalSpace,
                                    InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 0.7.sw,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 0.01.sh,
                                          horizontal: 0.02.sw,
                                        ),
                                        decoration: BoxDecoration(
                                          color: GrayDarkColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Text(
                                          'لا املك كوبون',
                                          style: H3WhiteTextStyle,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 0.5.sw,
                          height: 0.06.sh,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.02.sw),
                              color: WhiteColor),
                          child: Text(
                            'شحن رصيد الإعلانات',
                            style: H3RedTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw, vertical: 0.002.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildWidget(
                        image: 'assets/images/png/home.png',
                        title: 'عرض متجري',
                        onTap: () {
                          if (isAuth()) {
                            Get.offAndToNamed(PROFILE_PAGE);
                          } else {
                            Toast.show('لم تقم بتسجيل الدخول');
                            Get.offAndToNamed(LOGIN_PAGE);
                          }
                        }),
                    _buildWidget(
                      onTap: () {
// mainController.emptyCart();
                        Get.offAndToNamed(CART_SELLER);
                      },
                      image: 'assets/images/png/cart.png',
                      title: 'سلة المشتريات',
                      child: Obx(() {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 0.01.sw, horizontal: 0.01.sw),
                          decoration: BoxDecoration(
                              color: RedColor, shape: BoxShape.circle),
                          child: Text(
                            '${mainController.carts.length}',
                            style: H4WhiteTextStyle,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw, vertical: 0.002.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildWidget(
                        onTap: () {
                          Get.offAndToNamed(CREATE_PRODUCT_PAGE);
                        },
                        image: 'assets/images/png/create.png',
                        title: 'إضافة منتج'),
                    _buildWidget(
                        image: 'assets/images/png/dependancy.png',
                        onTap: () {
                          Get.offAndToNamed(PARTNER_PAGE);
                        },
                        title: 'المراكز المعتمدة'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw, vertical: 0.002.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildWidget(
                        onTap: () async {
                          openUrl(url: "https://play.google.com/store/apps/details?id=com.mada.company.ali.basha");
                          // طلب الإذن
                         /* final permissionGranted = await requestStoragePermission();
                          if (permissionGranted) {
                            // جلب المسار
                            final path = await getAppPath();
                            final filePath = '$path/app.apk'; // أو '$path/app.ipa'

                            // مشاركة الملف
                            await shareAppFile(filePath);
                          } else {
                            print('الإذن مرفوض');
                          }*/
                        },
                        image: 'assets/images/png/share.png',
                        title: 'مشاركة التطبيق'),
                    _buildWidget(
                        onTap: () {
                          Get.offAndToNamed(SHIPPING_PAGE);
                        },
                        image: 'assets/images/png/shipping.png',
                        title: 'خدمة الشحن'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.01.sw, vertical: 0.002.sh),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildWidget(
                        onTap: () {
                          Get.offAndToNamed(PLAN_PAGE);
                        },
                        image: 'assets/images/png/upgrade.png',
                        title: 'ترقية الحساب'),
                    _buildWidget(
                        onTap: () {
                          Get.offAndToNamed(NEWS_PAGE);
                        },
                        image: 'assets/images/png/last_news.png',
                        title: 'آخر الأخبار'),
                  ],
                ),
              ),
              Obx(() {
                return _dropDownButton(
                  selectedValue: logic.selectedValue1.value,
                  title: 'المساعدة والدعم',
                  img: 'assets/images/png/quastion.png',
                  items: [
                    DropdownMenuItem<String>(
                      value: 'asks',
                      onTap: () {
                        logic.selectedValue1.value = 'asks';
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                            child: const Image(
                              image:
                                  AssetImage('assets/images/png/support.png'),
                            ),
                          ),
                          20.horizontalSpace,
                          Text(
                            'الأسئلة الشائعة',
                            style: H3GrayTextStyle,
                          )
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'contact_us',
                      onTap: () {
                        logic.selectedValue1.value = 'contact_us';
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                            child: const Image(
                              image: AssetImage(
                                  'assets/images/png/contact_us.png'),
                            ),
                          ),
                          20.horizontalSpace,
                          Text(
                            'إتصل بنا',
                            style: H3GrayTextStyle,
                          )
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'privacy',
                      onTap: () {
                        logic.selectedValue1.value = 'privacy';
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                            child: const Image(
                              image:
                                  AssetImage('assets/images/png/privacy.png'),
                            ),
                          ),
                          20.horizontalSpace,
                          Text(
                            'سياسة الخصوصية',
                            style: H3GrayTextStyle,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
              Obx(() {
                return _dropDownButton(
                  img: 'assets/images/png/settings.png',
                  selectedValue: logic.selectedValue2.value,
                  title: 'الإعدادات',
                  items: [
                    DropdownMenuItem<String>(
                      value: 'settings',
                      onTap: () {
                        logic.selectedValue2.value = 'settings';
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                            child: Image(
                              image:
                                  AssetImage('assets/images/png/settings.png'),
                            ),
                          ),
                          20.horizontalSpace,
                          Text(
                            'الإعدادات',
                            style: H3GrayTextStyle,
                          )
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'about',
                      onTap: () {
                        logic.selectedValue2.value = 'about';
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 0.06.sw,
                            child: Image(
                              image: AssetImage('assets/images/png/about.png'),
                            ),
                          ),
                          20.horizontalSpace,
                          Text(
                            'من نحن',
                            style: H3GrayTextStyle,
                          )
                        ],
                      ),
                    ),
                    if (isAuth())
                      DropdownMenuItem<String>(
                        value: 'logOut',
                        onTap: () {
                          logic.selectedValue2.value = 'logOut';
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.06.sw,
                              child: Image(
                                image:
                                    AssetImage('assets/images/png/log_out.png'),
                              ),
                            ),
                            20.horizontalSpace,
                            Text(
                              'تسجيل الخروج',
                              style: H3GrayTextStyle,
                            )
                          ],
                        ),
                      )
                  ],
                );
              }),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidget({
    required String image,
    required String title,
    Widget? child,
    Function()? onTap,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: 0.49.sw,
          height: 0.3.sw,
          child: Card(
            elevation: 4,
            color: WhiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 0.095.sw,
                      height: 0.095.sw,
                      child: Image(image: AssetImage(image))),
                  if (child == null)
                    Text(
                      title,
                      style: H2BlackTextStyle,
                    ),
                  if (child != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: H2BlackTextStyle,
                        ),
                        child,
                      ],
                    ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _dropDownButton(
      {required List<DropdownMenuItem<String>> items,
      required String title,
      required String img,
      String? selectedValue}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.002.sh),
      width: 1.sw,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.06.sw,
                      child: Image(
                        image: AssetImage(
                          img,
                        ),
                      ),
                    ),
                    20.horizontalSpace,
                    Text(
                      title,
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
          onChanged: (value) {
            if (['privacy', 'asks', 'contact_us'].contains(value)) {
              logic.changeSelectedValue1(value);
            }
            if (['about', 'settings', 'logOut'].contains(value)) {
              logic.changeSelectedValue2(value);
            }
          },
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

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // دالة لجلب المسار
  Future<String> getAppPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // دالة لمشاركة الملف
  Future<void> shareAppFile(String filePath) async {
    final file = XFile(filePath);

      await Share.shareXFiles([file], text: 'قم بتنزيل تطبيقي من هنا!');
  }
}
