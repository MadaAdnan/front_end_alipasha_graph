import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

class ProductModel {
  int? id;

  UserModel? user;
  CityModel? city;

  CategoryModel? category;
  CategoryModel? sub1;
  CategoryModel? sub2;
  CategoryModel? sub3;
  CategoryModel? sub4;

  /*colors
  comments*/
  String? name;
  String? info;
  String? expert;
  String? active;
  List<String>? tags;
  bool? is_discount;

  bool? is_delivary;
  bool? is_available;
  bool? is_special;

  String? level;
  String? phone;

  String? email;
  String? address;
  String? views_count;

  String? url;
  String? longitude;

  String? latitude;
  double? price;

  double? discount;
  String? start_date;

  String? end_date;
  String? code;

  String? type;
  String? image;

  String? video;
  List<String>? images;

  List<String>? docs;
  List<DataImageModel>? liistOfImages;

  List<DataImageModel>? liistOfDocs;

  String? created_at;

  ProductModel({
    this.type,
    this.price,
    this.is_discount,
    this.discount,
    this.info,
    this.name,
    this.id,
    this.city,
    this.image,
    this.email,
    this.phone,
    this.address,
    this.url,
    this.code,
    this.created_at,
    this.docs,
    this.end_date,
    this.expert,
    this.images,
    this.is_available,
    this.is_delivary,
    this.latitude,
    this.level,
    this.liistOfDocs,
    this.liistOfImages,
    this.longitude,
    this.start_date,
    this.tags,
    this.user,
    this.video,
    this.views_count,
    this.category,
    this.sub1,
    this.sub2,
    this.sub3,
    this.sub4,
    this.is_special,
    this.active,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: int.tryParse("${data['id']}"),
      name: "${data['name'] ?? ''}",
      active: "${data['active'] ?? ''}",
      is_special: bool.tryParse("${data['is_special']}") ?? false,
      is_available: bool.tryParse("${data['is_available']}") ?? false,
      views_count: "${data['views_count'] ?? 0}",
      expert: "${data['expert'] ?? ''}",
      level: "${data['level'] ?? ''}",
      type: "${data['type'] ?? ''}",
      image: "${data['image'] ?? ''}",
      category: data['category'] != null
          ? CategoryModel.fromJson(data['category'])
          : null,
      sub1: data['sub1'] != null ? CategoryModel.fromJson(data['sub1']) : null,
      sub2: data['sub2'] != null ? CategoryModel.fromJson(data['sub2']) : null,
      sub3: data['sub3'] != null ? CategoryModel.fromJson(data['sub3']) : null,
      price: double.tryParse("${data['price']}" ?? '0'),
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      city: data['city'] != null ? CityModel.fromJson(data['city']) : null,
    );
  }
}

class DataImageModel {
  int? id;
  String? url;

  DataImageModel({this.id, this.url});

  factory DataImageModel.fromJson(Map<String, dynamic> data) {
    return DataImageModel(id: data['id'], url: data['url']);
  }
}
