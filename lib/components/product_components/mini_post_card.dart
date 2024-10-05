import 'dart:math';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/components/seller_name_component.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:dio/dio.dart' as dio;

class MiniPostCard extends StatelessWidget {
  MiniPostCard(
      {super.key, required this.post, this.editAction, this.deleteAction});

  final ProductModel post;
  final Function()? editAction;
  final Function()? deleteAction;
  RxBool isAvilable = RxBool(false);
  RxBool loading = RxBool(false);
  RxBool isEdit = RxBool(false);
  RxBool isDelete = RxBool(false);
  MainController mainController = Get.find<MainController>();
  ProfileLogic logic = Get.find<ProfileLogic>();

  @override
  Widget build(BuildContext context) {
    isAvilable.value = post.is_available!;
    return Container(
      margin: EdgeInsets.only(top: 0.01.sh),
      width: 1.sw,
      decoration: BoxDecoration(
        color: GrayWhiteColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Container(
        padding: EdgeInsets.only(right: 0.02.sw),
        width: 1.sw,
        height: 0.33.sw,
        decoration: BoxDecoration(
          color: GrayWhiteColor,

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

              width: 0.3.sw,
              height: 0.3.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                    image: CachedNetworkImageProvider("${post.image}"),fit: BoxFit.cover),
              ),
              child: post.is_special == true
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.02.sw, vertical: 0.005.sh),
                      alignment: Alignment.topRight,
                      child: Container(
                        alignment: Alignment.center,
                        width: 0.12.sw,
                        height: 0.03.sh,
                        decoration: BoxDecoration(
                            color: DarkColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.crown,
                              color: OrangeColor,
                              size: 0.03.sw,
                            ),
                            Text(
                              " مميز ",
                              style: H4OrangeTextStyle,
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
            Container(
width: 0.67.sw,
              padding: EdgeInsets.only(top: 0.01.sh),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 0.01.sw),
                        height: 0.12.sh,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SellerNameComponent(
                              sellerName: "${post.user?.seller_name}",
                              isVerified: post.user?.is_verified??false,
                              textStyle: H2BlackTextStyle,
                            ),
                            10.verticalSpace,
                            if (post.type == 'product')
                              Text(
                                "${post.name}",
                                style: H2RedTextBoldStyle.copyWith(
                                    color: DarkColor),
                              ),
                            if (post.type == 'job' ||
                                post.type == 'search_job' ||
                                post.type == 'tender' ||
                                post.type == 'service')
                              Text(
                                "${post.expert}",
                                style: H4GrayTextStyle,
                              ),
                            10.verticalSpace,
                            if (post.type == 'product')
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "${post.price} \$",
                                      style: post.is_discount == true
                                          ? H4RegularDark.copyWith(
                                          decoration:
                                          TextDecoration.lineThrough)
                                          : H2RedTextBoldStyle,
                                    ),
                                    if (post.is_discount == true)
                                      TextSpan(
                                          text: "${post.discount} \$",
                                          style: H2RedTextBoldStyle),
                                  ]))
                          ],
                        ),
                      ),
                      if(post.user?.id==mainController.authUser.value?.id)
                      Container(
                        padding: EdgeInsets.only(left: 0.02.sw),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            switch (post.type) {
                              case "product":
                                Get.toNamed(Edit_PRODUCT_PAGE,
                                    arguments: post.id!);
                                break;
                              case "job":
                              case "search_job":
                                Get.toNamed(Edit_JOB_PAGE,
                                    arguments: post.id!);
                                break;
                              case "tender":
                                Get.toNamed(Edit_TENDER_PAGE,
                                    arguments: post.id!);
                                break;
                              case "service":
                                Get.toNamed(Edit_SERVICE_PAGE,
                                    arguments: post.id!);
                                break;
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 0.01.sh, horizontal: 0.02.sw),
                            decoration: BoxDecoration(
                                color: RedColor,
                                borderRadius: BorderRadius.circular(45.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "تعديل",
                                  style: H3WhiteTextStyle,
                                ),
                                10.horizontalSpace,
                                Icon(
                                  FontAwesomeIcons.pen,
                                  color: WhiteColor,
                                  size: 0.03.sw,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.01.sw,vertical: 0.004.sh),
                    width: 0.66.sw,
                    height: 0.027.sh,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.locationDot,
                              color: GrayDarkColor,
                              size: 0.04.sw,
                            ),
                            10.horizontalSpace,
                            Text("${post.city?.name}",style: H4GrayTextStyle,),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.eye,
                              color: GrayDarkColor,
                              size: 0.04.sw,
                            ),
                            10.horizontalSpace,
                            Text("${post.views_count}",style: H4GrayTextStyle,),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.stopwatch,
                              color: GrayDarkColor,
                              size: 0.04.sw,
                            ),
                            10.horizontalSpace,
                            Text("${post.created_at}",style: H4GrayTextStyle,),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCol() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 0.004.sh),
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: GrayDarkColor,
            ),
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "معرف المنتج : ", style: H4BlackTextStyle),
                    TextSpan(text: "${post.id}", style: H4RedTextStyle),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.eye,
                    size: 0.04.sw,
                  ),
                  10.horizontalSpace,
                  Text(
                    "${post.views_count}",
                    style: H4RedTextStyle,
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: editAction,
                    child: Icon(
                      FontAwesomeIcons.edit,
                      size: 0.05.sw,
                      color: OrangeColor,
                    ),
                  ),
                  50.horizontalSpace,
                  Obx(() {
                    if (loading.value && isDelete.value) {
                      return Container(
                        width: 0.04.sw,
                        height: 0.04.sw,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'تأكيد الحذف',
                          titleStyle: H4RedTextStyle,
                          titlePadding: EdgeInsets.symmetric(vertical: 0.02.sh),
                          middleText: 'هل انت متأكد من حذف المنتج ؟',
                          middleTextStyle: H3BlackTextStyle,
                          confirm: InkWell(
                            onTap: () {
                              deleteProduct();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.01.sh, horizontal: 0.03.sw),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(color: RedColor)),
                              child: Text(
                                ' تأكيد ',
                                style: H4BlackTextStyle,
                              ),
                            ),
                          ),
                          cancel: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.01.sh, horizontal: 0.03.sw),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(color: GrayLightColor)),
                              child: Text(
                                ' إلغاء ',
                                style: H4BlackTextStyle,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        FontAwesomeIcons.trash,
                        size: 0.05.sw,
                        color: RedColor,
                      ),
                    );
                  })
                ],
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(vertical: 0.003.sh, horizontal: 0.02.sw),
              width: 0.4.sw,
              height: 0.19.sh,
              child: Stack(
                children: [
                  Container(
                    width: 0.8.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        image: DecorationImage(
                            image: NetworkImage('${post.image}'),
                            fit: BoxFit.fitWidth)),
                  ),
                  if (post.level == 'special')
                    Positioned(
                      top: 10,
                      child: Container(
                        alignment: Alignment.center,
                        //padding: EdgeInsets.symmetric(horizontal: 0.02.sw,vertical: 0.003.sh),
                        width: 0.4.sw,
                        height: 0.02.sh,

                        decoration:
                            BoxDecoration(color: DarkColor.withOpacity(0.6)),
                        child: Text(
                          'مميز',
                          style: H4OrangeTextStyle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.003.sw, vertical: 0.006.sh),
              width: 0.6.sw,
              child: Column(
                children: [
                  Text(
                    "${post.expert}",
                    style: H3BlackTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  50.verticalSpace,
                  Row(
                    children: [
                      Text(
                        '${post.category?.name} ',
                        style: H4GrayOpacityTextStyle,
                      ),
                      Text(
                        ' - ${post.sub1?.name} ',
                        style: H4GrayOpacityTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (post.active != '')
                        Container(
                          width: 0.2.sw,
                          padding: const EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 0.04.sh),
                          decoration: BoxDecoration(
                            color: post.active!.active2Color(),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${post.active!.active2Arabic()}',
                                style: H4WhiteTextStyle,
                              ),
                              Icon(
                                post.active!.active2Icon(),
                                color: WhiteColor,
                                size: 0.03.sw,
                              )
                            ],
                          ),
                        ),
                      if (post.type == 'product')
                        Obx(() {
                          if (loading.value && isEdit.value) {
                            return Container(
                              width: 0.04.sw,
                              height: 0.04.sw,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return Container(
                            margin: EdgeInsets.only(top: 0.04.sh),
                            child: Column(
                              children: [
                                Obx(() {
                                  return Switch(
                                    value: isAvilable.value,
                                    onChanged: (value) {
                                      isAvilable.value = !isAvilable.value;
                                      changeAvialable();
                                    },
                                    activeColor: RedColor,
                                    activeTrackColor: OrangeColor,
                                    inactiveTrackColor: GrayLightColor,
                                  );
                                }),
                                Text(
                                  'حالة التوفر',
                                  style: H6OrangeTextStyle,
                                ),
                              ],
                            ),
                          );
                        })
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  changeAvialable() async {
    loading.value = true;
    isEdit.value = true;
    mainController.query.value = '''
    mutation ChangeAvilable {
    changeAvilable(id: "${post.id}") {
        id
        name
        expert
        is_available
        level
        type
        active
        views_count
        image
        category {
            name
        }
        sub1 {
            name
        }
    }
}
    ''';
    try {
      dio.Response? res = await mainController.fetchData();

      if (res?.data?['data']?['changeAvilable'] != null) {
        Get.snackbar('', '',
            titleText: Center(
                child: Text(
              'تمت العملية بنجاح',
              style: H5RedTextStyle,
            )));
        int index = logic.products.indexWhere((el) => el.id == post.id);
        logic.products.removeAt(index);
        ProductModel newPost =
            ProductModel.fromJson(res?.data?['data']?['changeAvilable']);
        logic.products.insert(index, newPost);
      }
    } on CustomException catch (e) {}
    loading.value = false;
    isEdit.value = false;
  }

  deleteProduct() async {
    loading.value = true;
    isDelete.value = true;
    mainController.query.value = '''
    mutation DeleteProduct {
    deleteProduct(id: "${post.id}") {
        id
        name
    }
}

    ''';
    try {
      dio.Response? res = await mainController.fetchData();

      if (res?.data?['data']?['deleteProduct'] != null) {
        Get.snackbar('', '',
            titleText: Center(
                child: Text(
              'تمت العملية بنجاح',
              style: H5RedTextStyle,
            )));
        int index = logic.products.indexWhere((el) => el.id == post.id);
        logic.products.removeAt(index);
      }
    } on CustomException catch (e) {}
    loading.value = false;
    isDelete.value = false;
  }
}
