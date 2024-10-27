import 'package:ali_pasha_graph/models/city_model.dart';

class PartnerModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? image;
  CityModel? city;
  String? info;

  PartnerModel(
      {this.id, this.name, this.phone, this.address, this.image, this.city,this.info});

  PartnerModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse("${json['id']}");
    name = "${json['name'] ?? ''}";
    phone = "${json['phone'] ?? ''}";
    address = "${json['address'] ?? ''}";
    info = "${json['info'] ?? ''}";
    image = "${json['image'] ?? ''}";
    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
  }
}
