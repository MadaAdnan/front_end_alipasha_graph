import 'package:ali_pasha_graph/Global/main_controller.dart';
import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/filter_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/routes/routes_url.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FilterLogic extends GetxController {
  MainController mainController = Get.find<MainController>();
  TextEditingController searchController = TextEditingController();
  Rxn<CategoryModel> categoryModel = Rxn<CategoryModel>(null);
  Rxn<CategoryModel> sub1Model = Rxn<CategoryModel>(null);
  Rxn<CityModel> cityModel = Rxn<CityModel>(null);
  RxList<ColorModel> colors = RxList<ColorModel>([]);
  Rx<RangeValues> priceRange = Rx<RangeValues>(RangeValues(0, 1000));
  RxString type = RxString('product');

  Rx<SingleSelectController<CategoryModel>> categoryController =
      Rx<SingleSelectController<CategoryModel>>(
          SingleSelectController<CategoryModel>(null));
  Rx<SingleSelectController<CategoryModel>> subController =
      Rx<SingleSelectController<CategoryModel>>(
          SingleSelectController<CategoryModel>(null));
  Rx<SingleSelectController<CityModel>> cityController =
      Rx<SingleSelectController<CityModel>>(
          SingleSelectController<CityModel>(null));
  Rx<MultiSelectController<ColorModel>> colorController =
      Rx<MultiSelectController<ColorModel>>(
          MultiSelectController<ColorModel>([]));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(type, (value) {
      categoryModel.value = null;
      cityModel.value = null;
      categoryController.value.clear();
      cityController.value.clear();
    });
    ever(categoryModel, (value) {
      colors.clear();
      sub1Model.value = null;
      subController.value.clear();
      colorController.value.clear();
    });
  }

  search() {
    FilterModel filterModel = FilterModel(
      colors: colorController.value.value.map((el)=>int.parse("${el.id}")).toList(),
      categoryId: categoryController.value.value?.id,
      sub1Id: subController.value.value?.id,
      search: searchController.text,
      type: type.value,
      cityId: cityController.value.value?.id,
      startPrice: priceRange.value.start,
      endPrice: priceRange.value.end,
    );
    Get.offAndToNamed(SEARCH_PAGE, arguments: filterModel);
  }
}
