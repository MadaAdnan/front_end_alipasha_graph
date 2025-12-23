import 'package:ali_pasha_graph/components/fields_components/input_component.dart';
import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:field_suggestion/box_controller.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../../models/city_model.dart';
import 'logic.dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);

  final logic = Get.find<FilterLogic>();
  final boxController = BoxController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: WhiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0.03.sh, horizontal: 0.02.sw),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 0.03.sh),
              width: 1.sw,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: DarkColor))),
              child: Text(
                'فلتر للبحث',
                style: H2BlackTextStyle,
              ),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      logic.type.value = 'product';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 0.02.sw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: logic.type == 'product'
                                  ? PrimaryColor
                                  : GrayDarkColor),
                          color: logic.type == 'product'
                              ? PrimaryColor
                              : WhiteColor),
                      child: Text(
                        'منتج',
                        style: logic.type == 'product'
                            ? H5WhiteTextStyle
                            : H5GrayTextStyle,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      logic.type.value = 'seller';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 0.02.sw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: logic.type == 'seller'
                                  ? PrimaryColor
                                  : GrayDarkColor),
                          color: logic.type == 'seller'
                              ? PrimaryColor
                              : WhiteColor),
                      child: Text(
                        'متجر',
                        style: logic.type == 'seller'
                            ? H5WhiteTextStyle
                            : H5GrayTextStyle,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      logic.type.value = 'job';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 0.02.sw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: logic.type == 'job'
                                  ? PrimaryColor
                                  : GrayDarkColor),
                          color:
                              logic.type == 'job' ? PrimaryColor : WhiteColor),
                      child: Text(
                        'وظائف',
                        style: logic.type == 'job'
                            ? H5WhiteTextStyle
                            : H5GrayTextStyle,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      logic.type.value = 'tender';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 0.02.sw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: logic.type == 'tender'
                                  ? PrimaryColor
                                  : GrayDarkColor),
                          color: logic.type == 'tender'
                              ? PrimaryColor
                              : WhiteColor),
                      child: Text(
                        'مناقصات',
                        style: logic.type == 'tender'
                            ? H5WhiteTextStyle
                            : H5GrayTextStyle,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      logic.type.value = 'service';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 0.02.sw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: logic.type == 'service'
                                  ? PrimaryColor
                                  : GrayDarkColor),
                          color: logic.type == 'service'
                              ? PrimaryColor
                              : WhiteColor),
                      child: Text(
                        'خدمات',
                        style: logic.type == 'service'
                            ? H5WhiteTextStyle
                            : H5GrayTextStyle,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      logic.type.value = 'news';
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 0.02.sw),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: logic.type == 'news'
                                  ? PrimaryColor
                                  : GrayDarkColor),
                          color:
                              logic.type == 'news' ? PrimaryColor : WhiteColor),
                      child: Text(
                        'الأخبار',
                        style: logic.type == 'news'
                            ? H5WhiteTextStyle
                            : H5GrayTextStyle,
                      ),
                    ),
                  ),
                ],
              );
            }),
            20.verticalSpace,
            Container(
              //color: RedColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
              margin: EdgeInsets.only(bottom: 0.03.sh),
              child: Obx(() {
                return FieldSuggestion<String>.network(
                  boxStyle: BoxStyle(backgroundColor: GrayLightColor),
                  builder: (context,AsyncSnapshot<List<String>> snapshot){

                    if(snapshot.hasData){
                     return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {

                          return ListTile(
                          tileColor: GrayWhiteColor,

                            onTap: () {
                               logic.searchController.text = "${snapshot.data?[index]}";
                             boxController.close?.call();
                            },
                            title:  Text("${snapshot.data?[index]}"),
                          );
                        },
                      );
                    }
                    return ListTile(title:  Center(child: CircularProgressIndicator()),tileColor: GrayWhiteColor,);
                   },

                  inputDecoration: InputDecoration(
                    hintText: logic.type.value == 'seller'
                        ? 'ابحث باسم المتجر'
                        : 'بحث', // optional
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    )
                  ),

                  textController: logic.searchController,
                  boxController: boxController,
                  future: (String input)async {
                   return await logic.suggestions(input);
                    },

                  // optional

                );
                /* return  InputComponent(
                  fill: WhiteColor,
                  width: 1.sw,
                  height: 0.07.sh,
                  hint:
                      logic.type.value == 'seller' ? 'ابحث باسم المتجر' : 'بحث',
                  controller: logic.searchController,
                  textInputType: TextInputType.text,

                );*/
              }),
            ),
            Obx(() {
              return Visibility(
                visible: logic.type.value != 'news',
                child: Container(
                  width: 0.92.sw,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  margin: EdgeInsets.only(bottom: 0.03.sh),
                  decoration: BoxDecoration(
                      border: Border.all(color: DarkColor),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: CustomDropdown<CityModel>.search(
                    controller: logic.cityController.value,
                    noResultFoundBuilder: (context, text) => Text(
                      "$text",
                      style: H3BlackTextStyle,
                    ),
                    noResultFoundText: 'لم يتم العثور على نتائج',
                    searchHintText: 'إبحث عن مدينة',
                    hintText: 'إختر مدينة',
                    hintBuilder: (context, hint, enabled) => Text(
                      "$hint",
                      style: H3BlackTextStyle,
                    ),
                    items: logic.mainController.mainCities,
                    listItemBuilder:
                        (context, item, isSelected, onItemSelect) => Text(
                      '${item.name}',
                      style: H3BlackTextStyle,
                    ),
                    headerBuilder: (context, selectedItem, enabled) => Text(
                      '${selectedItem.name}',
                      style: H3BlackTextStyle,
                    ),
                    onChanged: (value) {
                      logic.cityModel.value = value;
                    },
                  ),
                ),
              );
            }),
            Obx(() {
              return Visibility(
                child: Container(
                  width: 0.92.sw,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  margin: EdgeInsets.only(bottom: 0.03.sh),
                  decoration: BoxDecoration(
                      border: Border.all(color: DarkColor),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: CustomDropdown<CategoryModel>.search(
                    controller: logic.categoryController.value,
                    noResultFoundBuilder: (context, text) => Text(
                      "$text",
                      style: H3BlackTextStyle,
                    ),
                    noResultFoundText: 'لم يتم العثور على نتائج',
                    searchHintText: 'إبحث عن تصنيف',
                    hintText: 'إختر التصنيف',
                    hintBuilder: (context, hint, enabled) => Text(
                      "$hint",
                      style: H3BlackTextStyle,
                    ),
                    items: logic.mainController.categories
                        .where((category) => category.type == logic.type.value)
                        .toList(),
                    listItemBuilder:
                        (context, item, isSelected, onItemSelect) => Text(
                      '${item.name}',
                      style: H3BlackTextStyle,
                    ),
                    headerBuilder: (context, selectedItem, enabled) => Text(
                      '${selectedItem.name}',
                      style: H3BlackTextStyle,
                    ),
                    onChanged: (value) {
                      logic.categoryModel.value = value;
                    },
                  ),
                ),
                visible: logic.type.value != 'seller',
              );
            }),
            Obx(() {
              if (logic.type == 'job') {
                return Container(
                  width: 0.92.sw,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  margin: EdgeInsets.only(bottom: 0.03.sh),
                  decoration: BoxDecoration(
                      border: Border.all(color: DarkColor),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'يبحث عن وظيفة',
                            style: H4RegularDark,
                          ),
                          Radio(
                            value: 'job',
                            groupValue: logic.typeJob.value,
                            onChanged: (value) {
                              logic.typeJob.value = value;
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('شاغر وظيفي', style: H4RegularDark),
                          Radio(
                            value: 'search_job',
                            groupValue: logic.typeJob.value,
                            onChanged: (value) {
                              logic.typeJob.value = value;
                            },
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
              return Container();
            }),
            Obx(() {
              return Visibility(
                child: Container(
                  width: 0.92.sw,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  margin: EdgeInsets.only(bottom: 0.03.sh),
                  decoration: BoxDecoration(
                      border: Border.all(color: DarkColor),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: CustomDropdown<CategoryModel>.search(
                    controller: logic.subController.value,
                    noResultFoundBuilder: (context, text) => Text(
                      "$text",
                      style: H3BlackTextStyle,
                    ),
                    noResultFoundText: 'لم يتم العثور على نتائج',
                    searchHintText: 'إبحث عن قسم',
                    hintText: 'إختر القسم',
                    hintBuilder: (context, hint, enabled) => Text(
                      "$hint",
                      style: H3BlackTextStyle,
                    ),
                    items: logic.categoryModel.value?.children,
                    listItemBuilder:
                        (context, item, isSelected, onItemSelect) => Text(
                      '${item.name}',
                      style: H3BlackTextStyle,
                    ),
                    headerBuilder: (context, selectedItem, enabled) => Text(
                      '${selectedItem.name}',
                      style: H3BlackTextStyle,
                    ),
                    onChanged: (value) {
                      logic.sub1Model.value = value;
                    },
                  ),
                ),
                visible: logic.type.value != 'seller',
              );
            }),
            Obx(() {
              return Visibility(
                visible: logic.categoryModel.value?.hasColor == true,
                child: Container(
                  width: 0.92.sw,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  margin: EdgeInsets.only(bottom: 0.03.sh),
                  decoration: BoxDecoration(
                      border: Border.all(color: DarkColor),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: CustomDropdown<ColorModel>.multiSelectSearch(
                    multiSelectController: logic.colorController.value,
                    noResultFoundBuilder: (context, text) => Text(
                      "$text",
                      style: H3BlackTextStyle,
                    ),
                    noResultFoundText: 'لم يتم العثور على نتائج',
                    searchHintText: 'إبحث عن لون',
                    hintText: 'إختر الألوان',
                    hintBuilder: (context, hint, enabled) => Text(
                      "$hint",
                      style: H3BlackTextStyle,
                    ),
                    items: logic.mainController.colors,
                    listItemBuilder:
                        (context, item, isSelected, onItemSelect) => Text(
                      '${item.name}',
                      style: H3BlackTextStyle,
                    ),
                    headerListBuilder: (context, selectedItem, enabled) => Text(
                      selectedItem.join(","),
                      style: H3BlackTextStyle,
                    ),
                    onListChanged: (value) {
                      logic.colors.value = value;
                    },
                  ),
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: logic.type.value == 'product',
                child: Container(
                  width: 1.sw,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "تحديد مجال السعر",
                            style: H3BlackTextStyle,
                          )),
                      Obx(() {
                        return RangeSlider(
                            min: 0,
                            max: 100000,
                            divisions: 40,
                            activeColor: PrimaryColor,
                            inactiveColor: GrayLightColor,
                            values: logic.priceRange.value,
                            labels: RangeLabels(
                                "${logic.priceRange.value.start}",
                                "${logic.priceRange.value.end}"),
                            onChanged: (values) {
                              logic.priceRange.value = values;
                            });
                      }),
                    ],
                  ),
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: logic.type.value == 'product',
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: 'أدخل أقل سعر',
                                titleStyle: H3BlackTextStyle,
                                content: Container(
                                  child: Column(
                                    children: [
                                      InputComponent(
                                        width: 0.7.sw,
                                        height: 0.05.sh,
                                        textInputType: TextInputType.number,
                                        onChanged: (value) {
                                          double start =
                                              double.tryParse("$value") ?? 0;
                                          if (start > 0 &&
                                              start <
                                                  logic.priceRange.value.end) {
                                            RangeValues values = RangeValues(
                                                start,
                                                logic.priceRange.value.end);
                                            logic.priceRange.value = values;
                                          }
                                        },
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'إغلاق',
                                          style: H4BlackTextStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.02.sw, vertical: 0.005.sh),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(color: GrayLightColor)),
                              child: Text(
                                "${logic.priceRange.value.start}",
                                style: H4RedTextStyle,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: 'أدخل أعلى سعر',
                                titleStyle: H3BlackTextStyle,
                                content: Container(
                                  child: Column(
                                    children: [
                                      InputComponent(
                                        width: 0.7.sw,
                                        height: 0.05.sh,
                                        textInputType: TextInputType.number,
                                        onChanged: (value) {
                                          double end =
                                              double.tryParse("$value") ?? 0;
                                          if (end <= 10000 &&
                                              end >
                                                  logic
                                                      .priceRange.value.start) {
                                            RangeValues values = RangeValues(
                                                logic.priceRange.value.start,
                                                end);
                                            logic.priceRange.value = values;
                                          }
                                        },
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'إغلاق',
                                          style: H4BlackTextStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.02.sw, vertical: 0.005.sh),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(color: GrayLightColor)),
                              child: Text(
                                "${logic.priceRange.value.end}",
                                style: H4RedTextStyle,
                              )),
                        ),
                      ],
                    );
                  }),
                ),
              );
            }),
            MaterialButton(
              onPressed: () {
                logic.search();
              },
              child: Text(
                'بحث',
                style: H2WhiteTextStyle,
              ),
              color: PrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}
