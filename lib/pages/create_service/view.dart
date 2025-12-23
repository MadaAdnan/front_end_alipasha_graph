import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../Global/main_controller.dart';
import '../../helpers/colors.dart';
import '../../helpers/components.dart';
import '../../helpers/helper_class.dart';
import '../../helpers/style.dart';
import '../../models/category_model.dart';
import '../../models/city_model.dart';
import '../../routes/routes_url.dart';
import 'logic.dart';

class CreateServicePage extends StatelessWidget {
  CreateServicePage({Key? key}) : super(key: key);

  final logic = Get.find<CreateServiceLogic>();
  final MainController mainController = Get.find<MainController>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WhiteColor,
        body: Obx(() {
          return Stack(
            children: [

              Container(
                width: 1.sw,
                height: 1.sh,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  child: FormBuilder(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: logic.formState,
                    child: Column(children: [
                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 0.02.sh),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                        BorderSide(color: PrimaryColor, width: 2))),
                                child: Text(
                                  'إنشاء منشور',
                                  style: H5BlackTextStyle,
                                ),
                              ),
                              InkWell(
                                onTap:(){
                                  Get.offAndToNamed(CREATE_PRODUCT_PAGE);
                                },
                                child: Container(
                                  width: 0.2.sw,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.008.sw, vertical: 0.009.sh),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: logic.typePost.value != 'product'
                                            ? GrayDarkColor
                                            : PrimaryColor),
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: logic.typePost.value != 'product'
                                        ? Colors.transparent
                                        : PrimaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.shoppingCart,
                                          color: logic.typePost.value != 'product'
                                              ? GrayDarkColor
                                              : WhiteColor,
                                          size: 0.04.sw),
                                      10.horizontalSpace,
                                      Text(
                                        'منتج',
                                        style: logic.typePost.value != 'product'
                                            ? H4GrayTextStyle
                                            : H4WhiteTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap:(){
                                  Get.offAndToNamed(CREATE_JOB_PAGE);
                                },
                                child: Container(
                                  width: 0.2.sw,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.009.sw, vertical: 0.009.sh),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: logic.typePost.value != 'job'
                                            ? GrayDarkColor
                                            : PrimaryColor),
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: logic.typePost.value != 'job'
                                        ? Colors.transparent
                                        : PrimaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.idCard,
                                          color: logic.typePost.value != 'job'
                                              ? GrayDarkColor
                                              : WhiteColor,
                                          size: 0.04.sw),
                                      10.horizontalSpace,
                                      Text(
                                        'وظيفة',
                                        style: logic.typePost.value != 'job'
                                            ? H4GrayTextStyle
                                            : H4WhiteTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap:(){
                                  Get.offAndToNamed(CREATE_TENDER_PAGE);
                                },
                                child: Container(
                                  width: 0.2.sw,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.009.sw, vertical: 0.009.sh),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: logic.typePost.value != 'tender'
                                            ? GrayDarkColor
                                            : PrimaryColor),
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: logic.typePost.value != 'tender'
                                        ? Colors.transparent
                                        : PrimaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.moneyBillTrendUp,
                                          color: logic.typePost.value != 'tender'
                                              ? GrayDarkColor
                                              : WhiteColor,
                                          size: 0.04.sw),
                                      10.horizontalSpace,
                                      Text(
                                        'مناقصة',
                                        style: logic.typePost.value != 'tender'
                                            ? H4GrayTextStyle
                                            : H4WhiteTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(

                                child: Container(
                                  width: 0.2.sw,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.009.sw, vertical: 0.009.sh),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: logic.typePost.value != 'service'
                                            ? GrayDarkColor
                                            : PrimaryColor),
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: logic.typePost.value != 'service'
                                        ? Colors.transparent
                                        : PrimaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.servicestack,
                                        color: logic.typePost.value != 'service'
                                            ? GrayDarkColor
                                            : WhiteColor,
                                        size: 0.04.sw,
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        'خدمة',
                                        style: logic.typePost.value != 'service'
                                            ? H4GrayTextStyle
                                            : H4WhiteTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      Divider(
                        color: GrayLightColor,
                        height: 2,
                        thickness: 3,
                      ),
                      Container(
                        height: 0.1.sh,
                        width: 1.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 0.9.sw,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 0.1.sw,
                                    height: 0.1.sw,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: GrayDarkColor),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            "${mainController.authUser.value?.image}",
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Container(
                                    width: 0.6.sw,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Text(
                                              "انت تنشر باسم :",
                                              style: H5BlackTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Container(
                                            child: Text(
                                              "${mainController.authUser.value?.seller_name ?? mainController.authUser.value?.name}",
                                              style: H1BlackTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      Container(
                        width: 1.sw,
                        height: 0.13.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.required(
                              errorText: 'يرجى كتابة وصف للخدمة', checkNullOrEmpty: true),
                          name: 'info',
                          minLines: 6,
                          maxLines: 9,
                          keyboardType: TextInputType.multiline,
                          style: H3BlackTextStyle,
                          controller: logic.infoProduct,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,
                            alignLabelWithHint: true,
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(text: 'وصف الخدمة ', style: H4GrayTextStyle),
                                TextSpan(text: '*', style: H3RedTextStyle),
                              ]),
                            ),
                            labelStyle: H4GrayTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      30.verticalSpace,

                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.required(
                              errorText: 'يرجى كتابة العنوان التفصيلي', checkNullOrEmpty: true),
                          name: 'address',
                          keyboardType: TextInputType.emailAddress,
                          style: H3BlackTextStyle,
                          controller: logic.addressController,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'العنوان التفصيلي', style: H4GrayTextStyle),
                                TextSpan(text: '*', style: H3RedTextStyle),
                              ]),
                            ),
                            labelStyle: H4GrayTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'يرجى إدخال بريد إلكتروني'),
                            FormBuilderValidators.email( errorText: 'يرجى إدخال بريد صالح'),

                          ]
                          ),

                          name: 'email',
                          keyboardType: TextInputType.emailAddress,
                          style: H3BlackTextStyle,
                          controller: logic.emailController,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ' البريد الإلكتروني ',
                                    style: H4GrayTextStyle),
                                TextSpan(text: '*', style: H3RedTextStyle),
                              ]),
                            ),
                            labelStyle: H4GrayTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: FormBuilderTextField(
                          validator: FormBuilderValidators.required(
                              errorText: 'يرجى كتابة رقم الهاتف', checkNullOrEmpty: true),
                          name: 'phone',
                          keyboardType: TextInputType.phone,
                          style: H3BlackTextStyle,
                          controller: logic.phoneController,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,
                            label: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ' رقم الهاتف ', style: H4GrayTextStyle),
                                TextSpan(text: '*', style: H3RedTextStyle),
                              ]),
                            ),
                            labelStyle: H4GrayTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),


                      30.verticalSpace,
                      Container(
                        width: 1.sw,
                        height: 0.08.sh,
                        child: FormBuilderTextField(
                          name: 'url',
                          validator: FormBuilderValidators.required(
                              errorText: 'يرجى إدخال الرابط'),
                          keyboardType: TextInputType.url,
                          style: H3BlackTextStyle,
                          controller: logic.urlController,
                          decoration: InputDecoration(
                            errorStyle: H5RedTextStyle,
                            labelText: 'رابط الخدمة',
                            labelStyle: H4GrayTextStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      Obx(() {
                        return Container(
                          child: FormBuilderSearchableDropdown<CityModel>(
                            dropdownSearchTextStyle: H3GrayTextStyle,
                            dropdownBuilder: (context, selectedItem) => Text('${selectedItem?.name}',style: H3GrayTextStyle,),
                            dropdownSearchDecoration: InputDecoration(labelStyle: H3GrayTextStyle,helperStyle: H3GrayTextStyle),

                            filterFn: (item, filter) => item.name!.toLowerCase().contains(filter.toLowerCase()),
                            validator: FormBuilderValidators.required(
                                errorText: 'يرجى تحديد المدينة',
                                checkNullOrEmpty: true),
                            decoration: InputDecoration(
                              errorStyle: H5RedTextStyle,
                              label: RichText(
                                text: TextSpan(children: [
                                  TextSpan(text: 'المدينة', style: H4GrayTextStyle),
                                  TextSpan(text: '*', style: H3RedTextStyle),
                                ]),
                              ),

                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: GrayLightColor,
                                ),
                              ),
                            ),
                            onChanged: (value) => logic.citySelected.value = value,
                            name: 'city_id',
                            compareFn: (item1, item2) => item1.id == item2.id,
                            items: logic.cities.map((el) {
                              return el;
                            }).toList(),
                          ),
                        );
                      }),
                      30.verticalSpace,
                      /* Obx(() {
                  return Container(
                    child: FormBuilderDropdown<int>(
                      validator: FormBuilderValidators.required(
                          errorText: 'يرجى تحديد المدينة',
                          checkNullOrEmpty: true),
                      decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(children: [
                              TextSpan(text: 'المدينة', style: H4GrayTextStyle),
                              TextSpan(text: '*', style: H3RedTextStyle),
                            ]),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: GrayLightColor))),
                      onChanged: (value) {},
                      name: 'city_id',
                      items: [
                        ...List.generate(
                          logic.cities.length,
                          (index) => DropdownMenuItem<int>(
                            child: Text(
                              '${logic.cities[index].name}',
                              style: H3BlackTextStyle,
                            ),
                            value: logic.cities[index].id,
                          ),
                        )
                      ],
                    ),
                  );
                }),*/
                      30.verticalSpace,
                      Obx(() {
                        return Container(

                          child: FormBuilderDropdown<CategoryModel>(
                            validator: FormBuilderValidators.required(
                                errorText: 'يرجى تحديد القسم الرئيسي',
                                checkNullOrEmpty: true),
                            decoration: InputDecoration(
                              errorStyle: H5RedTextStyle,
                                label: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'القسم الرئيسي',
                                        style: H4GrayTextStyle),
                                    TextSpan(text: '*', style: H3RedTextStyle),
                                  ]),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: GrayLightColor))),
                            onChanged: (value) => logic.category.value = value,
                            initialValue: logic.category.value,
                            name: 'category_id${Random().nextInt(10000000)}',
                            items: [
                              ...List.generate(
                                logic.categories.length,
                                    (index) => DropdownMenuItem<CategoryModel>(
                                  child: Text(
                                    '${logic.categories[index].name}',
                                    style: H3BlackTextStyle,
                                  ),
                                  value: logic.categories[index],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                      30.verticalSpace,
                      Obx(() {
                        if (logic.category.value != null &&
                            logic.category.value!.children!.length > 0) {
                          List<CategoryModel> categories =
                              logic.category.value!.children?.toList() ?? [];
                          return Container(
                            child: FormBuilderDropdown<CategoryModel>(
                              validator: FormBuilderValidators.required(
                                  errorText: 'يرجى تحديد القسم الفرعي',
                                  checkNullOrEmpty: true),
                              decoration: InputDecoration(
                                  errorStyle: H5RedTextStyle,
                                  label: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'القسم الفرعي ',
                                          style: H4GrayTextStyle),
                                      TextSpan(text: '*', style: H3RedTextStyle),
                                    ]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: GrayLightColor))),
                              onChanged: (value) => logic.subCategory.value = value,
                              name: 'sub_id${Random().nextInt(10000000)}',
                              items: [
                                ...List.generate(
                                  categories.length,
                                      (index) => DropdownMenuItem<CategoryModel>(
                                    child: Text(
                                      '${categories[index].name}',
                                      style: H3BlackTextStyle,
                                    ),
                                    value: categories[index],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Container();
                      }),
                      30.verticalSpace,
                      Obx(() {
                        if (logic.subCategory.value != null &&
                            logic.subCategory.value!.children!.length > 0) {
                          List<CategoryModel> categories =
                              logic.subCategory.value!.children?.toList() ?? [];
                          return Container(
                            child: FormBuilderDropdown<CategoryModel>(
                              validator: FormBuilderValidators.required(
                                  errorText: 'يرجى تحديد الفرعي الرئيسي',
                                  checkNullOrEmpty: true),
                              decoration: InputDecoration(
                                  errorStyle: H5RedTextStyle,
                                  label: Text(
                                    'القسم الفرعي 2',
                                    style: H3GrayTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: GrayLightColor))),
                              onChanged: (value) => logic.sub2Category.value = value,
                              name: 'sub2_id',
                              items: [
                                ...List.generate(
                                  categories.length,
                                      (index) => DropdownMenuItem<CategoryModel>(
                                    child: Text(
                                      '${categories[index].name}',
                                      style: H3BlackTextStyle,
                                    ),
                                    value: categories[index],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Container();
                      }),
                      30.verticalSpace,
                      Obx(() {
                        if (logic.sub2Category.value != null &&
                            logic.sub2Category.value!.children!.length > 0) {
                          List<CategoryModel> categories =
                              logic.sub2Category.value!.children?.toList() ?? [];
                          return Container(
                            child: FormBuilderDropdown<CategoryModel>(
                              decoration: InputDecoration(
                                  errorStyle: H5RedTextStyle,
                                  label: Text(
                                    'القسم الرئيسي',
                                    style: H3GrayTextStyle,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: GrayLightColor))),
                              onChanged: (value) => logic.sub3Category.value = value,
                              name: 'sub3_id',
                              items: [
                                ...List.generate(
                                  categories.length,
                                      (index) => DropdownMenuItem<CategoryModel>(
                                    child: Text(
                                      '${categories[index].name}',
                                      style: H3BlackTextStyle,
                                    ),
                                    value: categories[index],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Container();
                      }),
                      30.verticalSpace,
                      InkWell(
                        onTap: () {
                         
                          if (logic.formState.currentState?.validate() == true) {
                            logic.saveData();
                          } else {
                            final firstErrorField = logic
                                .formState.currentState?.context
                                .findRenderObject() as RenderBox?;

                            if (firstErrorField != null) {
                              _scrollController.animateTo(
                                firstErrorField.localToGlobal(Offset.zero).dy,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        },
                        child: Container(
                          width: 0.8.sw,
                          height: 0.05.sh,
                          alignment: Alignment.center,
                          child: Text(
                            'إرسال للنشر',
                            style: H3WhiteTextStyle,
                          ),
                          decoration: BoxDecoration(
                            color: PrimaryColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              if(logic.loading.value)
                Container(child: Center(child: CircularProgressIndicator(),),),

              Obx(() => Visibility(
                child: Positioned(
                  right: 0.1.sw,
                  top: 0.35.sh,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                    width: 0.8.sw,


                    child: Card(
                      elevation: 9,
                      color: WhiteColor,

                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 0.02.sw),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              SizedBox(height: 0.01.sh,),
                              Text(
                                'تنبيه',style: H2RedTextBoldStyle,),
                              Container(
                                width: 0.2.sw,
                                height: 0.2.sw,
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/png/info.png'))),
                              ),


                              SizedBox(height: 0.01.sh,),
                              Text(
                                'وصلت لحد النشر المسموح لك شهريا انتظر للشهر القادم او قم بترقية حسابك لتحصل على النشر المفتوح',style: H3BlackTextStyle.copyWith(height: 2),),
                              SizedBox(height: 0.07.sh,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(onPressed: (){
                                    Get.offNamed(PROFILE_PAGE);
                                  },child: Text('الملف الشخصي',style: H3WhiteTextStyle,),color: SecondaryColor,),
                                  MaterialButton(onPressed: (){
                                    // Get.back();
                                    HelperClass.requestVerified(onConfirm: (){
                                      if(isAuth()){
                                        String message="ID:${mainController.authUser.value?.id} - اسم المتجر : ${mainController.authUser.value?.seller_name} - نوع الطلب توثيق الحساب";
                                        openUrl(url: "https://wa.me/${mainController.settings.value.social?.phone}?text=${Uri.encodeComponent('${message!.toString()}')}");
                                      }
                                    });
                                  },child: Text('توثيق الحساب',style: H3WhiteTextStyle,),color: PrimaryColor,),
                                ],
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                visible:
                mainController.authUser.value?.isAvailableCreate == false && logic.loading.value==false,
              )),
            ],
          );
        }));
  }
}
