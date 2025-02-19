import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/components.dart';
import 'package:ali_pasha_graph/helpers/helper_class.dart';
import 'package:ali_pasha_graph/helpers/style.dart';

import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CartItemPage extends StatelessWidget {
  CartItemPage({Key? key}) : super(key: key);

  final logic = Get.find<CartItemLogic>();
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      appBar: AppBar(
        title: Text(
          'سلة المشتريات',
          style: H2BlackTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: 0.05.sh,
            decoration: const BoxDecoration(
              color: GrayLightColor,
            ),
            child: Obx(() {
              return Text(
                "${logic.carts.length} عنصر",
                style: H3GrayTextStyle,
              );
            }),
          ),
          Expanded(
            child: Obx(
              () {
                return Container(
                  color: WhiteColor,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                    children: [
                      ...List.generate(
                        logic.carts.length,
                        (index) {
                          var price =
                              (logic.carts[index].product?.is_discount == true
                                      ? logic.carts[index].product?.discount
                                      : logic.carts[index].product?.price) ??
                                  0;
                          return Container(
                            height: 0.3.sw,
                            width: 1.sw,
                            margin: EdgeInsets.only(bottom: 0.01.sh),
                            decoration: const BoxDecoration(
                                color: WhiteColor,
                                border: Border(
                                    bottom: BorderSide(
                                  color: GrayLightColor,
                                ))),
                            child: Row(
                              children: [
                                Container(
                                  width: 0.3.sw,
                                  height: 0.3.sw,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              "${logic.carts[index].product?.image}"),
                                          fit: BoxFit.cover)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.002.sw, vertical: 0.001.sh),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 0.6.sw,
                                            child: AutoSizeText(
                                              "${logic.carts[index].product?.name}",
                                              style: H3BlackTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              mainController.deleteFromCart(
                                                  product: logic
                                                      .carts[index].product!);
                                              await mainController
                                                  .refreshCart();
                                              logic.getCart();
                                            },
                                            child: const Icon(
                                              FontAwesomeIcons.x,
                                              color: RedColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 0.45.sw,
                                            child: AutoSizeText(
                                              "${logic.carts[index].product?.expert?.trim()}",
                                              style: H4RegularDark,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: true,
                                              wrapWords: true,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 0.037.sw,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                child: InkWell(
                                                  onTap: () async {
                                                    await mainController
                                                        .increaseQty(
                                                            productId: logic
                                                                .carts[index]
                                                                .product!
                                                                .id!);
                                                    logic.getCart();
                                                  },
                                                  child: const Icon(
                                                      FontAwesomeIcons
                                                          .circlePlus),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 0.01.sw,
                                              ),
                                              SizedBox(
                                                  height: 0.02.sh,
                                                  child: Text(
                                                    '${logic.carts[index].qty}',
                                                    style: H3BlackTextStyle,
                                                  )),
                                              SizedBox(
                                                width: 0.01.sw,
                                              ),
                                              SizedBox(
                                                child: InkWell(
                                                  onTap: () async {
                                                    print(
                                                        "ID:${logic.carts[index].product!.id!}");
                                                    await mainController
                                                        .decreaseQty(
                                                            productId: logic
                                                                .carts[index]
                                                                .product!
                                                                .id!);
                                                    logic.getCart();
                                                  },
                                                  child: const Icon(
                                                      FontAwesomeIcons
                                                          .circleMinus),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                      SizedBox(
                                        width: 0.67.sw,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (price > 0)
                                              AutoSizeText(
                                                "$price \$",
                                                style: H3BlackTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            if (price == 0)
                                              Text(
                                                "السعر غير معروف",
                                                style: H4RedTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            if (logic.carts[index].product
                                                    ?.is_delivery ==
                                                true)
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .truckFast,
                                                      color: Colors.green,
                                                      size: 0.04.sw,
                                                    ),
                                                    Text(
                                                      'الشحن متاح',
                                                      style: H4RegularDark
                                                          .copyWith(
                                                              color:
                                                                  Colors.green),
                                                    )
                                                  ],
                                                ),
                                              )
                                            else
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .truckFast,
                                                      color: Colors.red,
                                                      size: 0.04.sw,
                                                    ),
                                                    Text(
                                                      'الشحن غير متاح',
                                                      style: H4RegularDark
                                                          .copyWith(
                                                              color:
                                                                  Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Obx(
            () {
              return Visibility(
                visible: logic.carts.length > 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.01.sh,
                  ),
                  height: 0.3.sh,
                  width: 1.sw,
                  alignment: Alignment.center,
                  color: GrayLightColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.01.sh, horizontal: 0.02.sw),
                      decoration: BoxDecoration(
                          color: GrayWhiteColor,
                          border: Border(
                              bottom: BorderSide(
                                  color: WhiteColor, width: 0.005.sw))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'يفضل مراسلة التاجر قبل  الطلب',
                            style: H1RegularDark,
                          ),
                          Obx(() {
                            return Visibility(
                              child:   InkWell(
                              onTap: () async {
                                if (!isAuth()) {
                                  mainController.showToast(
                                      text: 'يرجى تسجيل الدخول أولاً',
                                      type: 'error');
                                  return;
                                }
                                if (mainController.loading.value) {
                                  mainController.showToast(
                                      text: 'جاري تحويلك إلى المحادثة');
                                  return;
                                }
                                StringBuffer message = StringBuffer();
                                message
                                    .write("السلام عليكم ورحمة الله وبركاته ");
                                message.write("\n");
                                message.write("  أريد الإستفسار عن بضاعة");
                                message.write("\n");
                                if (logic.carts != null &&
                                    logic.carts.isNotEmpty) {
                                  for (var item in logic.carts) {
                                    message.write(
                                        "معرف المنتج : ${item.product?.id}");
                                    message.write("\n");
                                    message.write(
                                        "المنتج : ${item.product?.name}");
                                    message.write("\n");
                                    message.write("العدد : ${item.qty}");
                                    message.write("\n");
                                    message.write(
                                        "سعر الوحدة : ${item.product?.is_discount == true ? item.product?.discount : item.product?.price}");
                                    message.write("\n");
                                    message.write("-------------------------");
                                    message.write("\n");
                                  }

                                  // حساب المجموع باستخدام fold
                                  double total = logic.carts.fold(0.0,
                                          (previousValue, element) {
                                        double elementPrice =
                                        element.product?.is_discount == true
                                            ? element.product?.discount ?? 0
                                            : element.product?.price ?? 0;
                                        int elementQty = element.qty ?? 0;
                                        return previousValue +
                                            (elementPrice * elementQty);
                                      });

                                  // إضافة المجموع
                                  message.write("المجموع : $total");
                                } else {
                                  // إذا كانت السلة فارغة
                                  message.write("المجموع : 0");
                                }

                                message.writeln("\n==========================");
                                HelperClass.connectWithSeller(
                                    phone: "${logic.cart.value?.seller?.phone}",
                                    sellerId: int.parse(
                                        "${logic.cart.value?.seller?.id}"),
                                    message: message.toString());
                                /*await mainController.createCommunity(
                                    sellerId: int.parse(
                                        "${logic.cart.value?.seller?.id}"),
                                    message: message.toString());*/
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 0.3.sw,
                                height: 0.08.sw,
                                decoration: BoxDecoration(
                                    color: RedColor,
                                    borderRadius: BorderRadius.circular(30.r)),
                                child: Text(
                                  'مراسلة التاجر',
                                  style: H3WhiteTextStyle,
                                ),
                              ),
                            ),visible: mainController.authUser.value?.id!=null,);
                          }),
                        ],
                      ),
                    ),

                      SizedBox(
                        height: 0.007.sh,
                      ),
                      Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.01.sh, horizontal: 0.02.sw),
                        decoration: BoxDecoration(
                            color: GrayWhiteColor,
                            border: Border(
                                bottom: BorderSide(
                                    color: WhiteColor, width: 0.005.sw))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'عنوان الشحن : ${logic.address.value}',
                                      style: H4RegularDark,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'رقم الهاتف : ${logic.phone.value}',
                                      style: H4RegularDark,
                                    ),
                                  )
                                ],
                              );
                            }),
                            if (mainController.authUser.value != null)
                              InkWell(
                                onTap: changeAddress,
                                child: const Icon(FontAwesomeIcons.solidEdit),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.01.sh, horizontal: 0.02.sw),
                        child: Column(
                          children: [
                            if (mainController.authUser.value != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الإجمالي',
                                    style: H3RegularDark,
                                  ),
                                  Text(
                                      "${logic.total.value.toStringAsFixed(2)} \$",
                                      style: H2BlackTextStyle.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black)),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Text(
                                    'يرجى تسجيل الدخول',
                                    style: H4RegularDark,
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 0.005.sh,
                            ),
                            if (mainController.authUser.value != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'اجور شحن علي باشا',
                                    style: H3RegularDark,
                                  ),
                                  Text(
                                      "${logic.totalShipping.value.toStringAsFixed(2)} \$",
                                      style: H2BlackTextStyle.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black)),
                                ],
                              )
                            else
                              Container(
                                height: 0.02.sh,
                              ),
                            SizedBox(
                              height: 0.005.sh,
                            ),
                            if (mainController.authUser.value != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'المجموع العام',
                                    style: H3RegularDark,
                                  ),
                                  Text(
                                      "${(logic.totalShipping.value + logic.total.value).toStringAsFixed(2)} \$",
                                      style: H2BlackTextStyle.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black)),
                                ],
                              )
                            else
                              Container(
                                height: 0.02.sh,
                              ),
                            SizedBox(
                              height: 0.009.sh,
                            ),
                            Expanded(
                              child: Obx(() {
                                if (logic.loading.value) {
                                  return InkWell(
                                    onTap: () async {
                                      // Get.toNamed(LOGIN_PAGE);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 0.6.sw,
                                      height: 0.08.sw,
                                      decoration: BoxDecoration(
                                          color: RedColor,
                                          borderRadius:
                                              BorderRadius.circular(150.r)),
                                      child: Text(
                                        'جاري إرسال الطلب',
                                        style: H3WhiteTextStyle,
                                      ),
                                    ),
                                  );
                                }
                                if (isAuth()) {
                                  return InkWell(
                                    onTap: () async {
                                      if (mainController
                                              .authUser.value?.city?.id ==
                                          null) {
                                        mainController.showToast(
                                            text:
                                                'يرجى تحديد مدينتك من الملف الشخصي لإكمال الطلب',
                                            type: 'error');
                                        return;
                                      }

                                      await logic.createOrder();
                                      Get.offNamed(MY_INVOICE_PAGE);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 0.6.sw,
                                      height: 0.08.sw,
                                      decoration: BoxDecoration(
                                          color: RedColor,
                                          borderRadius:
                                              BorderRadius.circular(150.r)),
                                      child: Text(
                                        'إرسال الطلب',
                                        style: H3WhiteTextStyle,
                                      ),
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () async {
                                      Get.toNamed(LOGIN_PAGE);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 0.6.sw,
                                      height: 0.08.sw,
                                      decoration: BoxDecoration(
                                          color: RedColor,
                                          borderRadius:
                                              BorderRadius.circular(150.r)),
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: H3WhiteTextStyle,
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  changeAddress() {
    Get.dialog(AlertDialog(
      backgroundColor: WhiteColor,
      content: Container(
        width: 1.sw,
        height: 0.3.sh,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'تعديل عنوان ورقم هاتف الشحن',
                style: H1RegularDark,
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: logic.addressController,
              style: H3RegularDark,
              decoration: InputDecoration(
                  label: Text(
                    'عنوان الشحن ',
                    style: H3RegularDark,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: GrayLightColor))),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: logic.phoneController,
              style: H3RegularDark,
              decoration: InputDecoration(
                  label: Text(
                    'رقم الهاتف',
                    style: H3RegularDark,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: GrayLightColor))),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                logic.address.value = logic.addressController.text;
                logic.phone.value = logic.phoneController.text;
                Get.back();
              },
              child: Container(
                width: 0.3.sw,
                height: 0.1.sw,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(150.r)),
                alignment: Alignment.center,
                child: Text(
                  'متابعة',
                  style: H3WhiteTextStyle,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 0.3.sw,
                height: 0.1.sw,
                decoration: BoxDecoration(
                    color: RedColor,
                    borderRadius: BorderRadius.circular(150.r)),
                alignment: Alignment.center,
                child: Text(
                  'إغلاق',
                  style: H3WhiteTextStyle,
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
