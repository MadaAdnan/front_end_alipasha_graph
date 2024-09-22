import 'dart:math';

import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/exceptions/custom_exception.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/pages/profile/logic.dart';
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
        color: WhiteColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
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
                            confirm:InkWell(
                              onTap: (){
                                deleteProduct();
                              },
                              child:  Container(
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
                            cancel:InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child:  Container(
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
                padding: EdgeInsets.symmetric(
                    vertical: 0.003.sh, horizontal: 0.02.sw),
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
      ),
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
     // mainController.logger.e(res?.data);
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
    //  mainController.logger.e(res?.data);
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
