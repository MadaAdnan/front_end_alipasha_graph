import 'package:ali_pasha_graph/models/category_model.dart';
import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/comment_model.dart';
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

  List<ColorModel>? colors;

  List<CommentModel>? comments;
  String? name;
  String? info;
  String? expert;
  String? active;
  List<dynamic>? tags;
  bool? is_discount;
  bool? is_vote;

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
  List<String> images;

  List<String> docs;
  List<DataImageModel>? listOfImages;
  TurkeyPrice? turkey_price;
  List<DataImageModel>? listOfDocs;
  List<AttributeProducts>? attributes;
  String? created_at;
  String? updated_at;
    double? vote_avg;
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
    this.docs = const <String>[],
    this.end_date,
    this.expert,
    this.images = const <String>[],
    this.is_available,
    this.is_delivary,
    this.latitude,
    this.level,
    this.listOfDocs,
    this.listOfImages,
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
    this.turkey_price,
    this.colors,
    this.comments,
    this.attributes,
    this.is_vote,
    this.vote_avg,
    this.updated_at,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    List<ColorModel> listColor = [];
    List<AttributeProducts> listAttr = [];
    List<DataImageModel> listOfDocsList = [];
    List<DataImageModel> listOfImagesList = [];
    if (data['colors'] != null) {
      for (var item in data['colors']) {
        listColor.add(ColorModel.fromJson(item));
      }
    }

    if (data['listOfDocs'] != null) {
      for (var item in data['listOfDocs']) {
        listOfDocsList.add(DataImageModel.fromJson(item));
      }
    }
    if (data['listOfImages'] != null) {
      for (var item in data['listOfImages']) {
        listOfImagesList.add(DataImageModel.fromJson(item));
      }
    }

    if (data['attributes'] != null) {
      for (var item in data['attributes']) {
        listAttr.add(AttributeProducts.fromJson(item));
      }
    }
    List<CommentModel> listComments = [];
    /* if (data['comments'] != null) {
      for (var item in data['comments']) {
        listComments.add(CommentModel.fromJson(item));
      }
    }*/
    return ProductModel(
      comments: listComments,
      id: int.tryParse("${data['id']}"),
      images: List.from(data['images'] ?? []),
      name: "${data['name'] ?? ''}",
      active: "${data['active'] ?? ''}",
      is_special: bool.tryParse("${data['is_special']}") ?? false,
      is_available: bool.tryParse("${data['is_available']}") ?? false,
      is_vote: bool.tryParse("${data['is_rate']}") ?? false,
      views_count: "${data['views_count'] ?? 0}",
      expert: "${data['expert'] ?? ''}",
      level: "${data['level'] ?? ''}",
      type: "${data['type'] ?? ''}",
      image: "${data['image'] ?? ''}",
      category: data['category'] != null
          ? CategoryModel.fromJson(data['category'])
          : null,
      colors: listColor,
      sub1: data['sub1'] != null ? CategoryModel.fromJson(data['sub1']) : null,
      sub2: data['sub2'] != null ? CategoryModel.fromJson(data['sub2']) : null,
      sub3: data['sub3'] != null ? CategoryModel.fromJson(data['sub3']) : null,
      price: double.tryParse("${data['price']}") ?? 0,
      vote_avg: double.tryParse("${data['vote_avg']}") ?? 0,
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      city: data['city'] != null ? CityModel.fromJson(data['city']) : null,
      info: "${data['info'] ?? ''}",
      url: "${data['url'] ?? ''}",
      is_discount: bool.tryParse("${data['is_discount']}") ?? false,
      discount: double.tryParse("${data['discount']}") ?? 0,
      address: "${data['address'] ?? ''}",
      code: "${data['code'] ?? ''}",
      created_at: "${data['created_at'] ?? ''}",
      updated_at: "${data['updated_at'] ?? ''}",
      docs: List.from(data['docs'] ?? []),
      email: "${data['email'] ?? ''}",
      end_date: "${data['end_date'] ?? ''}",
      start_date: "${data['start_date'] ?? ''}",
      is_delivary: bool.tryParse("${data['is_delivary']}") ?? false,
      latitude: "${data['latitude'] ?? ''}",
      longitude: "${data['longitude'] ?? ''}",
      phone: "${data['phone'] ?? ''}",
      tags: data['tags'] ?? [],
      sub4: data['sub4'] != null ? CategoryModel.fromJson(data['sub4']) : null,
      turkey_price: data['turkey_price'] != null
          ? TurkeyPrice.fromJson(data['turkey_price'])
          : null,
      video: "${data['video'] ?? ''}",
      listOfDocs: listOfDocsList,
      attributes: listAttr,
      listOfImages: listOfImagesList,
    );
  }

  toJson() {
    return {'video': video, "expert": expert,"name":name,"info":info};
  }
}

class DataImageModel {
  int? id;
  String? url;

  DataImageModel({this.id, this.url});

  factory DataImageModel.fromJson(Map<String, dynamic> data) {
    return DataImageModel(
        id: int.tryParse("${data['id']}"), url: "${data['url'] ?? ''}");
  }
}

class TurkeyPrice {
  double? price;
  double? discount;

  TurkeyPrice({this.price, this.discount});

  factory TurkeyPrice.fromJson(Map<String, dynamic> data) {
    return TurkeyPrice(
        discount: double.tryParse("${data['discount'] ?? 0}"),
        price: double.tryParse("${data['price'] ?? 0}"));
  }
}

class ColorModel {
  int? id;
  String? code;
  String? name;

  ColorModel({this.id, this.code, this.name});

  factory ColorModel.fromJson(Map<String, dynamic> data) {
    return ColorModel(
      id: int.tryParse("${data['id']}"),
      code: "${data['code']}",
      name: "${data['name']}",
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$name";
  }
}

class AttributeProducts {
  int? attributeId;
  int? productId;
  String? value;

  AttributeProducts({this.productId, this.attributeId, this.value});

  AttributeProducts.fromJson(Map<String, dynamic> data) {
    attributeId = int.tryParse("${data['attribute_id']}");
    productId = int.tryParse("${data['product_id']}");
    value = "${data['product_id'] ?? ''}";
  }
}
