class CityModel {
  int? id;
  String? name;
  String? image;
  bool? isDelivery;
  bool? isMain;
  int? cityId;
  int? level;
  String? code;
  List<CityModel>? children;
  double? latitude;
  double? longitude;
  CityModel(
      {this.name,
      this.image,
      this.id,
      this.cityId,
      this.isDelivery,
      this.children,
      this.isMain,
      this.code,
      this.level,
      this.latitude,
      this.longitude});

  factory CityModel.fromJson(Map<String, dynamic> data) {
    List<CityModel> listCities = [];
    if (data['children'] != null) {
      for (var item in data['children']) {
        listCities.add(CityModel.fromJson(item));
      }
    }
    return CityModel(
      id: int.tryParse("${data['id']}"),
      cityId: int.tryParse("${data['city_id']}"),
      image: "${data['image']}",
      name: "${data['name']}",
      isDelivery: bool.tryParse("${data['is_delivery']}"),
      latitude: double.tryParse("${data['latitude']}")??33.5151444,
      longitude: double.tryParse("${data['longitude']}")??36.3931354,
      isMain: bool.tryParse("${data['is_main']}"),
      children: listCities,
      code: "${data['code_city']}",
      level: int.tryParse("${data['level']}"),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'image': image,
      'city_id': cityId,
      'is_delivery': isDelivery,
      'level': level,
      'code_city': code
    };
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$name";
  }
}
