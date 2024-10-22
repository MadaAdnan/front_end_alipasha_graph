import 'package:ali_pasha_graph/models/social_model.dart';
import 'package:ali_pasha_graph/models/user_model.dart';

class SettingModel {
  SocialModel? social;
  String? address;
  double? longitude;
  double? latitude;
  String? weather_api;
  String? current_version;
  bool? force_upgrade;
  String? advice_url;
  bool? active_advice;
  String? delivery_service;
  String? msg_delivery;
  bool? auto_update_exchange;
  String? dollar_value;
  String? less_amount_point_pull;
  String? about;
  String? privacy;
  bool? active_live;
  String? live_id;
  List<MaterialSetting>? material_izaz;
  List<MaterialSetting>? material_idlib;
  ExchangeGold? gold;

  ExchangeCur? dollar;
  String? createdAt;
  UserModel? delivery;
  UserModel? support;
  UrlDownload? urlDownload;

  SettingModel({
    this.longitude,
    this.about,
    this.active_advice,
    this.active_live,
    this.address,
    this.advice_url,
    this.auto_update_exchange,
    this.current_version,
    this.delivery_service,
    this.dollar_value,
    this.force_upgrade,
    this.latitude,
    this.less_amount_point_pull,
    this.live_id,
    this.msg_delivery,
    this.privacy,
    this.social,
    this.weather_api,
    this.material_idlib,
    this.material_izaz,
    this.gold,
    this.dollar,
    this.createdAt,
    this.support,
    this.delivery,
    this.urlDownload
  });

  factory SettingModel.fromJson(Map<String, dynamic> data) {
    List<MaterialSetting> listIdlib = [];
    List<MaterialSetting> listIzaz = [];
    if (data['material_izaz'] != null) {
      for (var item in data['material_izaz']) {
        listIzaz.add(MaterialSetting.fromJson(item));
      }
    }

    if (data['material_idlib'] != null) {
      for (var item in data['material_idlib']) {
        listIdlib.add(MaterialSetting.fromJson(item));
      }
    }

    return SettingModel(
      longitude: double.tryParse("${data['longitude']}"),
      latitude: double.tryParse("${data['latitude']}"),
      address: "${data['address'] ?? ''}",
      about: "${data['about'] ?? ''}",
      active_advice: bool.tryParse("${data['active_advice'] ?? ''}") ?? false,
      active_live: bool.tryParse("${data['active_live'] ?? ''}") ?? false,
      auto_update_exchange:
          bool.tryParse("${data['auto_update_exchange'] ?? ''}") ?? false,
      force_upgrade: bool.tryParse("${data['force_upgrade'] ?? ''}") ?? false,
      advice_url: "${data['advice_url'] ?? ''}",
      current_version: "${data['current_version'] ?? ''}",
      delivery_service: "${data['delivery_service'] ?? ''}",
      dollar_value: "${data['dollar_value'] ?? ''}",
      less_amount_point_pull: "${data['less_amount_point_pull'] ?? ''}",
      live_id: "${data['live_id'] ?? ''}",
      msg_delivery: "${data['msg_delivery'] ?? ''}",
      privacy: "${data['privacy'] ?? ''}",
      social:
          data['social'] != null ? SocialModel.fromJson(data['social']) : null,
      weather_api: "${data['weather_api'] ?? ''}",
      material_idlib: listIdlib,
      material_izaz: listIzaz,
      gold: data['gold'] != null ? ExchangeGold.fromJson(data['gold']) : null,
      dollar:
          data['dollar'] != null ? ExchangeCur.fromJson(data['dollar']) : null,
      createdAt: "${data['created_at'] ?? ''}",
      delivery: data['delivery'] != null
          ? UserModel.fromJson(data['delivery'])
          : null,
      support:
          data['support'] != null ? UserModel.fromJson(data['support']) : null,
      urlDownload:
      data['url_for_download'] != null ? UrlDownload.fromJson(data['url_for_download']) : null,
    );
  }
}

class Sale {
  String? bay;
  String? sale;

  Sale({this.bay, this.sale});

  factory Sale.fromJson(Map<String, dynamic> data) {
    return Sale(
      bay: "${data['bay'] ?? ''}",
      sale: "${data['sale'] ?? ''}",
    );
  }
}

class MaterialSetting {
  String? name;
  String? bay;
  String? sale;

  MaterialSetting({this.bay, this.sale, this.name});

  factory MaterialSetting.fromJson(Map<String, dynamic> data) {
    return MaterialSetting(
      name: "${data['name'] ?? ''}",
      bay: "${data['bay'] ?? ''}",
      sale: "${data['sale'] ?? ''}",
    );
  }
}

class ExchangeGold {
  GoldModel? izaz;
  GoldModel? idlib;

  ExchangeGold({this.idlib, this.izaz});

  factory ExchangeGold.fromJson(Map<String, dynamic> data) {
    return ExchangeGold(
      idlib: data['idlib'] != null ? GoldModel.fromJson(data['idlib']) : null,
      izaz: data['izaz'] != null ? GoldModel.fromJson(data['izaz']) : null,
    );
  }
}

class ExchangeCur {
  DollarModel? izaz;
  DollarModel? idlib;

  ExchangeCur({this.idlib, this.izaz});

  factory ExchangeCur.fromJson(Map<String, dynamic> data) {
    return ExchangeCur(
      idlib: data['idlib'] != null ? DollarModel.fromJson(data['idlib']) : null,
      izaz: data['izaz'] != null ? DollarModel.fromJson(data['izaz']) : null,
    );
  }
}

class GoldModel {
  Sale? gold24;
  Sale? gold21;
  Sale? gold18;
  Sale? sliver;

  GoldModel({this.gold18, this.gold21, this.gold24, this.sliver});

  factory GoldModel.fromJson(Map<String, dynamic> data) {
    return GoldModel(
      gold24: data['gold24'] != null ? Sale.fromJson(data['gold24']) : null,
      gold21: data['gold21'] != null ? Sale.fromJson(data['gold21']) : null,
      gold18: data['gold18'] != null ? Sale.fromJson(data['gold18']) : null,
      sliver: data['sliver'] != null ? Sale.fromJson(data['sliver']) : null,
    );
  }
}

class DollarModel {
  Sale? usd;
  Sale? eur;
  Sale? syr;

  DollarModel({this.eur, this.syr, this.usd});

  factory DollarModel.fromJson(Map<String, dynamic> data) {
    return DollarModel(
      eur: data['eur'] != null ? Sale.fromJson(data['eur']) : null,
      usd: data['usd'] != null ? Sale.fromJson(data['usd']) : null,
      syr: data['syr'] != null ? Sale.fromJson(data['syr']) : null,
    );
  }
}

class UrlDownload {
  String? up_down;
  String? play;
  String? direct;

  UrlDownload({this.play, this.up_down,this.direct});

  factory UrlDownload.fromJson(Map<String, dynamic> data) {
    return UrlDownload(
      play: "${data['play']}",
      up_down: "${data['up_down']}",
      direct: "${data['direct']}",
    );
  }
}
