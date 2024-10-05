import 'package:ali_pasha_graph/models/user_model.dart';

class MessageModel {
  UserModel? user;
  String? body;
  String? attach;
  String? type;
  String? createdAt;

  MessageModel({this.user, this.attach, this.body, this.createdAt,this.type});

  factory MessageModel.fromJson(Map<String, dynamic> data) {
    return MessageModel(
        user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
        createdAt: "${data['created_at'] ?? ''}",
        body: "${data['body'] ?? ''}",
        type: "${data['type'] ?? ''}",
        attach: "${data['attach'] ?? ''}");
  }
}
