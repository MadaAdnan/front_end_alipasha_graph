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
      name: "${data['name']??''}",
      phone: "${data['phone']??''}",
      email: "${data['email']??''}",
      face: "${data['face']??''}",
      instagram: "${data['instagram']??''}",
      linkedin: "${data['linkedin']??''}",
      sub_email: "${data['sub_email']??''}",
      sub_phone: "${data['sub_phone']??''}",
      telegram: "${data['telegram']??''}",
      twitter: "${data['twitter']??''}",
      youtube: "${data['youtube']??''}",
      tiktok: "${data['tiktok']??''}",
    );
  }
}
