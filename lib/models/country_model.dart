class CountryModel{
  int? id;
  String? name;
  String? code;
  String? img;
  CountryModel({this.name,this.code,this.id,this.img});
  factory CountryModel.fromJson(Map<String, dynamic> data){
    return CountryModel(
      code: "${data['code'] ??''}",
      name: "${data['name'] ??''}",
      img: "${data['image'] ??''}",
      id: int.tryParse("${data['id']}")
    );
  }
}