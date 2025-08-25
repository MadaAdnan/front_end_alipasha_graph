import 'package:logger/logger.dart';

class SocialModel {
  String? twitter;
  String? face;
  String? instagram;
  String? youtube;
  String? linkedin;
  String? telegram;
  String? name;
  String? email;
  String? sub_email;
  String? phone;
  String? sub_phone;
  String? tiktok;

  SocialModel({
    this.name,
    this.phone,
    this.email,
    this.face,
    this.instagram,
    this.linkedin,
    this.sub_email,
    this.sub_phone,
    this.telegram,
    this.twitter,
    this.youtube,
    this.tiktok,
  });

  factory SocialModel.fromJson(Map<String,dynamic> data){

    return SocialModel(
      name: "${data['name'] ?? ''}",
      phone: "${data['phone'] ?? ''}",
      email: "${data['email'] ?? ''}",
      face: "${data['face'] ?? ''}",
      instagram: "${data['instagram'] ?? ''}",
      linkedin: "${data['linkedin'] == null ||
          data['linkedin']?.toString().toLowerCase() == 'null'
          ? data['linkedin']
          : ''}",
      sub_email: "${data['sub_email'] == null ||
          data['sub_email']?.toString().toLowerCase() == 'null'
          ? data['sub_email']
          : ''}",
      sub_phone: "${data['sub_phone'] == null ||
          data['sub_phone']?.toString().toLowerCase() == 'null'
          ? data['sub_phone']
          : ''}",
      telegram: "${data['telegram'] == null ||
          data['telegram']?.toString().toLowerCase() == 'null'
          ? data['telegram']
          : ''}",
      twitter: "${data['twitter'] == null ||
          data['twitter']?.toString().toLowerCase() == 'null'
          ? data['twitter']
          : ''}",
      youtube: "${data['youtube'] == null ||
          data['youtube']?.toString().toLowerCase() == 'null'
          ? data['youtube']
          : ''}",
      tiktok: "${data['tiktok'] == null ||
          data['tiktok']?.toString().toLowerCase() == 'null'
          ? data['tiktok']
          : ''}",
    );
  }
    toJson(){
      return {
        'face':this.face,
        'instagram':this.instagram,
        'youtube':this.youtube,
        'tiktok':this.tiktok,
        'twitter':this.twitter,
        'telegram':this.telegram,
      };
    }



}
