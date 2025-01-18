import 'dart:io';

import 'package:ali_pasha_graph/components/progress_loading.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/enums.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/plan_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../Global/main_controller.dart';
import '../../../models/advice_model.dart';
import '../../../models/slider_model.dart';
import '../../../routes/routes_url.dart';
import '../logic.dart';

class AdviceTab extends StatelessWidget {
  AdviceTab({super.key});

  MainController mainController = Get.find<MainController>();
  final ProfileLogic logic = Get.find<ProfileLogic>();
  Rxn<PlanModel> ads = Rxn<PlanModel>(null);
  GlobalKey<FormBuilderState> _form = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    if (mainController.authUser.value?.plans?.length != 0) {
      ads.value = mainController.authUser.value?.plans?.where((el) {
        bool isAds = el.ads_count! > 0;
        bool isDate = true;
        DateTime expired =
            DateTime.tryParse("${el.pivot?.expired_date}") ?? DateTime.now();
        if (DateTime.now().compareTo(expired) == -1) {
          isDate = true;
        }
        return isAds && isDate;
      }).firstOrNull;
    }

    return Obx(() {
      if (logic.loading.value) {
        return Center(
          child: Container(
            width: 0.3.sw,
            child: ProgressLoading(),
          ),
        );
      }

      return ListView(
        children: [
          10.verticalSpace,
          if (logic.myProducts.length > 0)
            Text(
              'المنتجات المميزة',
              style: H4GrayTextStyle,
            ),
          15.verticalSpace,
          if (ads.value == null)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 0.3.sw,
                child: InkWell(
                    onTap: () {
                      Get.offNamed(CREATE_ADVICE_PAGE);
                    },
                    child: Container(
                      width: 0.3.sw,
                      padding: EdgeInsets.symmetric(
                          vertical: 0.01.sh, horizontal: 0.01.sw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: RedColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'إعلان جديد',
                              style: H4WhiteTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          Icon(
                            FontAwesomeIcons.solidImages,
                            size: 0.04.sw,
                            color: WhiteColor,
                          ),
                        ],
                      ),
                    )),
              )
            ]),
          ...List.generate(logic.myProducts.length, (index) {
            return Card(
              color: WhiteColor,
              child: ListTile(
                leading: Container(
                  width: 0.1.sw,
                  height: 0.1.sw,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          '${logic.myProducts[index].image}'),
                    ),
                  ),
                ),
                title: Text(
                  '${logic.myProducts[index].name}',
                  style: H4BlackTextStyle,
                ),
                subtitle: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '${logic.myProducts[index].category?.name}',
                      style: H4BlackTextStyle,
                    ),
                    TextSpan(
                      text: ' - ${logic.myProducts[index].sub1?.name}',
                      style: H4BlackTextStyle,
                    ),
                  ]),
                ),
              ),
            );
          }),
          10.verticalSpace,
          Divider(),
          10.verticalSpace,
          Container(
            width: 1.sw,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (logic.myAdvices.length > 0)
                  Text(
                    'الإعلانات بين المنتجات',
                    style: H4GrayTextStyle,
                  ),
                15.verticalSpace,

                /// Header
                /* if (logic.myAdvices.length > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 0.001.sh),
                        alignment: Alignment.center,
                        width: 0.33.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                            border: Border.all(color: DarkColor),
                            color: GrayLightColor),
                        child: Text(
                          'الإعلان',
                          style: H2BlackTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 0.001.sh),
                        alignment: Alignment.center,
                        width: 0.33.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                            border: Border.all(color: DarkColor),
                            color: GrayLightColor),
                        child: Text(
                          'مرات الظهور',
                          style: H2BlackTextStyle,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 0.001.sh),
                        width: 0.33.sw,
                        height: 0.04.sh,
                        decoration: BoxDecoration(
                            border: Border.all(color: DarkColor),
                            color: GrayLightColor),
                        child: Text(
                          'تاريخ الإنتهاء',
                          style: H2BlackTextStyle,
                        ),
                      ),
                    ],
                  ),*/
                Obx(() {
                  if (mainController.loading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Obx(() {
                    return Column(
                      children: [
                        ...List.generate(
                          logic.myAdvices.length,
                          (index) {
                            var format = DateFormat.yMd();
                            AdviceModel advice = logic.myAdvices[index];
                            var expired_date =
                                DateTime.tryParse("${advice.expired_date}");
                            return Card(
                              color: WhiteColor,
                              elevation: 7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 0.001.sh),
                                    alignment: Alignment.centerRight,
                                    width: 0.5.sw,
                                    height: 0.25.sw,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: DarkColor),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              '${advice.image}',
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 0.001.sh),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.01.sw),
                                    alignment: Alignment.centerRight,
                                    width: 0.5.sw,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'اسم الإعلان :',
                                            style: H4RegularDark),
                                        TextSpan(
                                            text: '${advice.name}',
                                            style: H4RegularDark),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.003.sh,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 0.001.sh),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.01.sw),
                                    alignment: Alignment.centerRight,
                                    width: 0.5.sw,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'عدد المشاهدات :',
                                            style: H4RegularDark),
                                        TextSpan(
                                            text: '${advice.views_count}',
                                            style: H4RegularDark),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.003.sh,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 0.001.sh),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.01.sw),
                                    alignment: Alignment.centerRight,
                                    width: 0.5.sw,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: 'تاريخ الإنتهاء :',
                                            style: H4RegularDark),
                                        TextSpan(
                                            text: '${advice.expired_date}',
                                            style: H4RegularDark),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.003.sh,
                                  ),
                                  Container(
                                    width: 0.5.sw,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: GrayLightColor))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _editAdvice(advice: advice);
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.edit,
                                              size: 0.05.sw,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              _deleteAdvice(
                                                  adviceId: advice.id!);
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.trash,
                                              size: 0.05.sw,
                                              color: RedColor,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        15.verticalSpace,
                      ],
                    );
                  });
                }),
                if (logic.sliders.length > 0)
                  Text(
                    'إعلانات السلايدر',
                    style: H4GrayTextStyle,
                  ),
                15.verticalSpace,
                if (logic.sliders.length > 0)
                  ...List.generate(
                    logic.sliders.length,
                    (index) {
                      var format = DateFormat.yMd();
                      SliderModel slider = logic.sliders[index];
                      var expired_date =
                          DateTime.tryParse("${slider.expired_date}");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 0.001.sh),
                            alignment: Alignment.center,
                            width: 0.33.sw,
                            height: 0.04.sh,
                            decoration: BoxDecoration(
                                border: Border.all(color: DarkColor),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      '${slider.image}',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 0.001.sh),
                            alignment: Alignment.center,
                            width: 0.33.sw,
                            height: 0.04.sh,
                            decoration: BoxDecoration(
                                border: Border.all(color: DarkColor)),
                            child: Text(
                              '${slider.views_count}'.toFormatNumber(),
                              style: H2BlackTextStyle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 0.001.sh),
                            width: 0.33.sw,
                            height: 0.04.sh,
                            decoration: BoxDecoration(
                                border: Border.all(color: DarkColor)),
                            child: Text(
                              '${expired_date != null ? format.format(expired_date) : ''}',
                              style: H2BlackTextStyle,
                            ),
                          ),
                        ],
                      );
                    },
                  )
              ],
            ),
          ),
        ],
      );
    });
  }

  _deleteAdvice({required int adviceId}) async {
    Get.dialog(AlertDialog(
      content: Container(
        height: 0.08.sh,
        alignment: Alignment.center,
        child: Text(
          'هل أنت متأكد من حذف الإعلان؟',
          style: H3RedTextStyle,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              if (mainController.loading.value) {
                return MaterialButton(
                  onPressed: () async {},
                  child: Text(
                    'جاري الحذف',
                    style: H3WhiteTextStyle,
                  ),
                  color: RedColor,
                );
              }
              return MaterialButton(
                onPressed: () async {
                  await logic.deletAdvice(adviceId: adviceId);
                  Get.back();
                },
                child: Text(
                  'تأكيد',
                  style: H3WhiteTextStyle,
                ),
                color: RedColor,
              );
            }),
            MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'إغلاق',
                style: H3WhiteTextStyle,
              ),
              color: GrayDarkColor,
            ),
          ],
        )
      ],
    ));
  }

  _editAdvice({required AdviceModel advice}) async {
    logic.urlController.value = TextEditingValue(text: "${advice.url}");
    Get.dialog(AlertDialog(
      content: SingleChildScrollView(
        child: FormBuilder(
            key: _form,
            child: Column(
              children: [
                FormBuilderTextField(
                  style: H3RegularDark,
                  controller: logic.urlController,
                  validator: FormBuilderValidators.compose([
                    (value) {
                      if (value != null && value.isNotEmpty && !value.isURL) {
                        return "رابط غير صحيح";
                      }
                      return null;
                    }
                  ]),
                  name: 'url',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(color: GrayLightColor)),
                      label: Text(
                        'رابط الزيارة',
                        style: H3RegularDark,
                      )),
                ),
                SizedBox(
                  height: 0.04.sh,
                ),
                FormBuilderImagePicker(
                  name: 'image',
                  maxImages: 1,
                  fit: BoxFit.cover,
                  maxHeight: 300,
                  maxWidth: 600,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'الصورة مطلوبة'),
                  ]),
                  decoration: InputDecoration(
                    label: Text(
                      'الصورة',
                      style: H3RegularDark,
                    ),
                    helper: Text(
                      'يجب أن تكون أبعاد الصورة العرض ضعف الإرتفاع مثال : 300 * 600',
                      style: H5RedTextStyle,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: GrayLightColor)),
                  ),
                  onChanged: (values) => logic.image.value = values?.first,
                ),
                SizedBox(
                  height: 0.04.sh,
                ),
              ],
            )),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              if (mainController.loading.value) {
                return MaterialButton(
                  onPressed: () async {},
                  child: Text(
                    'جاري الإرسال',
                    style: H3WhiteTextStyle,
                  ),
                  color: RedColor,
                );
              }
              return MaterialButton(
                onPressed: () async {
                  if (_form.currentState!.validate() == true) {
                    await logic.saveAdvice(adviceId: advice.id!);
                    Get.back();
                  }
                },
                child: Text(
                  'تعديل',
                  style: H3WhiteTextStyle,
                ),
                color: RedColor,
              );
            }),
            MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'إغلاق',
                style: H3WhiteTextStyle,
              ),
              color: GrayDarkColor,
            ),
          ],
        )
      ],
    ));
  }
}
