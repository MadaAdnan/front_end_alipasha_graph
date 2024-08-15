import 'package:ali_pasha_graph/models/user_model.dart';

class MessageCommunityModel {
  UserModel? user;
  String? message;
  String? attach;
  String? createdAt;

  MessageCommunityModel({this.user, this.attach, this.message, this.createdAt});

  factory MessageCommunityModel.fromJson(Map<String, dynamic> data) {
    return MessageCommunityModel(
        user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
        createdAt: "${data['created_at'] ?? ''}",
        message: "${data['message'] ?? ''}",
        attach: "${data['attach'] ?? ''}");
  }
}
