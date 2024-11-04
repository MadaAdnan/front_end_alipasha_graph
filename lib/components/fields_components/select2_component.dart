import 'package:ali_pasha_graph/helpers/colors.dart';
import 'package:ali_pasha_graph/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:select2dot1/select2dot1.dart';

class Select2Component extends StatelessWidget {
  Select2Component({
    super.key,
    this.isSearch = true,
    required this.label,
    required this.width,
    required this.onChanged,
    required this.selectDataController,
  });

  final double width;
  final String label;
  final bool isSearch;
  final SelectDataController selectDataController;
  final Function(List<dynamic> selected) onChanged;
  //final List<SingleItemCategoryModel>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.002.sh),
      width: width,
      child: Select2dot1(
        onChanged: (List<SingleItemCategoryModel> models) {
          onChanged(models.map((el) => el.value).toList());
        },
        searchEmptyInfoOverlaySettings: SearchEmptyInfoOverlaySettings(text: label,textStyle: H3RegularDark),
        pillboxTitleSettings: PillboxTitleSettings(title: label,titleStyleDefault: H3RegularDark),
        searchEmptyInfoModalSettings: SearchEmptyInfoModalSettings(text: label,textStyle: H3RegularDark),

        selectSingleSettings: SelectSingleSettings(textStyle: H3GrayTextStyle),
        isSearchable: isSearch,
        selectDataController: selectDataController,
        dropdownOverlaySettings:
            const DropdownOverlaySettings(sizeAnimationCurve: Curves.bounceIn,),
        dropdownModalSettings:
            const DropdownModalSettings(barrierColor: GrayDarkColor,backgroundColor: WhiteColor,),
        globalSettings: const GlobalSettings(mainColor: GrayDarkColor,activeColor:DarkColor,chipColor: RedColor,hoverListItemColor: WhiteColor,inActiveColor: DarkColor,),
        //pillboxTitleSettings: PillboxTitleSettings(title: 'المدينة',titleStyleDefault: HintTextStyle),
        pillboxContentMultiSettings:
            const PillboxContentMultiSettings(pillboxLayout: PillboxLayout.wrap),
        selectEmptyInfoSettings:
            SelectEmptyInfoSettings(text: label, textStyle: H3GrayTextStyle),
        categoryItemOverlaySettings: CategoryItemOverlaySettings(
            defaultTextStyle: H3GrayTextStyle,
            selectedTextStyle: H3GrayTextStyle,
            extraInfoTextStyle: H3GrayTextStyle),
        categoryNameModalSettings: CategoryNameModalSettings(
          textStyle: H4GrayTextStyle,alignmentGeometry: Alignment.centerRight
        ),
        searchBarModalSettings: const SearchBarModalSettings(heightReplacement: 45),
        doneButtonModalSettings:
            DoneButtonModalSettings(title: 'تم', textStyle: H4WhiteTextStyle,titlePadding: EdgeInsets.symmetric(horizontal: 0.1.sw,vertical: 0.03.sw)),
        categoryItemModalSettings: CategoryItemModalSettings(
          defaultTextStyle: H3GrayTextStyle,
          textOverflow: TextOverflow.ellipsis,
          selectedTextStyle: H3RedTextStyle,
          extraInfoTextStyle: H3GrayTextStyle,
          margin: EdgeInsets.symmetric(vertical: 0.001.sh),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
    );
  }
}
