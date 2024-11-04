import 'package:ali_pasha_graph/models/city_model.dart';
import 'package:ali_pasha_graph/models/community_model.dart';
import 'package:ali_pasha_graph/models/plan_model.dart';
import 'package:ali_pasha_graph/models/product_model.dart';
import 'package:ali_pasha_graph/models/social_model.dart';

class UserModel {
  int? id;
  String? name;
  String? seller_name;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? logo;
  String? email_verified_at;
  String? open_time;
  String? close_time;
  bool? is_delivery;
  bool? is_restaurant;
  bool? is_active;
  bool? is_seller;
  String? affiliate;
  bool? is_verified;
  String? id_color;
  String? info;
  String? customImg;
  String? level;
  List<ProductModel>? products;
  List<FollowerModel>? followers;
  List<PlanModel>? plans;
  CityModel? city;
  bool? is_special;
  bool? trust;
  double? totalBalance;
  double? totalPoint;
  int? followingCount;
  int? total_views;
  List<DataImageModel>? gallery;
  bool? can_create_group;
  bool? can_create_channel;
  int? unread_notifications_count;
  List<CommunityModel>? communities;
  SocialModel? social;

  UserModel({
    this.name,
    this.id,
    this.seller_name,
    this.email,
    this.email_verified_at,
    this.phone,
    this.address,
    this.image,
    this.logo,
    this.open_time,
    this.close_time,
    this.is_active,
    this.is_delivery,
    this.is_restaurant,
    this.is_special,
    this.affiliate,
    this.info,
    this.city,
    this.products,
    this.plans,
    this.customImg,
    this.totalBalance,
    this.totalPoint,
    this.level,
    this.followers,
    this.followingCount,
    this.is_seller,
    this.id_color,
    this.is_verified = false,
    this.social,
    this.total_views,
    this.trust,
    this.gallery,
    this.can_create_channel,
    this.can_create_group,
    this.unread_notifications_count,
    this.communities,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    List<ProductModel> listProducts = [];
    List<CommunityModel> listCommunities = [];
    List<PlanModel> listPlans = [];
    List<DataImageModel> listGallery = [];
    List<FollowerModel> listFollowers = [];
    if (data['communities'] != null) {
      for (var item in data['communities']) {
        listCommunities.add(CommunityModel.fromJson(item));
      }
    }
    if (data['products'] != null) {
      for (var item in data['products']) {
        listProducts.add(ProductModel.fromJson(item));
      }
    }
    if (data['plans'] != null) {
      for (var item in data['plans']) {
        listPlans.add(PlanModel.fromJson(item));
      }
    }
    if (data['followers'] != null) {
      for (var item in data['followers']) {
        listFollowers.add(FollowerModel.fromJson(item));
      }
    }
    if (data['gallery'] != null) {
      for (var item in data['gallery']) {
        listGallery.add(DataImageModel.fromJson(item));
      }
    }

    return UserModel(
      id: int.tryParse("${data['id']}"),
      followingCount: int.tryParse("${data['following_count']}") ?? 0,
      total_views: int.tryParse("${data['total_views']}") ?? 0,
      unread_notifications_count:
          int.tryParse("${data['unread_notifications_count']}") ?? 0,
      info: "${data['info'] ?? ''}",
      affiliate: "${data['affiliate'] ?? ''}",
      is_special: bool.tryParse("${data['is_special']}") ?? false,
      trust: bool.tryParse("${data['trust']}") ?? false,
      is_verified: bool.tryParse("${data['is_verified']}") ?? false,
      can_create_group: bool.tryParse("${data['can_create_group']}") ?? false,
      can_create_channel:
          bool.tryParse("${data['can_create_channel']}") ?? false,
      is_restaurant: bool.tryParse("${data['is_restaurant']}") ?? false,
      is_delivery: bool.tryParse("${data['is_delivery']}") ?? false,
      is_active: bool.tryParse("${data['is_active']}") ?? false,
      is_seller: bool.tryParse("${data['is_seller']}") ?? false,
      close_time: "${data['close_time'] ?? ''}",
      open_time: "${data['open_time'] ?? ''}",
      id_color: "${data['id_color'] ?? ''}",
      image: "${data['image'] ?? ''}",
      address: "${data['address'] ?? ''}",
      phone: "${data['phone'] ?? ''}",
      email: "${data['email'] ?? ''}",
      seller_name: "${data['seller_name'] ?? ''}",
      name: "${data['name'] ?? ''}",
      logo: "${data['logo'] ?? ''}",
      customImg: "${data['custom'] ?? ''}",
      level: "${data['level']}",
      totalBalance: double.tryParse("${data['total_balance']}") ?? 0,
      totalPoint: double.tryParse("${data['total_point']}") ?? 0,
      email_verified_at: "${data['email_verified_at'] ?? ''}",
      city: data['city'] != null ? CityModel.fromJson(data['city']) : null,
      social:
          data['social'] != null ? SocialModel.fromJson(data['social']) : null,
      products: listProducts.toList(),
      plans: listPlans.toList(),
      followers: listFollowers.toList(),
      gallery: listGallery.toList(),
      communities: listCommunities,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'name': name,
      'id': id,
      'seller_name': seller_name,
      'email': email,
      'email_verified_at': email_verified_at,
      'phone': phone,
      'address': address,
      'image': image,
      'logo': logo,
      "id_color": id_color,
      "is_verified": is_verified,
      'open_time': open_time,
      'close_time': close_time,
      'is_active': is_active,
      'is_delivery': is_delivery,
      'is_restaurant': is_restaurant,
      'is_special': is_special,
      'affiliate': affiliate,
      'info': info,
      'city': city?.toJson(),
      'plans': plans?.map((el) => el.toJson()).toList() ?? [],
      // this.customImg,
      'total_balance': totalBalance,
      'total_point': totalPoint,
      'level': level,
      'followers': followers?.map((el) => el.tojson()).toList() ?? [],
      "following_count": followingCount
    };
    return data;
  }
}

class FollowerModel {
  UserModel? user;
  UserModel? seller;

  FollowerModel({this.seller, this.user});

  factory FollowerModel.fromJson(Map<String, dynamic> data) {
    return FollowerModel(
        user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
        seller:
            data['seller'] != null ? UserModel.fromJson(data['seller']) : null);
  }

  tojson() {
    Map<String, dynamic> data = {
      "user": user?.toJson(),
      "seller": seller?.toJson()
    };
    return data;
  }
}
