class PlanModel {
  int? id;
  double? price;

  String? name;
  bool? is_discount;

  double? discount;
  String? type;

  String? info;
  List<PlanItem>? items;
  String? duration;
  int? special_count;
  int? products_count;
  int? ads_count;
  bool? special_store;

  PlanUserPivot? pivot;

  PlanModel({
    this.id,
    this.name,
    this.info,
    this.discount,
    this.is_discount,
    this.items,
    this.pivot,
    this.price,
    this.type,
    this.ads_count,
    this.duration,
    this.products_count,
    this.special_count,
    this.special_store,
  });

  factory PlanModel.fromJson(Map<String, dynamic> data) {
    List<PlanItem> listItem = [];
    if (data['items'] != null) {
      for (var item in data['items']) {
        listItem.add(PlanItem.fromJson(item));
      }
      listItem.insert(0, PlanItem(active: (int.tryParse("${data['products_count']}") ?? 0) >0,item:" نشر ${ (int.tryParse("${data['products_count']}") ?? 0)} منتج / منتجات شهرياً" ));
      listItem.insert(0, PlanItem(active: (int.tryParse("${data['special_count']}") ?? 0) >0,item:"عدد المنتجات المميزة ${int.tryParse("${data['special_count']}")}" ));
      listItem.insert(0, PlanItem(active: (int.tryParse("${data['ads_count']}") ?? 0) >0,item:" عدد الإعلانات ${int.tryParse("${data['ads_count']}")}"));
      listItem.insert(0, PlanItem(active: bool.tryParse("${data['special_store']}")??false,item:"متجر مميز"));

    }
    listItem.sort((a, b) {
      if (a.active! && !b.active!) {
        return -1; // a يأتي قبل b
      } else if (!a.active! && b.active!) {
        return 1; // b يأتي قبل a
      } else {
        return 0; // لا يوجد تغيير في الترتيب
      }
    });
    return PlanModel(
      id: int.tryParse("${data['id']}"),
      name: "${data['name']}",
      discount: double.tryParse("${data['discount']}") ?? 0,
      price: double.tryParse("${data['price']}") ?? 0,
      info: "${data['info']}",
      is_discount: bool.tryParse("${data['is_discount']}"),
      items: listItem.toList(),
      duration: "${data['duration']}",
      type: "${data['type']}",
      special_store: bool.tryParse("${data['special_store']}"),
      ads_count: int.tryParse("${data['ads_count']}") ?? 0,
      special_count: int.tryParse("${data['special_count']}") ?? 0,
      products_count: int.tryParse("${data['products_count']}") ?? 0,
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
        active: bool.tryParse("${data['active']}")??false, item: "${data['item']}");
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['active'] = active;
    data['item'] = item;

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
