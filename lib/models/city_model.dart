class CityModel {
  int? id;
  String? name;
  String? image;
  bool? isDelivery;
  int? cityId;

  CityModel({this.name, this.image, this.id, this.cityId, this.isDelivery});

  factory CityModel.fromJson(Map<String, dynamic> data) {
    return CityModel(
        id: int.tryParse("${data['id']}"),
        cityId: int.tryParse("${data['city_id']}"),
        image: "${data['image']}",
        name: "${data['name']}",
        isDelivery: bool.tryParse("${data['is_delivery']}"));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {'id': id, 'name': name, 'image': image,'city_id':cityId,'is_delivery':isDelivery};
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$name";
  }
}
