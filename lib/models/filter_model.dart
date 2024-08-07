class FilterModel {
  String? search;
  int? categoryId;
  int? sub1Id;
  int? cityId;
  int? sellerId;
  String? type;
  double? startPrice;
  double? endPrice;
  List<int>? colors;

  FilterModel({
    this.colors,
    this.search,
    this.categoryId,
    this.sub1Id,
    this.cityId,
    this.type,
    this.sellerId,
    this.startPrice,
    this.endPrice,
  });
}
