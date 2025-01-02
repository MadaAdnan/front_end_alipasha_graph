class CityModel {
  int? id;
  String? name;
  String? image;
  bool? isDelivery;
  bool? isMain;
  int? cityId;
  List<CityModel>? children;

  CityModel(
      {this.name,
      this.image,
      this.id,
      this.cityId,
      this.isDelivery,
      this.children,
      this.isMain});

  factory CityModel.fromJson(Map<String, dynamic> data) {
    List<CityModel> listCities = [];
    if(data['children']!=null){
      for(var item in data['children']){
        listCities.add(CityModel.fromJson(item));
      }
    }
    return CityModel(
      id: int.tryParse("${data['id']}"),
      cityId: int.tryParse("${data['city_id']}"),
      image: "${data['image']}",
      name: "${data['name']}",
      isDelivery: bool.tryParse("${data['is_delivery']}"),
      isMain: bool.tryParse("${data['is_main']}"),
      children: listCities,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'image': image,
      'city_id': cityId,
      'is_delivery': isDelivery
    };
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$name";
  }
}
