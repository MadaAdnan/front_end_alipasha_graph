import 'package:ali_pasha_graph/models/user_model.dart';

class CommentModel {
  int? id;
  String? comment;
  UserModel? user;
  String? createdAt;

  CommentModel({this.id, this.user, this.comment,this.createdAt});

  factory CommentModel.fromJson(Map<String, dynamic> data) {
    return CommentModel(
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      comment: "${data['comment']??''}",
      id: int.tryParse("${data['id']}"),
      createdAt: "${data['created_at']??''}",
    );
  }
}
