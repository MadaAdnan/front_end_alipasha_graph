class PlanModel {
  int? id;
  double? price;

  String? name;
  bool? is_discount;

  double? discount;
  String? type;

  String? info;
  List<PlanItem>? items;

  PlanOption? options;
  PlanUserPivot? pivot;

  PlanModel({
    this.id,
    this.name,
    this.info,
    this.discount,
    this.is_discount,
    this.items,
    this.options,
    this.pivot,
    this.price,
    this.type,
  });

  factory PlanModel.fromJson(Map<String, dynamic> data) {
    List<PlanItem> listItem = [];
    if (data['items'] != null) {
      for (var item in data['items']) {
        listItem.add(PlanItem.fromJson(item));
      }
    }
    return PlanModel(
      id: int.tryParse("${data['id']}"),
      name: "${data['name']}",
      discount: double.tryParse("${data['discount']}") ?? 0,
      price: double.tryParse("${data['price']}") ?? 0,
      info: "${data['info']}",
      is_discount: bool.tryParse("${data['is_discount']}"),
      items: listItem.toList(),
      options:
          data['options'] != null ? PlanOption.fromJson(data['options']) : null,
      pivot:
          data['pivot'] != null ? PlanUserPivot.fromJson(data['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['info'] = info;
    data['pivot'] = pivot?.toJson();

    return data;
  }
}

class PlanItem {
  bool? active;
  String? item;

  PlanItem({this.active, this.item});

  factory PlanItem.fromJson(Map<String, dynamic> data) {
    return PlanItem(
        active: bool.tryParse("${data['active']}"), item: "${data['item']}");
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['active'] = active;
    data['item'] = item;

    return data;
  }
}

class PlanOption {
  int? ads;
  int? slider;
  int? special;

  PlanOption({this.ads, this.slider, this.special});

  factory PlanOption.fromJson(Map<String, dynamic> data) {
    return PlanOption(
      ads: int.tryParse("${data['ads']}"),
      slider: int.tryParse("${data['slider']}"),
      special: int.tryParse("${data['special']}"),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['ads'] = ads;
    data['slider'] = slider;
    data['special'] = special;

    return data;
  }
}

class PlanUserPivot {
  String? expired_date;
  String? subscription_date;

  PlanUserPivot({this.expired_date, this.subscription_date});

  factory PlanUserPivot.fromJson(Map<String, dynamic> data) {
    return PlanUserPivot(
      subscription_date: "${data['subscription_date']}",
      expired_date: "${data['expired_date']}",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['subscription_date'] = subscription_date;
    data['expired_date'] = expired_date;

    return data;
  }
}
