import 'package:ali_pasha_graph/models/user_model.dart';
import 'package:logger/logger.dart';

class CommentModel {
  int? id;
  int? productId;
  String? comment;
  UserModel? user;
  String? createdAt;
List<CommentModel>? comments;
  CommentModel({this.id, this.user, this.comment,this.createdAt,this.comments,this.productId});

  factory CommentModel.fromJson(Map<String, dynamic> data) {

      Logger().i(data);

    List<CommentModel> commentsList=[];
    if(data['comments']!=null){
      for(var item in data['comments'] ){
        commentsList.add(CommentModel.fromJson(item));
      }
    }
    return CommentModel(
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      comment: "${data['comment']??''}",
      id: int.tryParse("${data['id']}"),
      productId: int.tryParse("${data['product_id']}"),
      createdAt: "${data['created_at']??''}",
      comments: commentsList
    );
  }
}
